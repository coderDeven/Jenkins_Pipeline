#!/bin/bash

# 为了测试:
# WORKSPACE=`pwd`
# NODE_AGENT_LABEL="deven"
# unity_version="unity_2019"
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
# # $ unity_path
# $Unity_Path \
# -quit \
# -batchmode \
# -logFile tempArgLog.txt \
# -executeMethod BuildSample.BuildiOSArg \
# -uuid $provision_uuid \
# -provision $cert_name \
# -teamid $team_id \
# -identifier $bundle_id \
# -sdkEnvironment $sdk_environment \
# -push $push \
# -pushServer $push_provision_uuid \
# -splash $splash \
# -appleSigin $appleSigin \
# -firebase $firebaseSwitch \
# -advertising_enable $AD_TYPE \
# -advertising_pangle_enable $advertising_pangle_enable \
# -advertising_fyber_enable $advertising_fyber_enable \
# -advertising_applovin_enable $advertising_applovin_enable \
# -advertising_adcolony_enable $advertising_adcolony_enable \
# -advertising_chartboost_enable $advertising_chartboost_enable \
# -advertising_ironsource_enable $advertising_ironsource_enable \
# -advertising_mintergral_enable $advertising_mintergral_enable \
# -advertising_tapjoy_enable $advertising_tapjoy_enable \
# -advertising_vungle_enable $advertising_vungle_enable \
# -product_id $PRODUCT_ID \
# -disable_b2b_ad_unit_ids $disable_b2b_ad_unit_ids \
# -universalLink $universalLink \
# -adjustUniversalLink $adjustUniversalLink \
# -advertising_csj_enable $advertising_csj_enable \
# -advertising_tencent_enable $advertising_tencent_enable \
# -advertising_kuaishou_enable $advertising_kuaishou_enable \
# -advertising_sigmob_enable $advertising_sigmob_enable  \
# -gitlabPodToken "glpat-sF9isivbtJg1_y2kRqiP"  

# # 3. 导出 iOS Xcode 工程

# $Unity_Path -quit -batchmode -logFile tempLog.txt -executeMethod BuildSample.BuildiOS