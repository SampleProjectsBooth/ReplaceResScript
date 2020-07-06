#!/bin/bash

source ../tool/import.sh
source ../tool/JKSConfig.sh
source ../tool/projectConfig.sh
source ./config.sh

if [ -d "${WorkingAreaDir}/${APKPackageNameStr}" ]
then
	rm -rf "${WorkingAreaDir}/${APKPackageNameStr}"
fi

if [ ! -f "${WorkingAreaDir}/${APKPackageName}" ]
then
	echo 没有找到${APKPackageName}文件。请认真阅读mac_README.md
	exit
fi

echo 开始解包。
java -jar "$ApktoolJar" d "${WorkingAreaDir}/${APKPackageName}" -o "${WorkingAreaDir}/${APKPackageNameStr}"

#解包后，定位资源文件夹res，遍历“输入数组”，找到对应的多个文件（同一个名称可能存在多个文件），拷贝到custom目录下“输出数组”对应序列的文件夹里面。

if [ -d "${CustomDir}" ]
then
	rm -rf "${CustomDir}"
fi

for projectFile in ${projectFileList[*]}
do
	array=(${projectFile//｜/ })
	fileName=${array[0]}
	searchFolder=${array[1]}
	outputFolder=${array[2]}
	outputDir=${CustomDir}/${outputFolder}
	# 搜索路径
	searchPath=${WorkingAreaDir}/${APKPackageNameStr}/${searchFolder}
	if [ ! -d "${searchPath}" ]
	then
		continue
	fi
	# 遍历路径内的指定文件
	for i in $(find "${searchPath}" -depth -name "${fileName}"); do
		cutSearchPath=${i#*${searchPath}/}
		cutFileName=${cutSearchPath#*${fileName}}
		finalOutputDir=${outputDir}
		# 判断cutFileName是否为空
		if [ -z "$cutFileName" ]; then
			# 拼接路径
			finalOutputDir=${outputDir}/${cutFileName}
		fi
		if [ ! -d "${finalOutputDir}" ]
		then
			mkdir -p "${finalOutputDir}"
		fi
		cp -f $i "${finalOutputDir}"
	done
done


open "${CustomDir}"
