#!/usr/bin/env bash 
Project_path=$(cd `dirname $0`; pwd)



# Xcode project 文件路径
cd ${Project_path}
Coopods_contain=false
for i in `ls`;
do
# 获取文件后缀名
extension=${i##*.}
if [[ ${extension} == "xcodeproj" ]]; then
Coopods_contain=false
elif [[ ${extension} == "xcworkspace" ]]; then
Coopods_contain=true
fi
done

# 更新cocopods
# if [[ ${Coopods_contain} == true ]]; then
	# pod install --verbose --no-repo-update
# fi
###############设置需编译的项目配置名称###############
APP_build_config="Debug" #编译的方式,有Release,Debug，自定义的AdHoc等
App_display_name="qweqweqwee213123"
App_version="1.9.9"

App_file_name=$(basename ./*.xcworkspace)
if $Coopods_contian; then
	# app文件名称
	App_file_name=$(basename ./*.xcworkspace)
else
	# app文件名称
	App_file_name=$(basename ./*.xcodeproj)
fi
# 通过app文件名获得工程target名字
APP_target_name=$(echo $App_file_name | awk -F. '{print $1}')
#app文件中Info.plist文件路径
App_infoplist_path=${Project_path}/${APP_target_name}/Info.plist
# 获取displayName值
App_display_name_default=$(/usr/libexec/PlistBuddy -c "print CFBundleDisplayName " ${App_infoplist_path})
# 获取 version值
App_version_default=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${App_infoplist_path})
# 获取build值
App_build_default=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${App_infoplist_path})
# 当前时间
current_date=`date +%Y%m%d%H%M`
# echo -e "\033[36m*******************************************************\033[0m"
# echo -e "\033[36m* APP_build_config		:${APP_build_config}\033[0m"
# echo -e "\033[36m* App_file_name  		:${App_file_name}\033[0m"
# echo -e "\033[36m* APP_target_name		:${APP_target_name}\033[0m"
# echo -e "\033[36m* App_display_name_default		:${App_display_name_default}\033[0m"
# echo -e "\033[36m* App_display_name		:${App_display_name}\033[0m"
# echo -e "\033[36m* App_version_default		:${App_version_default}\033[0m"
# echo -e "\033[36m* App_version默认值 = ${App_version}\033[0m"
# echo -e "\033[36m* App_infoplist_path		:${App_infoplist_path}\033[0m"
# echo -e "\033[36m* current_date		:${current_date}\033[0m"
# echo -e "\033[36m*******************************************************\033[0m"


#--------------------------------------------
# 修改App_display_name,修改App_version版本号以及App_build号
#--------------------------------------------
if [[ ${App_display_name_default} != ${App_display_name} ]]; then
	# echo -e "\033[36m* App_display_name默认值 = ${App_display_name_default}\033[0m"
	/usr/libexec/Plistbuddy -c "Set CFBundleDisplayName $App_display_name" "${App_infoplist_path}"
	Project_display_name=$(/usr/libexec/PlistBuddy -c "print CFBundleDisplayName" ${App_infoplist_path})
	# echo -e "\033[36m* App_display_name改变后 = ${Project_display_name}\033[0m"
else
	Project_display_name=$App_display_name_default
fi
if [[ ${App_version_default} != ${App_version} ]]; then
	# echo -e "\033[36m* App_version默认值 = ${App_version_default}\033[0m"
	/usr/libexec/Plistbuddy -c "Set CFBundleShortVersionString $App_version" "${App_infoplist_path}"
	Project_version=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${App_infoplist_path})
	# echo -e "\033[36m* App_version改变后 = ${Version_result}\033[0m"
else
	Project_version=$App_version_default
fi

if [[ ${App_build_default} != ${current_date} ]]; then
	# echo -e "\033[36m* App_build_default默认值 = ${App_build_default}\033[0m"
	/usr/libexec/Plistbuddy -c "Set CFBundleVersion $current_date" "${App_infoplist_path}"
	Project_build=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${App_infoplist_path})
	# echo -e "\033[36m* App_build改变后 = ${Project_build}\033[0m"
else
	Project_build=$App_build_default	
fi

#--------------------------------------------
# 准备打包
#--------------------------------------------
ExportOptionsPlist="${Project_path}/ExportOptions.plist"

rm -rf ./build
Build_path="${Project_path}/build"
mkdir -p $Build_path
rm -rf ./archive
Archive_path="${Project_path}/archive/${APP_target_name}.xcarchive"
mkdir -p "${Archive_path}"
Log_path="${Project_path}/archive/log"
#生成的app文件目录
App_direct_name=Release-iphoneos
if [ $APP_build_config = Debug ];then
	App_direct_name=Debug-iphoneos
fi
if [ $APP_build_config = Release ];then
	App_direct_name=Release-iphoneos
fi
#编译后文件路径(仅当编译workspace时才会用到)
compiled_path=${Build_path}/${App_direct_name}
mkdir -p "${compiled_path}"


Workspace_name="${Project_path}/${APP_target_name}.xcworkspace"
echo -e "\033[36m* Workspace_name        :${Workspace_name}\033[0m"
echo -e "\033[36m* Scheme_name        :${APP_target_name}\033[0m"
echo -e "\033[36m* Archive_path        :${Archive_path}\033[0m"
echo -e "\033[36m* Configuration        :${APP_build_config}\033[0m"
##############################xcodebuild clean##############################
# xcodebuild clean -workspace ${TARGET_NAME}.xcworkspace -scheme ${TARGET_NAME} -configuration ${BUILD_TYPE}
xcodebuild clean -workspace ${APP_target_name}.xcworkspace -scheme ${APP_target_name} -configuration ${APP_build_config} >>$Log_path
	if [ $? = 0 ]; then
		echo -e "\033[32m************* xcodebuild clean 完成 **************\033[0m"
		echo ''
	else
		echo -e "\033[31m************* xcodebuild clean 失败 **************\033[0m"
		echo ''
		exit;
	fi



##############################xcodebuild 编译##############################
echo -e "\033[36m************* xcodebuild 编译 ${Project_version} **************\033[0m" >> $Log_path
if $Coopods_contian; then
	# 编译workspace
	xcodebuild -workspace "${Workspace_name}" -scheme "${APP_target_name}" -configuration "${APP_build_config}" >> $Log_path
else
	#编译project
	xcodebuild -configuration "${APP_build_config}" >> $Log_path	
fi

if [ $? = 0 ]; then
echo -e "\033[32m************* xcodebuild 编译 完成 **************\033[0m" >> $Log_path
else
echo -e "\033[31m************* xcodebuild 编译 失败 **************\033[0m" >> $Log_path
exit;
fi



##############################xcodebuild 打包##############################
xcodebuild archive -workspace ${TARGET_NAME}.xcworkspace -scheme ${TARGET_NAME} -archivePath ${ARCHIVEPATH}
echo -e "\033[36m*************    打包 版本号 ${Project_version}    **************\033[0m"
echo "************* 开始导出xcarchive文件  *************"
if [[ ${Coopods_contain} = 'YES' ]]; then
	# 打包workspace

	# xcodebuild archive -workspace "${App_file_name}" -scheme "${APP_target_name}" -archivePath ${Archive_path} >> $Log_path
	xcodebuild archive -workspace "${Workspace_name}" -scheme "${APP_target_name}" -configuration "${APP_build_config}"\
	-archivePath "${Archive_path}" >> $Log_path
else
	#打包project
	xcodebuild -configuration "${APP_build_config}" >> $Log_path
fi
if [ $? = 0 ]; then
echo -e "\033[32m************* 导出xcarchive文件 完成 **************\033[0m"
echo ''
else
echo -e "\033[31m************* 导出xcarchive文件 失败 **************\033[0m"
echo ''
exit 1;
fi

# ##############################导出 ipa 文件##############################
# echo "*************   开始导出 ipa 文件    **************"
# # xcodebuild -exportArchive -archivePath "${Archive_path}" -exportPath "${IPA_path}" -exportOptionsPlist "${ExportOptionsPlist}" &>/dev/null
# xcodebuild -exportArchive -archivePath "${Archive_path}" -exportPath "${Archive_path}" -exportOptionsPlist "${ExportOptionsPlist}" >> $Log_path



