use crate::service::hub::{
    ensure_core_sha256_configured, log_message, release_managed_core_on_shutdown, routes,
};

use anyhow::{bail, Context, Result};
use std::ffi::{OsStr, OsString};
use std::fs;
use std::future::Future;
use std::io::{Error, ErrorKind, Seek, SeekFrom};
use std::os::unix::fs::{FileTypeExt, MetadataExt, OpenOptionsExt, PermissionsExt};
use std::path::{Path, PathBuf};
use std::pin::Pin;
use std::process::{Command, Stdio};
use std::task::{Context as TaskContext, Poll};
use std::time::Duration;
use tokio::net::{UnixListener, UnixStream};
use tokio::runtime::Runtime;
use tokio::signal::unix::{signal, SignalKind};
use tokio::time::Sleep;
use tokio_stream::Stream;

const INSTALL_ROOT: &str = "/usr/local/libexec/flclash";
const SERVICE_NAME: &str = "flclash-helper";
const UNIT_PATH: &str = "/etc/systemd/system/flclash-helper.service";
const RUNTIME_DIR_NAME: &str = "flclash";
const SOCKET_PATH: &str = "/run/flclash/helper.sock";
const OWNER_UID_ENV: &str = "FLCLASH_HELPER_OWNER_UID";
const OWNER_GID_ENV: &str = "FLCLASH_HELPER_OWNER_GID";
const SOCKET_MODE: u32 = 0o660;
const ACCEPT_RETRY_DELAY: Duration = Duration::from_secs(1);

