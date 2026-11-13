#if LowerCase(GetSHA256OfFile("{{SOURCE_DIR}}\data\flutter_assets\assets\data\ca-certificates.crt")) != LowerCase(GetEnv("FLCLASH_CA_BUNDLE_SHA256"))
  #error The Windows installer CA bundle does not match the build input
#endif

[Setup]
AppId={{APP_ID}}
AppVersion={{APP_VERSION}}
AppName={{DISPLAY_NAME}}
AppPublisher={{PUBLISHER_NAME}}
AppPublisherURL={{PUBLISHER_URL}}
AppSupportURL={{PUBLISHER_URL}}
AppUpdatesURL={{PUBLISHER_URL}}
DefaultDirName={{INSTALL_DIR_NAME}}
DisableDirPage=no
DisableProgramGroupPage=yes
ShowLanguageDialog=auto
OutputDir=.
OutputBaseFilename={{OUTPUT_BASE_FILENAME}}
Compression=lzma
SolidCompression=yes
RedirectionGuard=yes
SetupIconFile={{SETUP_ICON_FILE}}
WizardStyle=modern
PrivilegesRequired={{PRIVILEGES_REQUIRED}}
ArchitecturesAllowed={% if ARCH == 'x64' %}x64os{% else %}{{ARCH}}{% endif %}
ArchitecturesInstallIn64BitMode={% if ARCH == 'x64' %}x64os{% else %}{{ARCH}}{% endif %}

[Code]
const
  HelperRecoveryKey = 'SYSTEM\CurrentControlSet\Control\FlClashOixCloudHelperMaintenance';
#emit "  PackagedHelperSHA256 = '" + GetSHA256OfFile("{{SOURCE_DIR}}\FlClashHelperService.exe") + "';"
#emit "  PackagedCoreSHA256 = '" + GetSHA256OfFile("{{SOURCE_DIR}}\FlClashCore.exe") + "';"

type
  { Pointer-sized slots include the SECURITY_ATTRIBUTES padding on 64-bit Setup. }
  THelperSecurityAttributes = record
    Length: THandle;
    Descriptor: THandle;
    InheritHandle: THandle;
  end;
  TUninstallLuid = record
    LowPart: LongWord;
    HighPart: Longint;
  end;
  TUninstallPrivileges = record
    Count: LongWord;
    Luid: TUninstallLuid;
    Attributes: LongWord;
  end;

function HelperCreateMutex(var Attributes: THelperSecurityAttributes; InitialOwner: Integer; Name: String): THandle;
  external 'CreateMutexW@kernel32.dll stdcall';
function HelperCloseHandle(Handle: THandle): Integer;
  external 'CloseHandle@kernel32.dll stdcall';
function HelperGetCurrentProcessId: LongWord;
  external 'GetCurrentProcessId@kernel32.dll stdcall';
function HelperConvertSecurity(Sddl: String; Revision: LongWord; var Descriptor: THandle; Size: THandle): Integer;
  external 'ConvertStringSecurityDescriptorToSecurityDescriptorW@advapi32.dll stdcall';
function DataDirectoryAttributes(Path: String): LongWord;
  external 'GetFileAttributesW@kernel32.dll stdcall';
function HelperLocalFree(Memory: THandle): THandle;
  external 'LocalFree@kernel32.dll stdcall';
function UninstallGetShellWindow: THandle;
  external 'GetShellWindow@user32.dll stdcall';
function UninstallGetWindowProcessId(Window: THandle; var ProcessId: LongWord): LongWord;
  external 'GetWindowThreadProcessId@user32.dll stdcall';
function UninstallOpenProcess(Access: LongWord; Inherit: Integer; ProcessId: LongWord): THandle;
  external 'OpenProcess@kernel32.dll stdcall';
function UninstallOpenProcessToken(Process: THandle; Access: LongWord; var Token: THandle): Integer;
  external 'OpenProcessToken@advapi32.dll stdcall';
function UninstallGetCurrentProcess: THandle;
  external 'GetCurrentProcess@kernel32.dll stdcall';
function UninstallLookupPrivilegeValue(SystemName: THandle; Name: String; var Luid: TUninstallLuid): Integer;
  external 'LookupPrivilegeValueW@advapi32.dll stdcall';
function UninstallAdjustTokenPrivileges(Token: THandle; DisableAll: Integer; var State: TUninstallPrivileges; Size: LongWord; var Previous: TUninstallPrivileges; var ReturnLength: LongWord): Integer;
  external 'AdjustTokenPrivileges@advapi32.dll stdcall';
function UninstallImpersonateUser(Token: THandle): Integer;
  external 'ImpersonateLoggedOnUser@advapi32.dll stdcall';
