#!/bin/bash -l
Project_path=$(cd `dirname $0`; pwd)

# Xcode project 文件路径
cd ${Project_path}
Cocoapods_contain=false
for i in `ls`;
do
# 获取文件后缀名
extension=${i##*.}
if [[ ${extension} == "xcodeproj" ]]; then
Cocoapods_contain=false
elif [[ ${extension} == "xcworkspace" ]]; then
Cocoapods_contain=true
fi
done

# 更新cocoapods
if $Cocoapods_contain; then
pod install --verbose --no-repo-update
fi

###############设置需编译的项目配置名称###############
APP_build_config="Debug" #编译的方式,有Release,Debug，自定义的AdHoc等
App_display_name="测试"
App_version="1.9.9"
App_team_ID="Y4CQMPSC2J"
App_file_name=$(basename ./*.xcworkspace)
if $Cocoapods_contain; then
# app文件名称
App_file_name=$(basename ./*.xcworkspace)
else
# app文件名称
App_file_name=$(basename ./*.xcodeproj)
fi
# 通过app文件名获得工程target名字
APP_target_name=$(echo $App_file_name | awk -F. '{print $1}')
#app文件中Info.plist文件路径
App_infoplist_path="${Project_path}/${APP_target_name}/Info.plist"
# 获取displayName值
App_display_name_default=$(/usr/libexec/PlistBuddy -c "print CFBundleDisplayName " ${App_infoplist_path})
# 获取 version值
App_version_default=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${App_infoplist_path})
# 获取build值
App_build_default=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${App_infoplist_path})
# 当前时间
current_date=`date +%Y%m%d%H%M`

#--------------------------------------------
# 修改App_display_name,修改App_version版本号以及App_build号
#--------------------------------------------
if [[ ${App_display_name_default} != ${App_display_name} ]]; then
echo -e "\033[33m* App_display_name默认值 = ${App_display_name_default}\033[0m"
/usr/libexec/Plistbuddy -c "Set CFBundleDisplayName $App_display_name" "${App_infoplist_path}"
Project_display_name=$(/usr/libexec/PlistBuddy -c "print CFBundleDisplayName" ${App_infoplist_path})
echo -e "\033[33m* App_display_name改变后 = ${Project_display_name}\033[0m"
else
Project_display_name=$App_display_name_default
fi
if [[ ${App_version_default} != ${App_version} ]]; then
echo -e "\033[33m* App_version默认值 = ${App_version_default}\033[0m"
/usr/libexec/Plistbuddy -c "Set CFBundleShortVersionString $App_version" "${App_infoplist_path}"
Project_version=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${App_infoplist_path})
echo -e "\033[33m* App_version改变后 = ${Version_result}\033[0m"
else
Project_version=$App_version_default
fi

if [[ ${App_build_default} != ${current_date} ]]; then
echo -e "\033[33m* App_build_default默认值 = ${App_build_default}\033[0m"
/usr/libexec/Plistbuddy -c "Set CFBundleVersion $current_date" "${App_infoplist_path}"
Project_build=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${App_infoplist_path})
echo -e "\033[33m* App_build改变后 = ${Project_build}\033[0m"
else
Project_build=$App_build_default
fi


#--------------------------------------------
# 准备打包
#--------------------------------------------
##############################生成ExportOptionsPlist文件##############################
ExportOptionsPlist="${Project_path}/ExportOptions.plist"
cat << EOF > $ExportOptionsPlist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>compileBitcode</key>
<false/>
<key>method</key>
<string>development</string>
<key>signingStyle</key>
<string>automatic</string>
<key>stripSwiftSymbols</key>
<true/>
<key>teamID</key>
<string>$App_team_ID</string>
</dict>
</plist>
EOF
if [ $? = 0 ]; then
echo -e "\033[32m************* 生成ExportOptionsPlist文件 成功 **************\033[0m"
else
echo -e "\033[31m************* 生成ExportOptionsPlist文件 失败 **************\033[0m"
exit;
fi


rm -rf ./build
Build_path="${Project_path}/build"
mkdir -p $Build_path
rm -rf ./archive
Archive_path="${Project_path}/archive"
mkdir -p "${Archive_path}"
Log_path="${Build_path}/log"
#生成的app文件目录
App_direct_name=Release-iphoneos
if [ $APP_build_config = Debug ];then
App_direct_name=Debug-iphoneos
fi
if [ $APP_build_config = Release ];then
App_direct_name=Release-iphoneos
fi

Workspace_name="${Project_path}/${APP_target_name}.xcworkspace"
if $Cocoapods_contain; then
Workspace_name="${Project_path}/${APP_target_name}.xcworkspace"
else
Workspace_name="${Project_path}/${APP_target_name}.xcodeproj"
fi

############################## xcodebuild clean ##############################
if $Cocoapods_contain; then
xcodebuild clean -workspace ${APP_target_name}.xcworkspace -scheme ${APP_target_name}\
-configuration ${APP_build_config} >>$Log_path
else
xcodebuild clean -project ${APP_target_name}.xcodeproj -scheme ${APP_target_name} \
-configuration ${APP_build_config} >>$Log_path
fi
if [ $? = 0 ]; then
echo -e "\033[32m************* xcodebuild clean 完成 **************\033[0m"
echo -e ""
else
echo -e "\033[31m************* xcodebuild clean 失败 **************\033[0m"
echo -e ""
exit;
fi


##############################xcodebuild 编译##############################
echo -e "\033[36m************* xcodebuild 编译 ${Project_version} **************\033[0m"
if $Cocoapods_contain; then
# 编译workspace
xcodebuild -workspace "${Workspace_name}" -scheme "${APP_target_name}" -configuration "${APP_build_config}"\
CONFIGURATION_BUILD_DIR="${Build_path}/${App_direct_name}">> $Log_path
else
#编译project
xcodebuild -project "${Workspace_name}" -scheme "${APP_target_name}" -configuration "${APP_build_config}"\
CONFIGURATION_BUILD_DIR="${Build_path}/${App_direct_name}">> $Log_path
fi

if [ $? = 0 ]; then
echo -e "\033[32m************* xcodebuild 编译 完成 **************\033[0m"
echo -e ""
else
echo -e "\033[31m************* xcodebuild 编译 失败 **************\033[0m"
echo -e ""
exit;
fi


##############################导出xcarchive文件##############################
echo -e "\033[36m************* 导出xcarchive文件 ${Project_version} **************\033[0m"
if $Cocoapods_contain; then
# 打包workspace
xcodebuild archive -workspace "${Workspace_name}" -scheme "${APP_target_name}" -configuration "${APP_build_config}" \
-archivePath "${Build_path}/${APP_target_name}.xcarchive"
else
# 打包project
xcodebuild archive -project "${Workspace_name}" -scheme "${APP_target_name}" -configuration "${APP_build_config}" \
-archivePath "${Build_path}/${APP_target_name}.xcarchive" >> $Log_path
fi

if [ $? = 0 ]; then
echo -e "\033[32m************* 导出xcarchive文件 完成 **************\033[0m"
echo -e ""
else
echo -e "\033[31m************* 导出xcarchive文件 失败 **************\033[0m"
echo -e ""
exit;
fi

# ##############################导出 ipa 文件##############################
echo -e "\033[36m************* 导出 ipa 文件 **************\033[0m"
xcodebuild -exportArchive -archivePath "${Build_path}/${APP_target_name}.xcarchive" -exportPath "${Archive_path}" \
-exportOptionsPlist "${ExportOptionsPlist}" >> $Log_path
if [ $? = 0 ]; then
echo -e "\033[32m************* 导出 ipa 文件 完成 **************\033[0m"
echo -e ""
else
echo -e "\033[31m************* 导出 ipa 文件 失败 **************\033[0m"
echo -e ""
exit;
fi
