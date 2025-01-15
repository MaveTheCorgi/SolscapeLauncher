[Setup]
AppName=Solscape Launcher
AppPublisher=Solscape
UninstallDisplayName=Solscape
AppVersion=${project.version}
AppSupportURL=https://solscape.games/
DefaultDirName={localappdata}\Solscape

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/app_small.bmp
WizardImageFile=${basedir}/innosetup/left.bmp
SetupIconFile=${basedir}/innosetup/app.ico
UninstallDisplayIcon={app}\Solscape.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=SolscapeSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x64\Solscape.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x64\Solscape.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Solscape\Solscape"; Filename: "{app}\Solscape.exe"
Name: "{userprograms}\Solscape\Solscape (configure)"; Filename: "{app}\Solscape.exe"; Parameters: "--configure"
Name: "{userprograms}\Solscape\Solscape (safe mode)"; Filename: "{app}\Solscape.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Solscape"; Filename: "{app}\Solscape.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Solscape.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Solscape.exe"; Description: "&Open Solscape"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Solscape.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.solscape\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"