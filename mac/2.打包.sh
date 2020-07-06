#!/bin/bash

source ../tool/import.sh
source ../tool/JKSConfig.sh
source ../tool/projectConfig.sh
source ./config.sh

if [ ! -d "${WorkingAreaDir}/${APKPackageNameStr}" ]
then
	echo 请先执行解包脚本。
	exit
fi

if [[ "${WorkingAreaDir}" != "" ]] && [[ -d "${WorkingAreaDir}/${NewAPKPackageName}" ]]
then
	rm -rf "${WorkingAreaDir}/${NewAPKPackageName}"
fi

echo 开始打包。
#打包前，定位custom目录，遍历“输出数组”，找到对应的多个文件夹（文件夹下可能存在多个字目录），拷贝到项目res目录下“输入数组”对应序列的文件夹里面。
for projectFile in ${projectFileList[*]}
do
	array=(${projectFile//｜/ })
	fileName=${array[0]}
	searchFolder=${array[1]}
	outputFolder=${array[2]}
	outputDir=${WorkingAreaDir}/${APKPackageNameStr}/${searchFolder}
	# 搜索路径
	searchPath=${CustomDir}/${outputFolder}
	if [ ! -d "${searchPath}" ]
	then
		continue
	fi
	# 遍历路径内的指定文件
	for i in $(find "${searchPath}" -depth -name "${fileName}"); do
		# 截取左边的搜索路径
		cutSearchPath=${i#*${searchPath}/}
		# 截取右边的文件名称
		cutFileName=${cutSearchPath%${fileName}*}
		finalOutputDir=${outputDir}
		# 判断cutFileName是否为空
		if [[ "$cutFileName" != "" ]]; then
			# 拼接路径
			finalOutputDir=${outputDir}/${cutFileName}
		fi
		if [ -d "${finalOutputDir}" ]
		then
			cp -f $i "${finalOutputDir}"
		fi
	done
done

java -jar "$ApktoolJar" b "${WorkingAreaDir}/${APKPackageNameStr}" -o "${WorkingAreaDir}/${NewAPKPackageName}"
echo 开始签名。
if [ ! -d "${SignedDir}" ]
then
	mkdir -p "${SignedDir}"
fi

if [[ "${SignedDir}" != "" ]] && [[ -d "${SignedDir}/${SignedApkPackageName}" ]]
then
	rm -rf "${SignedDir}/${SignedApkPackageName}"
fi

jarsigner -verbose -keystore "${JKSPath}" -storepass ${JKSKey} -keypass ${JKSKey} -signedjar "${SignedDir}/${SignedApkPackageName}" "${WorkingAreaDir}/${NewAPKPackageName}" ${JKSAlias}
open "${SignedDir}"