@echo off

set rootDir=%~dp0..

:: 工具目录

set ToolDir=%rootDir%\tool

:: 解包/打包工具

set ApktoolJar=%ToolDir%\apktool_2.4.1.jar

:: 工作区域

set WorkingAreaDir=%rootDir%\workingArea

:: JKS相关配置

rem set JKSPath=%ToolDir%\MobileOAHybrid.jks

rem set JKSKey=

rem set JKSAlias=

:: 重签名目录

set SignedDir=%rootDir%\signed

:: JAVA 命令

set java_exe=%ToolDir%\jre1.8.0_201\bin\java.exe

if defined JAVA_HOME (
	set java_exe=%JAVA_HOME%\bin\java.exe
)

set jarsigner_exe=%ToolDir%\jdk1.8.0_181\bin\jarsigner.exe

::自定义目录

set CustomDir=%rootDir%\custom