function UninstallRevertToSelf: Integer;
  external 'RevertToSelf@advapi32.dll stdcall';
function UninstallGetFolderPath(Window: THandle; Folder: Integer; Token: THandle; Flags: LongWord; Path: String): Integer;
  external 'SHGetFolderPathW@shell32.dll stdcall';

function HelperReadRegistryString(Root: THandle; Key, Name: String; Flags: LongWord; ValueType: THandle; Data: String; var Size: LongWord): LongWord;
  external 'RegGetValueW@advapi32.dll stdcall';

var
  HelperRecoveryPending, HelperRestoreFailed: Boolean;
  LegacyHelperService, LegacyHelperRecovery: Boolean;
  OldHelperSHA256, OldCoreSHA256: String;
  RestoreHelperService: Boolean;
  HelperOwnerSid: String;
  HelperInstallLock: THandle;

function AcquireHelperInstallLock: Boolean;
var
  Attributes: THelperSecurityAttributes;
  ErrorCode: LongWord;
begin
  Result := HelperInstallLock <> 0;
  if Result then Exit;
  Attributes.Length := SizeOf(Attributes);
  Attributes.Descriptor := 0;
  Attributes.InheritHandle := 0;
  if HelperConvertSecurity('D:P(A;;GA;;;SY)(A;;GA;;;BA)', 1, Attributes.Descriptor, 0) = 0 then Exit;
  try
    HelperInstallLock := HelperCreateMutex(Attributes, 0, 'Global\FlClashOixCloudHelper.Install.v1');
    ErrorCode := DLLGetLastError;
  finally
    HelperLocalFree(Attributes.Descriptor);
  end;
  if (HelperInstallLock <> 0) and (ErrorCode = 183) then
  begin
    HelperCloseHandle(HelperInstallLock);
    HelperInstallLock := 0;
  end;
  Result := HelperInstallLock <> 0;
end;

procedure ReleaseHelperInstallLock;
begin
  if HelperInstallLock <> 0 then HelperCloseHandle(HelperInstallLock);
  HelperInstallLock := 0;
end;

function HelperInstallLockArguments: String;
begin
  Result := ' --install-lock ' + IntToStr(HelperGetCurrentProcessId) + ' ' + IntToStr(HelperInstallLock);
end;

function IsAppUpdate: Boolean;
begin
  Result := ExpandConstant('{param:FLCLASHUPDATE|0}') = '1';
end;

function PreviousAppDirectory(var Directory: String): Boolean;
begin
  Result := RegQueryStringValue(HKLM, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{{APP_ID}}_is1',
    'Inno Setup: App Path', Directory) and FileExists(AddBackslash(Directory) + 'FlClash.exe');
end;

{ Running the installer over an existing install is the whole request: Setup
  already knows its directory, tasks and language. Only a silent Setup can drop
  the wizard, so it runs itself again that way, which still asks about a pending
  restart. Exec refuses to start Setup's own file, hence PowerShell. This one,
  holding the unelevated token, then reopens the app. }
function InitializeSetup: Boolean;
var
  Directory, Source: String;
  ResultCode: Integer;
begin
  Result := True;
  if WizardSilent or not PreviousAppDirectory(Directory) then Exit;
  Log('Upgrading ' + Directory + ' without the wizard');
  Source := ExpandConstant('{srcexe}');
  StringChangeEx(Source, '''', '''''', True);
  if not Exec(ExpandConstant('{sys}\WindowsPowerShell\v1.0\powershell.exe'),
    '-NoProfile -NonInteractive -Command "Start-Process -Wait -ErrorAction Stop -FilePath ' +
    '''' + Source + '''' + ' -ArgumentList ' +
    '''/SILENT /SP- /CLOSEAPPLICATIONS /FORCECLOSEAPPLICATIONS /NORESTARTAPPLICATIONS''"',
    '', SW_HIDE, ewWaitUntilTerminated, ResultCode) or (ResultCode <> 0) then
  begin
    Log('The silent upgrade did not start: ' + IntToStr(ResultCode));
    Exit;
  end;
  Result := False;
  ExecAsOriginalUser(AddBackslash(Directory) + 'FlClash.exe', '', Directory, SW_SHOW, ewNoWait, ResultCode);
end;

procedure KillProcesses;
var
  AppDir, Command: String;
  ResultCode: Integer;
