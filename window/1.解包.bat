@echo off

:: import bat
set current_path=%~dp0
cd /d %current_path%
set tool_path=%current_path:window=tool%
cd %tool_path%
call import.bat
call projectConfig.bat
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


:: 解包后，定位资源文件夹res，遍历“输入数组”，找到对应的多个文件（同一个名称可能存在多个文件），拷贝到custom目录下“输出数组”对应序列的文件夹里面。
if exist "%CustomDir%" (
	rd /s /q "%CustomDir%"
)
md "%CustomDir%"

set remain=%projectFileList%

set arr=%projectFileList%

:loopStartA

	for /f "delims=; tokens=1*" %%a in ("%remain%") do (
		set arr=%%a
		set remain=%%b
	)

	for /f "delims=# tokens=1-3" %%a in ("%arr%") do (
		set fileName=%%a
		set searchFolder=%%b
		set outputFolder=%%c
	)

	set outputDir=%CustomDir%\%outputFolder%
	:: 搜索路径
	set searchPath=%WorkingAreaDir%\%APKPackageNameStr%\%searchFolder%
	setlocal EnableDelayedExpansion
	::遍历路径内的指定文件
	if exist "%searchPath%" (
		cd /d "%searchPath%"
		::更新搜索路径
		set searchPath=!cd!
		for /f %%i in ('dir /s /b /a-d %fileName%') do (
			set fileDir=%%i
			:: 截取左边的搜索路径
			call :substringLeft !searchPath! %%i cutSearchPath
			:: 截取right边的搜索路径
			call :substringRight !cutSearchPath! %fileName% cutFileName
			set finalOutputDir=!outputDir!\!cutFileName!
			md "!finalOutputDir!" >nul 2>nul
			copy "!fileDir!" "!finalOutputDir!" >nul 2>nul
		)
	)
	if defined remain (
		goto :loopStartA
	)

cd /d %current_path%

start "" "%CustomDir%"

pause

:substringLeft
	set substringLeft_a=%1
	set substringLeft_b=%2
	:substringLeft_loopA
	for /f "delims=\ tokens=1*" %%a in ("%substringLeft_a%") do (
		set substringLeft_tempA=%%a
		set substringLeft_a=%%b
	)
	for /f "delims=\ tokens=1*" %%a in ("%substringLeft_b%") do (
		set substringLeft_tempB=%%a
		set substringLeft_b=%%b
	)
	if "%substringLeft_tempA%"=="%substringLeft_tempB%" (
		set %~3=%substringLeft_b%
		goto :substringLeft_loopA
	) 
goto :eof

:substringRight
	set substringRight_c=%1
	set substringRight_fileName=%2
	:substringRight_loopB
		for /f "delims=\ tokens=1*" %%a in ("%substringRight_c%") do (
			set substringRight_tempC=%%a
			set substringRight_c=%%b
		)
		if not "%substringRight_tempC%"=="%substringRight_fileName%" (
			if defined substringRight_cutFileName (
				set substringRight_cutFileName=%substringRight_cutFileName%\%substringRight_tempC%
			) else (
				set substringRight_cutFileName=%substringRight_tempC%
			)
			goto :substringRight_loopB
		)
	set %~3=%substringRight_cutFileName%
	set substringRight_cutFileName=
	set substringRight_tempC=
goto :eof