#[derive(Debug, PartialEq, Eq)]
enum ServiceCommand {
    Run,
    Install,
    Uninstall,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Owner {
    uid: u32,
    gid: u32,
}

pub fn main() -> Result<()> {
    match service_command(std::env::args_os().skip(1))? {
        ServiceCommand::Run => run_service(),
        ServiceCommand::Install => install_service(),
        ServiceCommand::Uninstall => uninstall_service(),
    }
}

fn service_command(args: impl IntoIterator<Item = OsString>) -> Result<ServiceCommand> {
    let mut args = args.into_iter();
    let command = match args.next().as_deref() {
        None => ServiceCommand::Run,
        Some(value) if value == OsStr::new("install") => ServiceCommand::Install,
        Some(value) if value == OsStr::new("uninstall") => ServiceCommand::Uninstall,
        Some(value) => bail!("unknown helper command: {}", value.to_string_lossy()),
    };
    if args.next().is_some() {
        bail!("helper accepts at most one command");
    }
    Ok(command)
}

pub(super) fn core_owner() -> Result<(u32, u32), Error> {
    let owner = owner_from_env().map_err(Error::other)?;
    Ok((owner.uid, owner.gid))
}

pub(super) fn ensure_owner_socket(address: &str) -> Result<(), Error> {
    let owner = owner_from_env().map_err(Error::other)?;
    let metadata = fs::symlink_metadata(address)?;
    if !metadata.file_type().is_socket() || metadata.uid() != owner.uid {
        return Err(Error::other(
            "Core address is not a socket owned by the Helper owner",
        ));
    }
    Ok(())
}

fn owner_from_env() -> Result<Owner> {
    Ok(Owner {
        uid: read_id_env(OWNER_UID_ENV)?,
        gid: read_id_env(OWNER_GID_ENV)?,
    })
}

fn read_id_env(name: &str) -> Result<u32> {
    let value = std::env::var(name).with_context(|| format!("{name} is not set"))?;
    parse_owner_id(&value).with_context(|| format!("{name} is not a usable ID"))
}

/// Root owns the Core already; an owner of 0 would mean the service is running
/// for nobody and would hand the Core the credentials it is trying to avoid.
fn parse_owner_id(value: &str) -> Result<u32> {
    let id: u32 = value.trim().parse().context("expected an unsigned ID")?;
    if id == 0 {
        bail!("expected a non-root ID");
    }
    Ok(id)
}

/// pkexec and sudo both name the user who asked for the elevation; without one
/// there is nobody to grant the socket to, so installation has no owner.
fn invoking_owner() -> Result<Owner> {
    let uid = ["PKEXEC_UID", "SUDO_UID"]
        .into_iter()
        .find_map(|name| std::env::var(name).ok())
        .context("neither PKEXEC_UID nor SUDO_UID is set; run the installer through pkexec")?;
    let uid = parse_owner_id(&uid).context("the invoking user ID is not usable")?;
    let gid = parse_owner_id(&invoking_gid(uid)?).context("the invoking group is not usable")?;
    Ok(Owner { uid, gid })
}

fn invoking_gid(uid: u32) -> Result<String> {
    let output = Command::new("id")
        .args(["-g", &uid.to_string()])
        .output()
        .context("query the invoking user")?;
    if !output.status.success() {
        bail!("id -g {uid} failed with {}", output.status);
    }
    let value = String::from_utf8(output.stdout)
        .context("id returned invalid UTF-8")?
        .trim()
        .to_string();
    if value.is_empty() {
        bail!("id -g {uid} returned nothing");
    }
    Ok(value)
}

/// systemd splits `ExecStart=` on whitespace and expands `%` specifiers, so the
/// path travels double-quoted with its quotes, backslashes and `%` escaped.
fn quoted_unit_argument(path: &Path) -> String {
    let mut quoted = String::from("\"");
    for character in path.to_string_lossy().chars() {
        match character {
            '"' | '\\' => {
                quoted.push('\\');
                quoted.push(character);
            }
            '%' => quoted.push_str("%%"),
            _ => quoted.push(character),
        }
    }
    quoted.push('"');
    quoted
}

fn unit_contents(executable: &Path, owner: Owner) -> String {
    format!(
        "[Unit]\n\
         Description=FlClash Helper starts the FlClash Core with the privileges TUN mode needs.\n\
         After=network-online.target nftables.service iptables.service\n\
         StartLimitIntervalSec=60\n\
         StartLimitBurst=5\n\
         \n\
         [Service]\n\
         Type=simple\n\
         ExecStart={executable}\n\
         Group={gid}\n\
         Environment={OWNER_UID_ENV}={uid}\n\
         Environment={OWNER_GID_ENV}={gid}\n\
         RuntimeDirectory={RUNTIME_DIR_NAME}\n\
         RuntimeDirectoryMode=0755\n\
         Restart=on-failure\n\
         RestartSec=5\n\
         \n\
         [Install]\n\
         WantedBy=multi-user.target\n",
        executable = quoted_unit_argument(executable),
        uid = owner.uid,
        gid = owner.gid,
    )
}

/// The unit runs this binary as root at every boot, so one the invoking user
/// could overwrite would turn a single polkit approval into standing root.
fn ensure_root_owned(executable: &Path) -> Result<()> {
    let directory = executable
        .parent()
        .context("helper executable has no parent directory")?;
    for path in [executable, directory] {
        let metadata = fs::metadata(path).with_context(|| format!("inspect {}", path.display()))?;
        if metadata.uid() != 0 || metadata.mode() & 0o022 != 0 {
            bail!(
                "{} must be owned by root and not writable by group or others to run as a service; \
                 install the package instead of running an unpacked bundle",
                path.display()
            );
        }
    }
    Ok(())
}

fn installed_owner_uid(unit: &str) -> Option<u32> {
    let prefix = format!("Environment={OWNER_UID_ENV}=");
    unit.lines()
        .find_map(|line| line.strip_prefix(prefix.as_str()))
        .and_then(|value| value.trim().parse().ok())
}

fn ensure_unit_is_free_for(owner: Owner) -> Result<()> {
    let existing = match fs::read_to_string(UNIT_PATH) {
        Ok(contents) => contents,
        Err(error) if error.kind() == ErrorKind::NotFound => return Ok(()),
        Err(error) => return Err(error).with_context(|| format!("read {UNIT_PATH}")),
    };
    match installed_owner_uid(&existing) {
        Some(uid) if uid != owner.uid => bail!(
            "the Helper is already installed for UID {uid}; \
             run `FlClashHelperService uninstall` as that user first"
        ),
        Some(_) => Ok(()),
        None => bail!("existing Helper unit has no valid owner; refusing to replace it"),
    }
}

fn ensure_root() -> Result<()> {
    if unsafe { libc::geteuid() } != 0 {
        bail!("run the Helper installer through pkexec or sudo");
    }
    Ok(())
}

fn secure_directory(path: &Path) -> Result<()> {
    for ancestor in path.ancestors() {
        let metadata = fs::symlink_metadata(ancestor)?;
        if !metadata.is_dir() || metadata.uid() != 0 || metadata.mode() & 0o022 != 0 {
            bail!(
                "{} is not a root-owned, non-writable directory",
                ancestor.display()
            );
        }
    }
    Ok(())
}

struct InstalledFiles {
    executable: PathBuf,
    backup: PathBuf,
    previous: Vec<&'static str>,
    committed: bool,
}

impl InstalledFiles {
    fn commit(mut self) {
        self.committed = true;
    }
}

impl Drop for InstalledFiles {
    fn drop(&mut self) {
        let destination = self.executable.parent().unwrap();
        if !self.committed {
            for name in ["FlClashCore", "FlClashHelperService"] {
                if self.previous.contains(&name) {
                    // Replacing the inode also works while the old service runs.
                    if let Err(error) = fs::rename(self.backup.join(name), destination.join(name)) {
                        eprintln!(
                            "Helper rollback failed for {name}: {error}; the previous copy is kept in {}",
                            self.backup.display()
                        );
                        return; // Keep the backup for recovery.
                    }
                } else {
                    let _ = fs::remove_file(destination.join(name));
                }
            }
        }
        let _ = fs::remove_dir_all(&self.backup);
    }
}

fn is_core_sha256(value: &str) -> bool {
    value.len() == 64
        && value
            .bytes()
            .all(|byte| byte.is_ascii_digit() || (b'a'..=b'f').contains(&byte))
}

/// Serializes installs so one run's cleanup cannot remove the copy that
/// another run is staging or has just activated.
fn lock_installations(root: &Path) -> Result<fs::File> {
    fs::create_dir_all(root)?;
    secure_directory(root)?;
    let lock = fs::OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(false)
        .mode(0o600)
        .open(root.join(".install.lock"))?;
    lock.lock().context("wait for another Helper install")?;
    Ok(lock)
}

/// Every Core build stages under its own hash, so a committed upgrade leaves
/// the previous copy behind in a directory only root can clean up.
fn remove_stale_installations(root: &Path, current: &Path) {
    let Ok(entries) = fs::read_dir(root) else {
        return;
    };
    for entry in entries.flatten() {
        let path = entry.path();
        let is_directory = entry.file_type().is_ok_and(|kind| kind.is_dir());
        if !is_directory || path == current || !is_core_sha256(&entry.file_name().to_string_lossy())
        {
            continue;
        }
        if let Err(error) = fs::remove_dir_all(&path) {
            eprintln!(
                "could not remove the previous Helper copy {}: {error}",
                path.display()
            );
        }
    }
}

fn stage_installation(executable: &Path) -> Result<InstalledFiles> {
    use crate::service::hub::{expected_core_sha256, verify_installation_core};
    ensure_core_sha256_configured()?;
    let sha = expected_core_sha256();
    if !is_core_sha256(sha) {
        bail!("invalid embedded Core SHA256");
    }
    let root = Path::new(INSTALL_ROOT);
    fs::create_dir_all(root)?;
    secure_directory(root)?;
    let destination = root.join(sha);
    fs::create_dir_all(&destination)?;
    secure_directory(&destination)?;
    let stage = destination.join(format!(".install-{}", std::process::id()));
    fs::create_dir(&stage)?;
    fs::set_permissions(&stage, fs::Permissions::from_mode(0o700))?;
    let mut installed = InstalledFiles {
        executable: destination.join("FlClashHelperService"),
        backup: destination.join(format!(".backup-{}", std::process::id())),
        previous: Vec::new(),
        committed: true,
    };
    fs::create_dir(&installed.backup)?;
    fs::set_permissions(&installed.backup, fs::Permissions::from_mode(0o700))?;
    let result = (|| -> Result<()> {
        let source_core = executable
            .parent()
            .context("helper has no directory")?
            .join("FlClashCore");
        let mut source = verify_installation_core(&source_core)?;
        source.seek(SeekFrom::Start(0))?;
        let core = stage.join("FlClashCore");
        let mut output = fs::File::create(&core)?;
        std::io::copy(&mut source, &mut output)?;
        output.sync_all()?;
        verify_installation_core(&core)?;
        fs::set_permissions(&core, fs::Permissions::from_mode(0o755))?;
        let helper = stage.join("FlClashHelperService");
        // Copy the executable inode currently running, not a replaceable path
        // inside an AppImage mount or an extracted user-owned bundle.
        fs::copy("/proc/self/exe", &helper)?;
        fs::set_permissions(&helper, fs::Permissions::from_mode(0o755))?;
        fs::File::open(&helper)?.sync_all()?;
        for name in ["FlClashCore", "FlClashHelperService"] {
            let path = destination.join(name);
            if path.try_exists()? {
                ensure_root_owned(&path)?;
                fs::copy(path, installed.backup.join(name))?;
                installed.previous.push(name);
            }
        }
        installed.committed = false;
        fs::rename(&core, destination.join("FlClashCore"))?;
        fs::rename(&helper, destination.join("FlClashHelperService"))?;
        fs::File::open(&destination)?.sync_all()?;
        let installed = destination.join("FlClashHelperService");
        ensure_root_owned(&installed)?;
        Ok(())
    })();
    let _ = fs::remove_dir_all(stage);
    result?;
    Ok(installed)
}

fn write_unit(contents: &[u8]) -> Result<()> {
    let temporary = format!("{UNIT_PATH}.{}", std::process::id());
    let mut options = fs::OpenOptions::new();
    let file = options.write(true).create_new(true).open(&temporary)?;
    use std::io::Write;
    let result = (|| -> Result<()> {
        let mut file = file;
        file.write_all(contents)?;
        file.set_permissions(fs::Permissions::from_mode(0o644))?;
        file.sync_all()?;
        fs::rename(&temporary, UNIT_PATH)?;
        Ok(())
    })();
    let _ = fs::remove_file(temporary);
    result
}

fn install_service() -> Result<()> {
    ensure_root()?;
    let executable = std::env::current_exe().context("resolve helper executable path")?;
    let owner = invoking_owner()?;
    ensure_unit_is_free_for(owner)?;
    let _lock = lock_installations(Path::new(INSTALL_ROOT))?;
    let installed = stage_installation(&executable)?;
    let previous = fs::read(UNIT_PATH).ok();
    write_unit(unit_contents(&installed.executable, owner).as_bytes())?;
    let activation = (|| {
        run_systemctl(&["daemon-reload"])?;
        run_systemctl(&["enable", SERVICE_NAME])?;
        run_systemctl(&["restart", SERVICE_NAME])
    })();
    if let Err(error) = activation {
        drop(installed);
        if let Some(contents) = previous {
            write_unit(&contents)?;
            silence_systemctl(&["daemon-reload"]);
            silence_systemctl(&["restart", SERVICE_NAME]);
        } else {
            silence_systemctl(&["disable", "--now", SERVICE_NAME]);
            let _ = fs::remove_file(UNIT_PATH);
            silence_systemctl(&["daemon-reload"]);
        }
        return Err(error);
    }
    let current = installed.executable.parent().map(Path::to_path_buf);
    installed.commit();
    if let Some(current) = current {
        remove_stale_installations(Path::new(INSTALL_ROOT), &current);
    }
    Ok(())
}

fn uninstall_service() -> Result<()> {
    ensure_root()?;
    if std::env::var_os("PKEXEC_UID").is_some() || std::env::var_os("SUDO_UID").is_some() {
        ensure_unit_is_free_for(invoking_owner()?)?;
    }
    if Path::new(UNIT_PATH).exists() {
        run_systemctl(&["disable", "--now", SERVICE_NAME])?;
    }
    match fs::remove_file(UNIT_PATH) {
        Ok(()) => {}
        Err(error) if error.kind() == ErrorKind::NotFound => {}
        Err(error) => return Err(error).with_context(|| format!("remove {UNIT_PATH}")),
    }
    run_systemctl(&["daemon-reload"])?;
    let root = Path::new(INSTALL_ROOT);
    if root.try_exists()? {
        secure_directory(root)?;
        fs::remove_dir_all(root)?;
    }
    Ok(())
}

/// A package removal runs this twice, so the second `disable` reporting a unit
/// that is already gone is expected rather than something to print.
fn silence_systemctl(arguments: &[&str]) {
    let _ = Command::new("systemctl")
        .args(arguments)
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status();
}

fn run_systemctl(arguments: &[&str]) -> Result<()> {
    let status = Command::new("systemctl")
        .args(arguments)
        .status()
        .with_context(|| format!("run systemctl {}", arguments.join(" ")))?;
    if !status.success() {
        bail!("systemctl {} failed with {status}", arguments.join(" "));
    }
    Ok(())
}

fn run_service() -> Result<()> {
    ensure_root()?;
    ensure_core_sha256_configured()?;
    let owner = owner_from_env()?;
    let runtime = Runtime::new().context("create helper runtime")?;
    runtime.block_on(async move {
        let mut terminate = signal(SignalKind::terminate()).context("listen for SIGTERM")?;
        let mut interrupt = signal(SignalKind::interrupt()).context("listen for SIGINT")?;
        let shutdown = async move {
            tokio::select! {
                _ = terminate.recv() => {}
                _ = interrupt.recv() => {}
            }
        };
        let incoming = AuthorizedIncoming::bind(owner)?;
        warp::serve(routes())
            .serve_incoming_with_graceful_shutdown(incoming, shutdown)
            .await;
        release_managed_core_on_shutdown();
        Ok(())
    })
}

/// Connections are filtered by peer credential rather than by the socket mode
/// alone: a supplementary group membership is enough to reach a `0660` socket,
/// and only the installing user may drive a Core that runs as root.
struct AuthorizedIncoming {
    listener: UnixListener,
    owner: Owner,
    retry: Option<Pin<Box<Sleep>>>,
}

impl AuthorizedIncoming {
    fn bind(owner: Owner) -> Result<Self> {
        if Path::new(SOCKET_PATH).exists() {
            fs::remove_file(SOCKET_PATH).with_context(|| format!("remove stale {SOCKET_PATH}"))?;
        }
        let listener =
            UnixListener::bind(SOCKET_PATH).with_context(|| format!("bind {SOCKET_PATH}"))?;
        fs::set_permissions(SOCKET_PATH, fs::Permissions::from_mode(SOCKET_MODE))
            .with_context(|| format!("secure {SOCKET_PATH}"))?;
        Ok(Self {
            listener,
            owner,
            retry: None,
        })
    }
}

fn is_authorized_peer(stream: &UnixStream, owner: Owner) -> bool {
    matches!(stream.peer_cred(), Ok(credentials) if credentials.uid() == owner.uid)
}

impl Stream for AuthorizedIncoming {
    type Item = Result<UnixStream, Error>;

