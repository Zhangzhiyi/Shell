#!/bin/sh
firstarg=${0}
firstchar=${firstarg:0:1} #取第一个字符判断是绝对路径还是相对路径
if [ $firstchar == "/" ]; then
	here=`which "$0" 2>/dev/null || echo .`
	ios_path="`dirname $here`"
else
	ios_path=${PWD} #ios的根目录
fi
if [ $# -lt 1 ]; then
	echo "请输入：debug or release"
	exit
fi
security find-certificate -c "iPhone Distribution: Guangzhou Mingchao Information Technology Co., Ltd.  (7T9FVP7WY3)"
if [ $? -ne 0 ]; then
	echo "导入证书"
	security import ${ios_path}/distribution.p12 -k login.keychain -P mingchao #导入证书
else
	echo "找到证书"
fi
ipa_path="${ios_path}/../ipa" #存储ipa的目录

if [[ $1 == "debug" ]]; then
	echo "debug"
	infoplist=${ios_path}/MGMClient-Info.plist
	configuration="Debug"
	target="MGMClient"
	ipa_name="MGMClient_Debug.ipa"
	sign="iPhone Distribution: Guangzhou Mingchao Information Technology Co., Ltd.  (7T9FVP7WY3)"
	provisioningfile="MGMClient_AdHoc.mobileprovision"
elif [[ $1 == "release" ]]; then
	echo "release"
	infoplist=${ios_path}/MGMClient_Release-Info.plist
	configuration="Release"
	target="MGMClient_Release"
	ipa_name="MGMClient_AdHoc.ipa"
	sign="iPhone Distribution: Guangzhou Mingchao Information Technology Co., Ltd.  (7T9FVP7WY3)"
	provisioningfile="MGMClient_AdHoc.mobileprovision"
fi
# #读取CFBundleShortVersionString和CFBundleVersion
# bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${infoplist})
# echo "bundleShortVersion:"$bundleShortVersion
# bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${infoplist})
# echo "bundleVersion:"$bundleVersion
# #CFBundleVersion自增
# bundleVersion=$(expr $bundleVersion + 1)
# /usr/libexec/PlistBuddy -c "set CFBundleVersion $bundleVersion" ${infoplist}

cocos2dxpath="${ios_path}/../../cocos2dx/proj.ios"
cd ${cocos2dxpath}
echo ${cocos2dxpath}
xcodebuild -configuration ${configuration} -target cocos2dx clean
if [ $? -ne 0 ]; then
	exit 101
fi
xcodebuild -configuration ${configuration} -target cocos2dx
if [ $? -ne 0 ]; then
	exit 102
fi
cd ${ios_path}
#清理工程
xcodebuild -configuration ${configuration} -target ${target} clean
if [ $? -ne 0 ]; then
	echo "清理工程出错"
	exit
else
	echo "clean success"
fi
#编译工程
xcodebuild -configuration ${configuration} -target ${target}
if [ $? -ne 0 ]; then
	echo "编译工程出错"
	exit
else
	echo "build success"
fi
#打包ipa格式
xcrun -sdk iphoneos PackageApplication -v ${ios_path}/build/${configuration}-iphoneos/${target}.app -o ${ipa_path}/${ipa_name} -sign "${sign}" -embed "${provisioningfile}"
if [ $? -ne 0 ]; then
	echo "打包ipa格式出错"
	exit
else
	echo "archive success"
fi
