@echo off

:: apk包名

set APKPackageName=MobileOAHybrid_3.2_release.apk

:: apk字符串
set APKPackageNameStr=%APKPackageName%

:: 调用截取字符串
call:func_substring APKPackageNameStr %APKPackageNameStr%

:: 打包apk包名

set NewAPKPackageName=%APKPackageNameStr%_repack.apk

:: 重签名apk包名

set SignedApkPackageName=%APKPackageNameStr%_signed.apk

goto :out

:: 截取字符串方法
:func_substring

	set seq=.

	set remain=%2

	:loop
		for /f "tokens=1* delims=%seq%" %%a in ("%remain%") do (
			set lastStr=%%a
			set remain=%%b
		)
	

	if defined remain (
		if not "%remain%" == "%2" (
			if defined result (
				set result=%result%%seq%%lastStr%
			) else (
				set result=%lastStr%
			)
			goto :loop
		)
	)

	if defined result (
		set %~1=%result%
	)
goto:eof

:out