@echo off

:: import bat
set current_path=%~dp0
cd /d %current_path%
set tool_path=%current_path:window=tool%
cd %tool_path%
call import.bat
cd /d %current_path%
call config.bat

if exist "%WorkingAreaDir%\%APKPackageNameStr%" (
	rd /s /q "%WorkingAreaDir%\%APKPackageNameStr%"
)

if not exist "%WorkingAreaDir%\%APKPackageName%" (
	echo 没有找到%APKPackageName%文件。请认真阅读window_README.md
	pause
	exit
)

echo begin decoded

%java_exe% -jar %ApktoolJar% d "%WorkingAreaDir%\%APKPackageName%" -o "%WorkingAreaDir%\%APKPackageNameStr%"

start "" "%WorkingAreaDir%\%APKPackageNameStr%"

pause