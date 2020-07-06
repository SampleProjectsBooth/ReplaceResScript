#!/bin/bash

source ../tool/import.sh
source ../tool/JKSConfig.sh
source ../tool/projectConfig.sh
source ./config.sh

if [ -d "${WorkingAreaDir}/${APKPackageNameStr}" ]
then
	echo 请先执行解包脚本。
	return
fi

if [ -d "${WorkingAreaDir}/${NewAPKPackageName}" ]
then
	rm -rf "${WorkingAreaDir}/${NewAPKPackageName}"
fi

#打包前，定位custom目录，遍历“输出数组”，找到对应的多个文件夹（文件夹下可能存在多个字目录），拷贝到项目res目录下“输入数组”对应序列的文件夹里面。

echo 开始打包。
java -jar "$ApktoolJar" b "${WorkingAreaDir}/${APKPackageNameStr}" -o "${WorkingAreaDir}/${NewAPKPackageName}"
echo 开始签名。
if [ ! -d "${SignedDir}" ]
then
	mkdir -p "${SignedDir}"
fi

if [ -d "${SignedDir}/${SignedApkPackageName}" ]
then
	rm -rf "${SignedDir}/${SignedApkPackageName}"
fi

jarsigner -verbose -keystore "${JKSPath}" -storepass ${JKSKey} -keypass ${JKSKey} -signedjar "${SignedDir}/${SignedApkPackageName}" "${WorkingAreaDir}/${NewAPKPackageName}" ${JKSAlias}
open "${SignedDir}"