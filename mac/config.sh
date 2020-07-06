#!/bin/bash

#apk包名
APKPackageName=MobileOAHybrid_3.2_release.apk

#apk字符串
APKPackageNameStr=${APKPackageName%.*}

#打包apk包名
NewAPKPackageName=${APKPackageNameStr}_repack.apk
#重签名apk包名
SignedApkPackageName=${APKPackageNameStr}_signed.apk