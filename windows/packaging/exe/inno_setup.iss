[Setup]
AppId={{APP_ID}}
AppVersion={{APP_VERSION}}
AppName={{DISPLAY_NAME}}
AppPublisher={{PUBLISHER_NAME}}
AppPublisherURL={{PUBLISHER_URL}}
AppSupportURL={{PUBLISHER_URL}}
AppUpdatesURL={{PUBLISHER_URL}}
DefaultDirName={{INSTALL_DIR_NAME}}
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename={{OUTPUT_BASE_FILENAME}}
Compression=lzma
SolidCompression=yes
SetupIconFile={{SETUP_ICON_FILE}}
WizardStyle=modern
PrivilegesRequired={{PRIVILEGES_REQUIRED}}
ArchitecturesAllowed={% if ARCH == 'x64' %}x64os{% else %}{{ARCH}}{% endif %}
ArchitecturesInstallIn64BitMode={% if ARCH == 'x64' %}x64os{% else %}{{ARCH}}{% endif %}

[Code]
const
  HelperRecoveryKey = 'SYSTEM\CurrentControlSet\Control\FlClashHelperMaintenance';
#emit "  PackagedHelperSHA256 = '" + GetSHA256OfFile("{{SOURCE_DIR}}\FlClashHelperService.exe") + "';"
#emit "  PackagedCoreSHA256 = '" + GetSHA256OfFile("{{SOURCE_DIR}}\FlClashCore.exe") + "';"

type
  { Pointer-sized slots include the SECURITY_ATTRIBUTES padding on 64-bit Setup. }
  THelperSecurityAttributes = record
    Length: NativeInt;
    Descriptor: NativeInt;
    InheritHandle: NativeInt;
  end;

function HelperCreateMutex(var Attributes: THelperSecurityAttributes; InitialOwner: Integer; Name: String): THandle;
  external 'CreateMutexW@kernel32.dll stdcall';
function HelperCloseHandle(Handle: THandle): Integer;
  external 'CloseHandle@kernel32.dll stdcall';
function HelperGetCurrentProcessId: LongWord;
  external 'GetCurrentProcessId@kernel32.dll stdcall';
function HelperConvertSecurity(Sddl: String; Revision: LongWord; var Descriptor: NativeInt; Size: NativeInt): Integer;
  external 'ConvertStringSecurityDescriptorToSecurityDescriptorW@advapi32.dll stdcall';
function HelperLocalFree(Memory: NativeInt): NativeInt;
  external 'LocalFree@kernel32.dll stdcall';

function HelperReadRegistryString(Root: HKEY; Key, Name: String; Flags: LongWord; ValueType: NativeInt; Data: String; var Size: LongWord): LongWord;
  external 'RegGetValueW@advapi32.dll stdcall';

var
  HelperRecoveryPending, HelperRestoreFailed: Boolean;
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
    HelperInstallLock := HelperCreateMutex(Attributes, 0, 'Global\FlClashHelperService.Install.v1');
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

procedure KillProcesses;
var
  Processes: TArrayOfString;
  i: Integer;
  ResultCode: Integer;
