#!/bin/bash

# 为了测试:
WORKSPACE=`pwd`
NODE_AGENT_LABEL="deven"
unity_version="unity_2019"
uni_path=$(python3 ./Jenkins_Pipeline/iOS/Unity/UnityUtil.py -unitypath ${NODE_AGENT_LABEL} ${unity_version})
echo $uni_path

Unity_Path=$uni_path
echo "unity path : ${Unity_Path}"

# 1. 执行 iOS 平台
function specify_ios() {
    command="$Unity_Path -quit -batchmode -logFile tempLog1.txt -projectPath $WORKSPACE -buildTarget ios"
    echo "command : ${command}"
}
specify_ios


# 2. 修改 unity 参数

bundle_id=$(python3 Jenkins_Pipeline/iOS/Utils/JSONParser.py  -get  Jenkins_Pipeline/iOS/Temp/AppleCert.json  bundle_id)
cert_name=$(python3 Jenkins_Pipeline/iOS/Utils/JSONParser.py  -get  Jenkins_Pipeline/iOS/Temp/AppleCert.json  cert_name)
team_id=$(python3 Jenkins_Pipeline/iOS/Utils/JSONParser.py  -get  Jenkins_Pipeline/iOS/Temp/AppleCert.json  team_id)
provision_uuid=$(python3 ./Jenkins_Pipeline/iOS/Utils/JSONParser.py  -get  ./Jenkins_Pipeline/iOS/Temp/AppleCert.json  main_uuid)

if [ "$push" = false ]; then
	push_provision_uuid="~" # 如果不开启push功能需要设置一个占位符，以免push_provision参数被下一个占用，导致参数错位
else  
	push_provision_uuid=$(python3 ./Jenkins_Pipeline/iOS/Utils/JSONParser.py  -get  ./Jenkins_Pipeline/iOS/Temp/AppleCert.json  push_uuid)
fi

gitlab_pod_token=$(python3 Jenkins_Pipeline/iOS/Utils/JSONParser.py -get Jenkins_Pipeline/iOS/Config/Project/ProjectConfig.json gitlab_pod_token)
build_method=$(python3 Jenkins_Pipeline/iOS/Utils/JSONParser.py -get Jenkins_Pipeline/iOS/Config/Project/ProjectConfig.json unity_build_method)
build_log_file=$(python3 Jenkins_Pipeline/iOS/Utils/JSONParser.py -get Jenkins_Pipeline/iOS/Config/Project/ProjectConfig.json unity_build_log_file)





## 测试：
sdk_environment=sandbox

push=true
splash=true
appleSigin=true
firebaseSwitch=$Firebase_Switch
AD_TYPE=$AD_Type
PRODUCT_ID="我是 product id"
disable_b2b_ad_unit_ids="test disable_b2b_ad_unit_ids test"
universalLink="https://xxx.xxx.com"
adjustUniversalLink="https://xxxxxxxxx"

# advertising_pangle_enable=false
# advertising_fyber_enable=false
# advertising_applovin_enable=false
# advertising_adcolony_enable=false
# advertising_chartboost_enable=false
# advertising_ironsource_enable=false
# advertising_mintergral_enable=false
# advertising_tapjoy_enable=false
# advertising_vungle_enable=false

# advertising_pangle_enable=false
# advertising_pangle_enable=false
# advertising_pangle_enable=false
# advertising_pangle_enable=false

cmd="$Unity_Path \
-quit \
-batchmode \
-logFile ${build_log_file} \
-executeMethod ${build_method}\
-uuid ${provision_uuid} \
-provision $cert_name \
-teamid $team_id \
-identifier $bundle_id \
-sdkEnvironment $sdk_environment \
-push $push \
-pushServer $push_provision_uuid \
-splash $splash \
-appleSigin $appleSigin \
-firebase $Firebase_Switch \
-advertising_enable $AD_Type \
-product_id $produce_id \
-disable_b2b_ad_unit_ids $disable_b2b_ad_unit_ids \
-universalLink $universalLink \
-adjustUniversalLink $adjustUniversalLink \
-advertising_pangle_enable $advertising_pangle_enable \
-advertising_fyber_enable $advertising_fyber_enable \
-advertising_applovin_enable $advertising_applovin_enable \
-advertising_adcolony_enable $advertising_adcolony_enable \
-advertising_chartboost_enable $advertising_chartboost_enable \
-advertising_ironsource_enable $advertising_ironsource_enable \
-advertising_mintergral_enable $advertising_mintergral_enable \
-advertising_tapjoy_enable $advertising_tapjoy_enable \
-advertising_vungle_enable $advertising_vungle_enable \
-advertising_csj_enable $advertising_csj_enable \
-advertising_tencent_enable $advertising_tencent_enable \
-advertising_kuaishou_enable $advertising_kuaishou_enable \
-advertising_sigmob_enable $advertising_sigmob_enable \
-gitlabPodToken ${gitlab_pod_token} "

echo "cmd : ${cmd}"

# # 3. 导出 iOS Xcode 工程

# $Unity_Path -quit -batchmode -logFile tempLog.txt -executeMethod BuildSample.BuildiOS