begin
  AppDir := ExpandConstant('{app}');
  StringChangeEx(AppDir, '''', '''''', True);
  Command := '-NoProfile -NonInteractive -Command "' +
    '$targets = @(' + '''' + AppDir + '\FlClash.exe' + '''' + ', ' +
    '''' + AppDir + '\FlClashCore.exe' + '''' + '); ' +
    'Get-CimInstance Win32_Process | Where-Object { $targets -contains $_.ExecutablePath } | ' +
    'ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction Stop }"';
  Exec(ExpandConstant('{sys}\WindowsPowerShell\v1.0\powershell.exe'), Command,
    '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;

function IsApplicationDirectory: Boolean;
var
  AppPath: String;
  ResultCode: Integer;
begin
  AppPath := ExpandConstant('{app}\FlClash.exe');
  Result := not FileExists(AppPath);
  if Result then Exit;
  StringChangeEx(AppPath, '''', '''''', True);
  Result := Exec(ExpandConstant('{sys}\WindowsPowerShell\v1.0\powershell.exe'),
    '-NoProfile -NonInteractive -Command "if ((Get-Item -LiteralPath ' +
    '''' + AppPath + '''' + ').VersionInfo.InternalName -eq ' +
    '''com.oixcloud.clash''' + ') { exit 0 } else { exit 1 }"',
    '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if Result then Result := ResultCode = 0;
end;

function UnregisterHelperService(HelperPath: String; Legacy: Boolean): Boolean;
var
  Arguments: String;
  ResultCode: Integer;
begin
  Result := False;
  if not FileExists(HelperPath) then Exit;
  Arguments := 'uninstall';
  if not Legacy then Arguments := Arguments + HelperInstallLockArguments;
  Result := Exec(HelperPath, Arguments, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  if Result then Result := ResultCode = 0;
end;

function ReadHelperRegistryString(Key, Name: String; Flags: LongWord; var Value: String): Boolean;
var
  Size, Status: LongWord;
begin
  SetLength(Value, 32768);
  Size := Length(Value) * 2;
  Status := HelperReadRegistryString(HKLM, Key, Name, Flags, 0, Value, Size);
  Result := Status <> 2;
  if not Result then begin Value := ''; Exit; end;
  if Status <> 0 then RaiseException('The FlClash helper registry value could not be read: ' + Name);
  if (Size < 2) or (Size > 65536) or (Size mod 2 <> 0) then
    RaiseException('Invalid FlClash helper registry value size: ' + Name);
  SetLength(Value, Size div 2 - 1);
end;

{ Setup cannot tell which account the Helper serves, so it keeps the one registered before. }
function ReadHelperOwner: Boolean;
var
  ImagePath, ExpectedPath: String;
  FlagAt: Integer;
begin
  LegacyHelperService := False;
  Result := ReadHelperRegistryString('SYSTEM\CurrentControlSet\Services\FlClashOixCloudHelper',
    'ImagePath', $10000006, ImagePath);
  if not Result and FileExists(ExpandConstant('{app}\FlClash.exe')) then
  begin
    Result := ReadHelperRegistryString('SYSTEM\CurrentControlSet\Services\FlClashHelperService',
      'ImagePath', $10000006, ImagePath);
    ExpectedPath := '"' + ExpandConstant('{app}\FlClashHelperService.exe') + '"';
    Result := Result and (CompareText(Copy(ImagePath, 1, Length(ExpectedPath)), ExpectedPath) = 0);
    LegacyHelperService := Result;
  end;
  if not Result then Exit;
  FlagAt := Pos(' --owner-sid ', ImagePath);
  if FlagAt > 0 then
    HelperOwnerSid := Trim(Copy(ImagePath, FlagAt + Length(' --owner-sid '), Length(ImagePath)));
end;

function TakeRecoveryField(var Value: String): String;
var
  Separator: Integer;
begin
  Separator := Pos('|', Value);
  if Separator = 0 then RaiseException('Invalid FlClash helper recovery record');
  Result := Copy(Value, 1, Separator - 1);
  Delete(Value, 1, Separator);
end;

function ValidSHA256(Value: String): Boolean;
var
  i: Integer;
begin
  Result := Value = '';
  if Result or (Length(Value) <> 64) then Exit;
  for i := 1 to Length(Value) do
    if Pos(Value[i], '0123456789abcdef') = 0 then Exit;
  Result := True;
end;

procedure LoadHelperRecovery;
var
  Value, LegacyFlag: String;
  i: Integer;
begin
  HelperRecoveryPending := False;
  if not ReadHelperRegistryString(HelperRecoveryKey, 'Upgrade', 2, Value) then Exit;
  if TakeRecoveryField(Value) <> '2' then RaiseException('Unsupported FlClash helper recovery record');
  LegacyFlag := TakeRecoveryField(Value);
  if (LegacyFlag <> '0') and (LegacyFlag <> '1') then
    RaiseException('Invalid FlClash helper recovery service');
  LegacyHelperRecovery := LegacyFlag = '1';
  HelperOwnerSid := TakeRecoveryField(Value);
  if (HelperOwnerSid <> '') and (Copy(HelperOwnerSid, 1, 4) <> 'S-1-') then
    RaiseException('Invalid FlClash helper recovery account');
  for i := 5 to Length(HelperOwnerSid) do
    if Pos(HelperOwnerSid[i], '0123456789-') = 0 then RaiseException('Invalid FlClash helper recovery account');
  OldHelperSHA256 := TakeRecoveryField(Value);
  OldCoreSHA256 := TakeRecoveryField(Value);
  if not ValidSHA256(OldHelperSHA256) or not ValidSHA256(OldCoreSHA256) then
    RaiseException('Invalid FlClash helper recovery hash');
  if CompareText(Value, ExpandConstant('{app}')) <> 0 then
    RaiseException('An interrupted FlClash installation must be repaired in its original directory');
  HelperRecoveryPending := True;
end;

function InstalledHash(Name: String): String;
begin
  Result := '';
  if FileExists(ExpandConstant('{app}\') + Name) then
    Result := Lowercase(GetSHA256OfFile(ExpandConstant('{app}\') + Name));
end;

procedure SaveHelperRecovery;
var
  RecordPrefix: String;
begin
  LegacyHelperRecovery := LegacyHelperService;
  RecordPrefix := '2|0|';
  if LegacyHelperRecovery then RecordPrefix := '2|1|';
  OldHelperSHA256 := InstalledHash('FlClashHelperService.exe');
  OldCoreSHA256 := InstalledHash('FlClashCore.exe');
  if not RegWriteStringValue(HKLM, HelperRecoveryKey, 'Upgrade',
    RecordPrefix + HelperOwnerSid + '|' + OldHelperSHA256 + '|' + OldCoreSHA256 + '|' + ExpandConstant('{app}')) then
    RaiseException('The FlClash helper recovery record could not be saved');
  HelperRecoveryPending := True;
end;

procedure ClearHelperRecovery;
begin
  if HelperRecoveryPending then
  begin
    if not RegDeleteValue(HKLM, HelperRecoveryKey, 'Upgrade') then
      RaiseException('The FlClash helper recovery record could not be cleared');
    HelperRecoveryPending := False;
  end;
end;

procedure RegisterHelperService(AllowUnchangedFiles: Boolean);
var
  ResultCode: Integer;
  HelperHash, CoreHash, HelperPath, Arguments: String;
  FilesComplete, RestoreLegacy: Boolean;
begin
  RestoreHelperService := False;
  HelperRestoreFailed := True;
  try
    if HelperOwnerSid <> '' then
    begin
      HelperHash := InstalledHash('FlClashHelperService.exe');
      CoreHash := InstalledHash('FlClashCore.exe');
      FilesComplete := (HelperHash = Lowercase(PackagedHelperSHA256)) and
        (CoreHash = Lowercase(PackagedCoreSHA256));
      RestoreLegacy := False;
      if AllowUnchangedFiles and (OldHelperSHA256 <> '') and (OldCoreSHA256 <> '') then
      begin
        RestoreLegacy := LegacyHelperRecovery and not FilesComplete and
          (HelperHash = OldHelperSHA256) and (CoreHash = OldCoreSHA256);
        FilesComplete := FilesComplete or ((HelperHash = OldHelperSHA256) and (CoreHash = OldCoreSHA256));
      end;
      if not FilesComplete then
        RaiseException('The FlClash helper files are incomplete. Run the installer again to repair them');
      HelperPath := ExpandConstant('{tmp}\FlClashHelperService.exe');
      Arguments := 'install --owner-sid ' + HelperOwnerSid + ' --service-path "' +
        ExpandConstant('{app}\FlClashHelperService.exe') + '"' + HelperInstallLockArguments;
      if RestoreLegacy then
      begin
        HelperPath := ExpandConstant('{app}\FlClashHelperService.exe');
        Arguments := 'install --owner-sid ' + HelperOwnerSid;
      end;
      if not Exec(HelperPath, Arguments, '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
        RaiseException('The FlClash helper registration could not be started. Please retry the installation');
      if ResultCode <> 0 then
        RaiseException('The FlClash helper service could not be registered. Please retry the installation');
    end;
    ClearHelperRecovery;
    HelperRestoreFailed := False;
  except
    Log(GetExceptionMessage);
  end;
end;

function GetCustomSetupExitCode: Integer;
begin
  Result := 0;
  if HelperRestoreFailed then Result := 1;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  HadHelperService: Boolean;
  PendingOwner, HelperPath: String;
begin
  Result := '';
  if not IsApplicationDirectory then
  begin
    Result := 'This directory is not a verified FlClash for oixCloud installation. Choose a separate directory';
    Exit;
  end;
  if HelperInstallLock <> 0 then Exit;
  if not AcquireHelperInstallLock then
  begin
    Result := 'Another FlClash installation is in progress or the installation lock is unavailable. Please retry';
    Exit;
  end;
  try
    HelperOwnerSid := '';
    HelperRestoreFailed := False;
    LoadHelperRecovery;
    if IsAppUpdate and not FileExists(ExpandConstant('{app}\FlClash.exe')) and not HelperRecoveryPending then
      RaiseException('The installed application could not be found');
    PendingOwner := HelperOwnerSid;
    HelperOwnerSid := '';
    HadHelperService := ReadHelperOwner;
    if HadHelperService then
    begin
      if HelperRecoveryPending and (HelperOwnerSid <> PendingOwner) then
        RaiseException('The FlClash helper account changed during recovery. Repair the previous installation first');
    end
    else
    begin
      if RegKeyExists(HKLM, 'SYSTEM\CurrentControlSet\Services\FlClashOixCloudHelper') then
        RaiseException('The FlClash helper service account could not be read. Please retry the installation');
      HelperOwnerSid := PendingOwner;
    end;
    ExtractTemporaryFile('FlClashHelperService.exe');
    if HadHelperService and not HelperRecoveryPending then SaveHelperRecovery;
    HelperPath := ExpandConstant('{tmp}\FlClashHelperService.exe');
    if LegacyHelperService then HelperPath := ExpandConstant('{app}\FlClashHelperService.exe');
    if not UnregisterHelperService(HelperPath, LegacyHelperService) then
      Result := 'The FlClash helper has not finished stopping. Please retry the installation';
  except
    Result := GetExceptionMessage;
  end;
  if Result <> '' then
  begin
    RestoreHelperService := False;
    ReleaseHelperInstallLock;
    Exit;
  end;
  RestoreHelperService := HelperRecoveryPending;
  if not IsAppUpdate then KillProcesses;
end;

procedure RemoveLegacyUninstallEntry;
var
  Key, InstallDir: String;
begin
  Key := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\728B3532-C74B-4870-9068-BE70FE12A3E6_is1';
  if RegQueryStringValue(HKLM, Key, 'InstallLocation', InstallDir) and
    (CompareText(AddBackslash(InstallDir), AddBackslash(ExpandConstant('{app}'))) = 0) then
    RegDeleteKeyIncludingSubkeys(HKLM, Key);
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    try
      if RestoreHelperService then RegisterHelperService(False);
      if not HelperRestoreFailed then RemoveLegacyUninstallEntry;
    finally
      ReleaseHelperInstallLock;
    end;
  end;
end;

procedure DeinitializeSetup;
begin
  try
    { A failed or canceled copy never reaches ssPostInstall. }
    if RestoreHelperService then RegisterHelperService(True);
  finally
    ReleaseHelperInstallLock;
  end;
end;

function InitializeUninstall(): Boolean;
begin
  Result := AcquireHelperInstallLock;
end;

procedure InitializeUninstallProgressForm;
begin
  LoadHelperRecovery;
  if not UnregisterHelperService(ExpandConstant('{app}\FlClashHelperService.exe'), False) then
    RaiseException(CustomMessage('UninstallHelperFailed'));
  ClearHelperRecovery;
  KillProcesses;
end;

procedure DeinitializeUninstall;
begin
  ReleaseHelperInstallLock;
end;

function PointsToApp(Value: String): Boolean;
var
  Executable, Separator: String;
begin
  Value := Trim(Value);
  Executable := ExpandConstant('{app}\FlClash.exe');
  if Copy(Value, 1, 1) = '"' then Executable := '"' + Executable + '"';
  Result := CompareText(Copy(Value, 1, Length(Executable)), Executable) = 0;
  if not Result then Exit;
  Separator := Copy(Value, Length(Executable) + 1, 1);
  Result := (Separator = '') or (Separator = ' ') or (Separator = #9);
end;

{ The value name is appName in lib/common/constant.dart and the schemes are protocolSchemes in lib/common/protocol.dart. }
function RemoveUserRegistrations(UserSid: String): Boolean;
var
  Schemes: TArrayOfString;
  Value: String;
  i: Integer;
begin
  Result := True;
  if RegQueryStringValue(HKU, UserSid + '\Software\Microsoft\Windows\CurrentVersion\Run', '{{DISPLAY_NAME}}', Value) and PointsToApp(Value) then
  begin
    if RegDeleteValue(HKU, UserSid + '\Software\Microsoft\Windows\CurrentVersion\Run', '{{DISPLAY_NAME}}') then
    begin
      if RegValueExists(HKU, UserSid + '\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run', '{{DISPLAY_NAME}}') then
        if not RegDeleteValue(HKU, UserSid + '\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run', '{{DISPLAY_NAME}}') then
          Result := False;
    end
    else Result := False;
  end;

  Schemes := ['clash', 'clashmeta', 'flclash'];
  for i := 0 to GetArrayLength(Schemes)-1 do
  begin
    if RegQueryStringValue(HKU, UserSid + '\Software\Classes\' + Schemes[i] + '\shell\open\command', '', Value) and PointsToApp(Value) then
    begin
      if not RegDeleteKeyIncludingSubkeys(HKU, UserSid + '\Software\Classes\' + Schemes[i]) then
        Result := False;
    end;
  end;
end;

function ReadUserDirectoryAttributes(Directory: String; var Attributes: LongWord): Boolean;
var
  ErrorCode: LongWord;
begin
  Attributes := DataDirectoryAttributes(Directory);
  Result := True;
  if Attributes = $FFFFFFFF then
  begin
    ErrorCode := DLLGetLastError;
    Result := (ErrorCode = 2) or (ErrorCode = 3);
  end
  else
    Result := (Attributes and $10) <> 0;
  if not Result then Log('Preserving user data: the directory cannot be accessed');
end;

{ path_provider uses CompanyName and ProductName from windows/runner/Runner.rc. }
function RemoveAppDataAt(BaseDir: String): Boolean;
var
  CompanyDir, DataDir: String;
  Attributes: LongWord;
begin
  CompanyDir := AddBackslash(BaseDir) + 'com.oixcloud';
  DataDir := AddBackslash(CompanyDir) + 'FlClash for oixCloud';
  Result := ReadUserDirectoryAttributes(CompanyDir, Attributes);
  if not Result or (Attributes = $FFFFFFFF) then Exit;
  if (Attributes and $400) <> 0 then
  begin
    Log('Preserving user data: the parent directory cannot be safely accessed');
    Result := False;
    Exit;
  end;
  Result := ReadUserDirectoryAttributes(DataDir, Attributes);
  if not Result then Exit;
  if Attributes <> $FFFFFFFF then Result := DelTree(DataDir, True, True, True);
  if Result then RemoveDir(CompanyDir);
end;

procedure OfferRemoveUserData(UserName, RoamingDir, LocalDir: String);
var
  RemovedRoaming, RemovedLocal: Boolean;
begin
  if UninstallSilent then Exit;
  if MsgBox(FmtMessage(CustomMessage('RemoveUserData'), [UserName]),
    mbConfirmation, MB_YESNO or MB_DEFBUTTON2) <> IDYES then Exit;
  RemovedRoaming := RemoveAppDataAt(RoamingDir);
  RemovedLocal := RemoveAppDataAt(LocalDir);
  if not RemovedRoaming or not RemovedLocal then
    MsgBox(CustomMessage('RemoveUserDataFailed'), mbError, MB_OK);
end;

function UninstallDesktopIdentity(ProcessId: LongWord; DebugAccess: Boolean; var UserName, UserSid: String): Boolean;
var
  Locator, Service, ShellProcess, Owner: Variant;
begin
  Result := False;
  Locator := CreateOleObject('WbemScripting.SWbemLocator');
  Service := Locator.ConnectServer('', 'root\cimv2');
  if DebugAccess then Service.Security_.Privileges.AddAsString('SeDebugPrivilege', True);
  ShellProcess := Service.Get('Win32_Process.Handle="' + IntToStr(ProcessId) + '"');
  Owner := ShellProcess.ExecMethod_('GetOwnerSid');
  if Owner.ReturnValue <> 0 then Exit;
  UserSid := Owner.Sid;
  Owner := ShellProcess.ExecMethod_('GetOwner');
  if Owner.ReturnValue <> 0 then Exit;
  UserName := Owner.Domain + '\' + Owner.User;
  Result := UserSid <> '';
end;

function UninstallUserDirectory(Token: THandle; Folder: Integer): String;
begin
  SetLength(Result, 260);
  if UninstallGetFolderPath(0, Folder, Token, 0, Result) <> 0 then
    RaiseException('The desktop account data directory could not be read');
  SetLength(Result, Pos(#0, Result) - 1);
  if Result = '' then RaiseException('The desktop account data directory is empty');
end;

function EnableUninstallDebugPrivilege(var Token: THandle; var Previous: TUninstallPrivileges): Boolean;
var
  Requested: TUninstallPrivileges;
  ReturnLength: LongWord;
begin
  Result := False;
  Previous.Count := 0;
  if UninstallOpenProcessToken(UninstallGetCurrentProcess, $0028, Token) = 0 then Exit;
  if UninstallLookupPrivilegeValue(0, 'SeDebugPrivilege', Requested.Luid) = 0 then Exit;
  Requested.Count := 1;
  Requested.Attributes := 2;
  ReturnLength := 0;
  if UninstallAdjustTokenPrivileges(Token, 0, Requested, SizeOf(Previous), Previous, ReturnLength) = 0 then Exit;
  Result := DLLGetLastError = 0;
end;

procedure RestoreUninstallDebugPrivilege(var Token: THandle; var Previous: TUninstallPrivileges);
var
  Changed: TUninstallPrivileges;
  ReturnLength: LongWord;
begin
  if Token = 0 then Exit;
  try
    if Previous.Count <> 0 then
    begin
      ReturnLength := 0;
      if (UninstallAdjustTokenPrivileges(Token, 0, Previous, SizeOf(Changed), Changed, ReturnLength) = 0) or
        (DLLGetLastError <> 0) then
        RaiseException('The uninstaller could not restore its token privileges');
    end;
  finally
    HelperCloseHandle(Token);
    Token := 0;
  end;
end;

procedure CleanupUninstallUser;
var
  ProcessId, ErrorCode: LongWord;
  ShellProcess, Token, PrivilegeToken: THandle;
  PreviousPrivileges: TUninstallPrivileges;
  Impersonated, RegistrationsRemoved: Boolean;
  UserName, UserSid, RoamingDir, LocalDir: String;
begin
  if IsAppUpdate then Exit;
  ShellProcess := 0;
  Token := 0;
  PrivilegeToken := 0;
  PreviousPrivileges.Count := 0;
  Impersonated := False;
  try
    try
      ProcessId := 0;
      if UninstallGetWindowProcessId(UninstallGetShellWindow, ProcessId) = 0 then
        RaiseException('The desktop account could not be identified');
      ShellProcess := UninstallOpenProcess($1000, 0, ProcessId);
      if ShellProcess = 0 then ErrorCode := DLLGetLastError
      else if UninstallOpenProcessToken(ShellProcess, $000E, Token) = 0 then
        ErrorCode := DLLGetLastError;
      if Token = 0 then
      begin
        if ErrorCode <> 5 then RaiseException('The desktop account token could not be accessed');
        if not EnableUninstallDebugPrivilege(PrivilegeToken, PreviousPrivileges) then
          RaiseException('Cross-account token access is unavailable');
        if ShellProcess = 0 then ShellProcess := UninstallOpenProcess($1000, 0, ProcessId);
        if ShellProcess = 0 then RaiseException('The desktop process could not be accessed');
        if UninstallOpenProcessToken(ShellProcess, $000E, Token) = 0 then
          RaiseException('The desktop account token could not be accessed');
      end;
      if not UninstallDesktopIdentity(ProcessId, PrivilegeToken <> 0, UserName, UserSid) then
        RaiseException('The desktop account identity could not be read');
      RestoreUninstallDebugPrivilege(PrivilegeToken, PreviousPrivileges);
      if UninstallImpersonateUser(Token) = 0 then
        RaiseException('The desktop account could not be impersonated');
      Impersonated := True;
      RoamingDir := UninstallUserDirectory(Token, $001A);
      LocalDir := UninstallUserDirectory(Token, $001C);
      RegistrationsRemoved := RemoveUserRegistrations(UserSid);
      OfferRemoveUserData(UserName, RoamingDir, LocalDir);
      if not RegistrationsRemoved then
        RaiseException('The desktop account registrations could not be removed');
    except
      Log('User cleanup failed: ' + GetExceptionMessage);
      if not UninstallSilent then
        MsgBox(CustomMessage('UserCleanupFailed'), mbError, MB_OK);
    end;
  finally
    try
      RestoreUninstallDebugPrivilege(PrivilegeToken, PreviousPrivileges);
    finally
      if Token <> 0 then HelperCloseHandle(Token);
      if ShellProcess <> 0 then HelperCloseHandle(ShellProcess);
      if Impersonated then
        if UninstallRevertToSelf = 0 then
          RaiseException('The uninstaller could not restore its account');
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
    CleanupUninstallUser;
end;

[Languages]
{% for locale in LOCALES %}
{% if locale.lang == 'en' %}Name: "english"; MessagesFile: "compiler:Default.isl"{% endif %}
{% if locale.lang == 'hy' %}Name: "armenian"; MessagesFile: "compiler:Languages\\Armenian.isl"{% endif %}
{% if locale.lang == 'bg' %}Name: "bulgarian"; MessagesFile: "compiler:Languages\\Bulgarian.isl"{% endif %}
{% if locale.lang == 'ca' %}Name: "catalan"; MessagesFile: "compiler:Languages\\Catalan.isl"{% endif %}
{% if locale.lang == 'zh' %}
Name: "chineseSimplified"; MessagesFile: {% if locale.file %}{{ locale.file }}{% else %}"compiler:Languages\\ChineseSimplified.isl"{% endif %}
{% endif %}
{% if locale.lang == 'co' %}Name: "corsican"; MessagesFile: "compiler:Languages\\Corsican.isl"{% endif %}
{% if locale.lang == 'cs' %}Name: "czech"; MessagesFile: "compiler:Languages\\Czech.isl"{% endif %}
{% if locale.lang == 'da' %}Name: "danish"; MessagesFile: "compiler:Languages\\Danish.isl"{% endif %}
{% if locale.lang == 'nl' %}Name: "dutch"; MessagesFile: "compiler:Languages\\Dutch.isl"{% endif %}
{% if locale.lang == 'fi' %}Name: "finnish"; MessagesFile: "compiler:Languages\\Finnish.isl"{% endif %}
{% if locale.lang == 'fr' %}Name: "french"; MessagesFile: "compiler:Languages\\French.isl"{% endif %}
{% if locale.lang == 'de' %}Name: "german"; MessagesFile: "compiler:Languages\\German.isl"{% endif %}
{% if locale.lang == 'he' %}Name: "hebrew"; MessagesFile: "compiler:Languages\\Hebrew.isl"{% endif %}
{% if locale.lang == 'is' %}Name: "icelandic"; MessagesFile: "compiler:Languages\\Icelandic.isl"{% endif %}
{% if locale.lang == 'it' %}Name: "italian"; MessagesFile: "compiler:Languages\\Italian.isl"{% endif %}
{% if locale.lang == 'ja' %}Name: "japanese"; MessagesFile: "compiler:Languages\\Japanese.isl"{% endif %}
{% if locale.lang == 'no' %}Name: "norwegian"; MessagesFile: "compiler:Languages\\Norwegian.isl"{% endif %}
{% if locale.lang == 'pl' %}Name: "polish"; MessagesFile: "compiler:Languages\\Polish.isl"{% endif %}
{% if locale.lang == 'pt' %}Name: "portuguese"; MessagesFile: "compiler:Languages\\Portuguese.isl"{% endif %}
{% if locale.lang == 'ru' %}Name: "russian"; MessagesFile: "compiler:Languages\\Russian.isl"{% endif %}
{% if locale.lang == 'sk' %}Name: "slovak"; MessagesFile: "compiler:Languages\\Slovak.isl"{% endif %}
{% if locale.lang == 'sl' %}Name: "slovenian"; MessagesFile: "compiler:Languages\\Slovenian.isl"{% endif %}
{% if locale.lang == 'es' %}Name: "spanish"; MessagesFile: "compiler:Languages\\Spanish.isl"{% endif %}
{% if locale.lang == 'tr' %}Name: "turkish"; MessagesFile: "compiler:Languages\\Turkish.isl"{% endif %}
{% if locale.lang == 'uk' %}Name: "ukrainian"; MessagesFile: "compiler:Languages\\Ukrainian.isl"{% endif %}
{% endfor %}

[CustomMessages]
english.RemoveUserData=Also delete the profiles and settings for the desktop account (%1)?
english.RemoveUserDataFailed=Some profiles or settings could not be deleted. The remaining files have been kept.
english.UserCleanupFailed=User-specific cleanup could not be completed. Some profiles, settings or startup registrations may remain.
english.UninstallHelperFailed=The FlClash helper could not be removed. Uninstallation has been stopped; please retry.

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: {% if CREATE_DESKTOP_ICON != true %}unchecked{% else %}checkedonce{% endif %}
[Files]
Source: "{{SOURCE_DIR}}\\FlClashHelperService.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{{SOURCE_DIR}}\\*"; Excludes: "\FlClashHelperService.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\\{{DISPLAY_NAME}}"; Filename: "{app}\\{{EXECUTABLE_NAME}}"
Name: "{autodesktop}\\{{DISPLAY_NAME}}"; Filename: "{app}\\{{EXECUTABLE_NAME}}"; Tasks: desktopicon
[Run]
Filename: "{app}\\{{EXECUTABLE_NAME}}"; Parameters: "--clear-stale-proxy"; Flags: runhidden skipifdoesntexist
Filename: "{app}\\{{EXECUTABLE_NAME}}"; Description: "{cm:LaunchProgram,{{DISPLAY_NAME}}}"; Flags: nowait postinstall skipifsilent
[UninstallRun]
Filename: "{app}\\{{EXECUTABLE_NAME}}"; Parameters: "--clear-stale-proxy"; Flags: runhidden skipifdoesntexist; RunOnceId: "ClearStaleProxy"