    /// hyper ends the whole server on the first accept error it is handed, so
    /// resource exhaustion is logged and retried after a pause instead.
    fn poll_next(
        mut self: Pin<&mut Self>,
        context: &mut TaskContext<'_>,
    ) -> Poll<Option<Self::Item>> {
        loop {
            if let Some(retry) = self.retry.as_mut() {
                match retry.as_mut().poll(context) {
                    Poll::Ready(()) => self.retry = None,
                    Poll::Pending => return Poll::Pending,
                }
            }
            match self.listener.poll_accept(context) {
                Poll::Ready(Ok((stream, _))) => {
                    if is_authorized_peer(&stream, self.owner) {
                        return Poll::Ready(Some(Ok(stream)));
                    }
                }
                Poll::Ready(Err(error)) => {
                    log_message(format!("Helper could not accept a connection: {error}"));
                    self.retry = Some(Box::pin(tokio::time::sleep(ACCEPT_RETRY_DELAY)));
                }
                Poll::Pending => return Poll::Pending,
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn socket_authorization_uses_uid_not_shared_group() {
        let (stream, _peer) = UnixStream::pair().unwrap();
        let uid = unsafe { libc::geteuid() };
        let gid = unsafe { libc::getegid() };
        assert!(is_authorized_peer(&stream, Owner { uid, gid }));
        assert!(!is_authorized_peer(&stream, Owner { uid: uid + 1, gid }));
    }

    #[test]
    fn failed_upgrade_restores_binaries_even_when_core_sha_is_unchanged() {
        let directory =
            std::env::temp_dir().join(format!("helper-rollback-{}", std::process::id()));
        fs::create_dir_all(&directory).unwrap();
        let backup = directory.join("backup");
        fs::create_dir(&backup).unwrap();
        for name in ["FlClashCore", "FlClashHelperService"] {
            fs::write(backup.join(name), b"previous version").unwrap();
            fs::write(directory.join(name), b"new version").unwrap();
        }
        drop(InstalledFiles {
            executable: directory.join("FlClashHelperService"),
            backup,
            previous: vec!["FlClashCore", "FlClashHelperService"],
            committed: false,
        });
        assert_eq!(
            fs::read(directory.join("FlClashHelperService")).unwrap(),
            b"previous version"
        );
        assert_eq!(
            fs::read(directory.join("FlClashCore")).unwrap(),
            b"previous version"
        );
        assert!(!directory.join("backup").exists());
        fs::remove_dir_all(directory).unwrap();
    }

    #[test]
    fn a_committed_upgrade_removes_only_previous_core_copies() {
        let root = std::env::temp_dir().join(format!("helper-prune-{}", std::process::id()));
        let current = root.join("a".repeat(64));
        let previous = root.join("b".repeat(64));
        let unrelated = root.join("keep");
        for directory in [&current, &previous, &unrelated] {
            fs::create_dir_all(directory.join("nested")).unwrap();
        }
        fs::write(root.join("c".repeat(64)), b"not a directory").unwrap();

        remove_stale_installations(&root, &current);

        assert!(current.exists());
        assert!(!previous.exists());
        assert!(unrelated.exists());
        assert!(root.join("c".repeat(64)).exists());
        fs::remove_dir_all(root).unwrap();
    }

    #[test]
    fn core_sha256_names_are_lowercase_hex_digests() {
        assert!(is_core_sha256(&"0f".repeat(32)));
        assert!(!is_core_sha256(&"0F".repeat(32)));
        assert!(!is_core_sha256(&"0f".repeat(31)));
        assert!(!is_core_sha256(""));
    }

    #[test]
    fn parses_service_commands() {
        assert_eq!(service_command([]).unwrap(), ServiceCommand::Run);
        assert_eq!(
            service_command([OsString::from("install")]).unwrap(),
            ServiceCommand::Install
        );
        assert_eq!(
            service_command([OsString::from("uninstall")]).unwrap(),
            ServiceCommand::Uninstall
        );
    }

    #[test]
    fn rejects_unknown_or_extra_service_commands() {
        assert!(service_command([OsString::from("unknown")]).is_err());
        assert!(service_command([OsString::from("install"), OsString::from("extra")]).is_err());
    }

    #[test]
    fn rejects_owner_ids_that_cannot_own_a_core() {
        assert_eq!(parse_owner_id(" 1000\n").unwrap(), 1000);
        assert!(parse_owner_id("0").is_err());
        assert!(parse_owner_id("-1").is_err());
        assert!(parse_owner_id("nobody").is_err());
    }

    #[test]
    fn unit_names_the_owner_and_the_helper_it_starts() {
        let unit = unit_contents(
            Path::new("/opt/FlClash/FlClashHelperService"),
            Owner {
                uid: 1000,
                gid: 1001,
            },
        );

        assert!(unit.contains("ExecStart=\"/opt/FlClash/FlClashHelperService\"\n"));
        assert!(unit.contains("Group=1001\n"));
        assert!(unit.contains("Environment=FLCLASH_HELPER_OWNER_UID=1000\n"));
        assert!(unit.contains("Environment=FLCLASH_HELPER_OWNER_GID=1001\n"));
        assert!(unit.contains("RuntimeDirectory=flclash\n"));
        assert!(unit.contains("Restart=on-failure\n"));
        assert!(unit.contains("StartLimitBurst=5\n"));
    }

    #[test]
    fn unit_argument_survives_whitespace_and_specifiers() {
        assert_eq!(
            quoted_unit_argument(Path::new("/home/u/My Apps/100%/a\"b\\c")),
            r#""/home/u/My Apps/100%%/a\"b\\c""#
        );
    }

    #[test]
    fn reads_the_owner_back_out_of_an_installed_unit() {
        let unit = unit_contents(
            Path::new("/opt/FlClash/FlClashHelperService"),
            Owner {
                uid: 1000,
                gid: 1001,
            },
        );

        assert_eq!(installed_owner_uid(&unit), Some(1000));
        assert_eq!(installed_owner_uid("[Unit]\n"), None);
    }
}