begin
  Processes := ['FlClash.exe', 'FlClashCore.exe'];

  for i := 0 to GetArrayLength(Processes)-1 do
  begin
    Exec('taskkill', '/f /im ' + Processes[i], '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;

function UnregisterHelperService(HelperPath: String): Boolean;
var
  ResultCode: Integer;
begin
  Result := False;
  if not FileExists(HelperPath) then Exit;
  Result := Exec(HelperPath, 'uninstall' + HelperInstallLockArguments, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
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
  ImagePath: String;
  FlagAt: Integer;
begin
  Result := ReadHelperRegistryString('SYSTEM\CurrentControlSet\Services\FlClashHelperService',
    'ImagePath', $10000006, ImagePath);
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
  Value: String;
  i: Integer;
begin
  HelperRecoveryPending := False;
  if not ReadHelperRegistryString(HelperRecoveryKey, 'Upgrade', 2, Value) then Exit;
  if TakeRecoveryField(Value) <> '1' then RaiseException('Unsupported FlClash helper recovery record');
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
begin
  OldHelperSHA256 := InstalledHash('FlClashHelperService.exe');
  OldCoreSHA256 := InstalledHash('FlClashCore.exe');
  if not RegWriteStringValue(HKLM, HelperRecoveryKey, 'Upgrade',
    '1|' + HelperOwnerSid + '|' + OldHelperSHA256 + '|' + OldCoreSHA256 + '|' + ExpandConstant('{app}')) then
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
  HelperHash, CoreHash: String;
  FilesComplete: Boolean;
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
      if AllowUnchangedFiles and (OldHelperSHA256 <> '') and (OldCoreSHA256 <> '') then
        FilesComplete := FilesComplete or ((HelperHash = OldHelperSHA256) and (CoreHash = OldCoreSHA256));
      if not FilesComplete then
        RaiseException('The FlClash helper files are incomplete. Run the installer again to repair them');
      if not Exec(ExpandConstant('{tmp}\FlClashHelperService.exe'),
        'install --owner-sid ' + HelperOwnerSid + ' --service-path "' +
        ExpandConstant('{app}\FlClashHelperService.exe') + '"' + HelperInstallLockArguments, '',
        SW_HIDE, ewWaitUntilTerminated, ResultCode) then
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
  PendingOwner: String;
begin
  Result := '';
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
      if RegKeyExists(HKLM, 'SYSTEM\CurrentControlSet\Services\FlClashHelperService') then
        RaiseException('The FlClash helper service account could not be read. Please retry the installation');
      HelperOwnerSid := PendingOwner;
    end;
    ExtractTemporaryFile('FlClashHelperService.exe');
    if HadHelperService and not HelperRecoveryPending then SaveHelperRecovery;
    if not UnregisterHelperService(ExpandConstant('{tmp}\FlClashHelperService.exe')) then
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

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    try
      if RestoreHelperService then RegisterHelperService(False);
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
  if not Result then Exit;
  Result := False;
  try
    LoadHelperRecovery;
    if UnregisterHelperService(ExpandConstant('{app}\FlClashHelperService.exe')) then
    begin
      ClearHelperRecovery;
      KillProcesses;
      Result := True;
    end;
  finally
    if not Result then ReleaseHelperInstallLock;
  end;
end;

procedure DeinitializeUninstall;
begin
  ReleaseHelperInstallLock;
end;

function PointsIntoApp(Value: String): Boolean;
begin
  Result := Pos(Lowercase(AddBackslash(ExpandConstant('{app}'))), Lowercase(Value)) > 0;
end;

{ The value name is appName in lib/common/constant.dart and the schemes are protocolSchemes in lib/common/protocol.dart. }
procedure RemoveUserRegistrations;
var
  Schemes: TArrayOfString;
  Value: String;
  i: Integer;
begin
  if RegQueryStringValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Run', '{{APP_NAME}}', Value) and PointsIntoApp(Value) then
  begin
    RegDeleteValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Run', '{{APP_NAME}}');
    RegDeleteValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run', '{{APP_NAME}}');
  end;

  Schemes := ['clash', 'clashmeta', 'flclash'];
  for i := 0 to GetArrayLength(Schemes)-1 do
  begin
    if RegQueryStringValue(HKCU, 'Software\Classes\' + Schemes[i] + '\shell\open\command', '', Value) and PointsIntoApp(Value) then
    begin
      RegDeleteKeyIncludingSubkeys(HKCU, 'Software\Classes\' + Schemes[i]);
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then RemoveUserRegistrations;
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
Filename: "{app}\\{{EXECUTABLE_NAME}}"; Description: "{cm:LaunchProgram,{{DISPLAY_NAME}}}"; Flags: {% if PRIVILEGES_REQUIRED == 'admin' %}runascurrentuser{% endif %} nowait postinstall skipifsilent
[UninstallRun]
Filename: "{app}\\{{EXECUTABLE_NAME}}"; Parameters: "--clear-stale-proxy"; Flags: runhidden skipifdoesntexist; RunOnceId: "ClearStaleProxy"
