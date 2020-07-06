@echo off

:: import bat
set current_path=%~dp0
cd /d %current_path%
set tool_path=%current_path:window=tool%
cd %tool_path%
call import.bat
cd /d %current_path%
call config.bat

goto :test

if not exist "%WorkingAreaDir%\%APKPackageNameStr%" (
	exit /b because exist "%WorkingAreaDir%\%APKPackageNameStr%"
)

if exist "%WorkingAreaDir%\%NewAPKPackageName%" (
	del "%WorkingAreaDir%\%NewAPKPackageName%"
)

echo begin encoded

%java_exe% -jar %ApktoolJar% b "%WorkingAreaDir%\%APKPackageNameStr%" -o "%WorkingAreaDir%\%NewAPKPackageName%"

:test
echo begin signed
if not exist "%SignedDir%" (
	md "%SignedDir%"
)

if exist "%SignedDir%\%SignedApkPackageName" (
	del "%SignedDir%\%SignedApkPackageName"
)

%jarsigner_exe% -verbose -keystore "%JKSPath%" -storepass %JKSKey% -keypass %JKSKey% -signedjar "%SignedDir%\%SignedApkPackageName%" "%WorkingAreaDir%\%NewAPKPackageName%" %JKSAlias%

start "" "%SignedDir%"

pause