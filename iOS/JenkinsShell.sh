
pwd

### Pod Spec Env Start

export PATH="/Users/platform/.rvm/rubies/ruby-2.6.3/bin:/Users/platform/.rvm/rubies/ruby-2.6.3/bin/pod:/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH"

pod_env_config_path="$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/pod_env/pod_env_config.json"
pod_internal_shell_path="$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/pod_env/autoUpdateInternalRepo.sh"

if [ ! -f "$pod_env_config_path" ]; then
	echo "缺少 pod_env 配置文件，请 copy 到 ${pod_env_config_path}"
    exit 1
fi

if [ ! -f "$pod_internal_shell_path" ]; then
	echo "缺少 执行pod 脚本文件，请 copy 到 ${pod_internal_shell_path}"
    exit 1
fi

# 根据指定的 pod_env ，写入配置文件
changePodEnvConfigScript="$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/pod_env/modifyConfig.py"
python3 $changePodEnvConfigScript $pod_env_config_path $pod_env

if [ $pod_source == "old" ]
then 
    ### 1. 首先删除 public spec 
    if [[ $repoList =~ "CenturyGameSDKPodSpecPublic" ]]
    then
        echo "本机 Pod Repo 已经存在 CenturyGameSDKPodSpecPublic ! 移除 Repo !" 
        updateOutput=`pod repo remove CenturyGameSDKPodSpecPublic`
        updateRes=$?
        if [[ $updateRes == 0 ]]
        then
            echo "remove CenturyGameSDKPodSpecPublic 执行成功"
        else
            echo "remove CenturyGameSDKPodSpecPublic 执行失败" 
        fi
    fi

    # 根据 pod_env，操作本地的 pod spec 仓库. 
    repoList=`pod repo list`
    echo ${repoList}
    dev_pod="platform-sdk/CenturyGameSDKPodSpecInternal.git"
    prod_pod="bitbucket.org/funplus/centurygamesdkpodspec.git"

    ### 设置 dev 和 prod 的 pod 环境
    if [ "$pod_env" == "dev" ]
    then
        echo "pod env : dev。删除 prod spec, 添加 dev spec "
        
        if [[ $repoList =~ $prod_pod ]]; then
            pod repo remove CenturyGameSDKPodSpec
        fi
        
        if [[ ! $repoList =~ $dev_pod ]]
        then
            pod repo add CenturyGameSDKPodSpecInternal https://gitlab.funplus.io/platform-sdk/CenturyGameSDKPodSpecInternal.git
        else
            pod repo update CenturyGameSDKPodSpecInternal --verbose
        fi
        
    elif [ "$pod_env" == "prod" ]
    then 
        echo "pod env : prod。删除 dev spec, 添加 prod spec "
        
        if [[ $repoList =~ $dev_pod ]]; then
            pod repo remove CenturyGameSDKPodSpecInternal
        fi
        
        if [[ ! $repoList =~ $prod_pod ]]
        then
            pod repo add CenturyGameSDKPodSpec https://platform-sdk@bitbucket.org/funplus/centurygamesdkpodspec.git
        else
            pod repo update CenturyGameSDKPodSpec --verbose
        fi
        
    else 
        echo "pod 环境错误 : $pod_env"
        exit 1
    fi
fi 


if [ $pod_source == "new" ]
then
    ### 移除 旧的 dev 和 prod spec 
    repoList=`pod repo list`
    echo ${repoList}
    dev_pod="platform-sdk/CenturyGameSDKPodSpecInternal.git"
    prod_pod="bitbucket.org/funplus/centurygamesdkpodspec.git"
    if [[ $repoList =~ $dev_pod ]]
    then
        echo "本机 Pod Repo 已经存在 CenturyGameSDKPodSpecInternal ! 移除 Repo !" 
        updateOutput=`pod repo remove CenturyGameSDKPodSpecInternal`
        updateRes=$?
        if [[ $updateRes == 0 ]]
        then
            echo "remove CenturyGameSDKPodSpecInternal 执行成功" 
        else
            echo "remove CenturyGameSDKPodSpecInternal 执行失败" 
        fi
    fi 

    if [[ $repoList =~ $prod_pod ]]
    then
        echo "本机 Pod Repo 已经存在 CenturyGameSDKPodSpec ! 移除 Repo !" 
        updateOutput=`pod repo remove CenturyGameSDKPodSpec`
        updateRes=$?
        if [[ $updateRes == 0 ]]
        then
            echo "remove CenturyGameSDKPodSpec 执行成功" 
        else
            echo "remove CenturyGameSDKPodSpec 执行失败" 
        fi
    fi

    ### 添加 新的 dev 和 prod spec 

fi

### Pod Spec Env End




### Certificate and Mobileprovision Start

cer_path="/Users/platform/.jenkins/workspace/Apple_Certificate_Notice/check"
py_script="/Users/platform/.jenkins/workspace/Apple_Certificate_Notice/getCerInfo.py"

game_key=$(python3 $py_script $cer_path $app_id 'game_key')
bundle_id=$(python3 $py_script $cer_path $app_id 'bundle_id')
team_id=$(python3 $py_script $cer_path $app_id 'team_id')
cert_name=$(python3 $py_script $cer_path $app_id 'cer_name')
provision_uuid=$(python3 $py_script $cer_path $app_id 'uuid')

codeSigin="iPhone Developer"

if [ "$push" = false ]; then
	push_provision_uuid="~" # 如果不开启push功能需要设置一个占位符，以免push_provision参数被下一个占用，导致参数错位
else  
	push_provision_uuid=$(python3 $py_script $cer_path $app_id 'push_uuid')
fi

echo "game id : ${app_id} \n"

echo "bundle_id : ${bundle_id} \n"
echo "team_id : ${team_id} \n"
echo "game_key : ${game_key}\n "
echo "cert_name : ${cert_name} \n"
echo "provision_uuid : ${provision_uuid}\n "
echo "push_provision_uuid : ${push_provision_uuid}\n "


### Certificate and Mobileprovision End 


### Advertising type map start
AD_TYPE=0
if [ "$ad_option" == "无" ]; then
  AD_TYPE=0
elif [ "$ad_option" == "admob" ]; then
  AD_TYPE=1
elif [ "$ad_option" == "max" ]; then
  AD_TYPE=2
elif [ "$ad_option" == "topon" ]; then
  AD_TYPE=4  
fi

echo "集成广告类型 ：${ad_option} -- ${AD_TYPE}"

### Advertising type map end



### 处理 Firebase start 
firebase_module_path="$WORKSPACE/Assets/CGUnityPlugins/Firebase"
unityFirebasePath="$firebase_module_path/Firebase"

cd $firebase_module_path
git clean -df
git reset --hard 
cd -

if [ "$is_China" = true ]; 
then
  if [ -d $unityFirebasePath ];
  then
  	rm -rf $unityFirebasePath
  	echo "国内包 - 移除 Firebase"
  fi
fi
### 处理 Firebase end


unityPath="/Applications/Unity/Unity.app/Contents/MacOS/Unity"
if [ "$unity_2019" = true ] ; then
    echo 'Be careful not to fall off!'
    unityPath="/Applications/Unity/Hub/Editor/2019.4.15f1/Unity.app/Contents/MacOS/Unity"
      
fi

unityPath="/Applications/Unity/Hub/Editor/2019.4.15f1/Unity.app/Contents/MacOS/Unity"

printf $unityPath


if [ ! -d "$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/" ]; then
  mkdir $WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/
fi

if [ ! -d "$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/$bundle_id" ]; then
  mkdir $WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/$bundle_id
fi

#if [[ -d $WORKSPACE/Packages/ ]]; then
#    rm -rf $WORKSPACE/Packages/
#fi


if [[ -d $WORKSPACE/Assets/DianDianSDK/Plugins/iOS/dd-ios-sdk/Admob/ ]]; then
    rm -rf $WORKSPACE/Assets/DianDianSDK/Plugins/iOS/dd-ios-sdk/Admob/
fi

if [[ -f $WORKSPACE/Assets/DianDianSDK/Editor/Dependencies/admobDependencies.xml ]]; then
    rm -rf $WORKSPACE/Assets/DianDianSDK/Editor/Dependencies/admobDependencies.xml
fi

if [[ -d $WORKSPACE/Assets/DianDianSDK/Plugins/iOS/dd-ios-sdk/Mopub/ ]]; then
    rm -rf $WORKSPACE/Assets/DianDianSDK/Plugins/iOS/dd-ios-sdk/Mopub/
fi

if [[ -f $WORKSPACE/Assets/DianDianSDK/Editor/Dependencies/mopubDependencies.xml ]]; then
    rm -rf $WORKSPACE/Assets/DianDianSDK/Editor/Dependencies/mopubDependencies.xml
fi



firebaseSwitch="false"

if [ "$firebase_enable" = true ] ; then
    printf 'firebase_enable = true!'
    
    #if [ ! -d /Users/platform/Desktop/SDK_config/$bundle_id/google-services.json ]; then
    #	printf $bundle_id+'包名下google-services.json不存在，无法继续！！！'
    #    return
	#fi
    #cp -f /Users/platform/Desktop/SDK_config/$bundle_id/GoogleService-Info.plist $WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/$bundle_id/
    firebaseSwitch="true"
fi

if [ "$max_enable" = true ]; then
    printf 'max_enable = true!'
    #cp -f /Users/platform/Desktop/SDK_config/$bundle_id/AppLovinQualityServiceSetup-ios.rb $WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/$bundle_id/
fi

# 获取新的配置
#/usr/local/bin/python '/Users/platform/.jenkins/workspace/sdk_config_making/MainRun.py' $app_id $game_key $bundle_id $WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/$bundle_id/ddCommon.json $game_mode "raid" "centurygame"
cp -f $WORKSPACE/ddCommon.json $WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/$bundle_id/


# 拷贝自定义logo
#mv $WORKSPACE/Assets/Sample/Resources/cg_custom_logo.png $WORKSPACE/Assets/DianDianSDK/Plugins/iOS/bundle/cg_custom_logo.png 
#mv $WORKSPACE/Assets/Sample/Resources/cg_custom_logo.png $WORKSPACE/Assets/Plugins/iOS/bundle/cg_custom_logo.png 



# 设置 Unity 颜色空间
if [ "$linear_color_space" = true ] ; then
    sed -i '' 's/\(m_ActiveColorSpace\): [0-9]\{1\}/\1: 1/g'  ProjectSettings/ProjectSettings.asset
else
    sed -i '' 's/\(m_ActiveColorSpace\): [0-9]\{1\}/\1: 0/g'  ProjectSettings/ProjectSettings.asset
fi

# 切换 native 平台
$unityPath -quit -batchmode -logFile tempLog1.txt -projectPath $WORKSPACE -buildTarget ios


# 修改unity 参数

# $unityPath -quit -batchmode -logFile tempArgLog.txt  -executeMethod BuildSample.BuildiOSArg -uuid $provision_uuid -provision $cert_name -teamid $team_id -identifier $bundle_id -sdkEnvironment $sdk_environment -push $push -pushServer $push_provision_uuid -splash $splash -appleSigin $appleSigin -firebase $firebaseSwitch -advertising_enable $AD_TYPE -advertising_pangle_enable $advertising_pangle_enable -advertising_fyber_enable $advertising_fyber_enable -advertising_applovin_enable $advertising_applovin_enable -advertising_adcolony_enable $advertising_adcolony_enable -advertising_chartboost_enable $advertising_chartboost_enable -advertising_ironsource_enable $advertising_ironsource_enable -advertising_mintergral_enable $advertising_mintergral_enable -advertising_tapjoy_enable $advertising_tapjoy_enable -advertising_vungle_enable $advertising_vungle_enable -product_id $PRODUCT_ID -disable_b2b_ad_unit_ids $disable_b2b_ad_unit_ids -universalLink $universalLink -adjustUniversalLink $adjustUniversalLink
$unityPath -quit -batchmode -logFile tempArgLog.txt  -executeMethod BuildSample.BuildiOSArg -uuid $provision_uuid -provision $cert_name -teamid $team_id -identifier $bundle_id -sdkEnvironment $sdk_environment -push $push -pushServer $push_provision_uuid -splash $splash -appleSigin $appleSigin -firebase $firebaseSwitch -advertising_enable $AD_TYPE -advertising_pangle_enable $advertising_pangle_enable -advertising_fyber_enable $advertising_fyber_enable -advertising_applovin_enable $advertising_applovin_enable -advertising_adcolony_enable $advertising_adcolony_enable -advertising_chartboost_enable $advertising_chartboost_enable -advertising_ironsource_enable $advertising_ironsource_enable -advertising_mintergral_enable $advertising_mintergral_enable -advertising_tapjoy_enable $advertising_tapjoy_enable -advertising_vungle_enable $advertising_vungle_enable -product_id $PRODUCT_ID -disable_b2b_ad_unit_ids $disable_b2b_ad_unit_ids -universalLink $universalLink -adjustUniversalLink $adjustUniversalLink -advertising_csj_enable $advertising_csj_enable -advertising_tencent_enable $advertising_tencent_enable -advertising_kuaishou_enable $advertising_kuaishou_enable -advertising_sigmob_enable $advertising_sigmob_enable  -gitlabPodToken "glpat-sF9isivbtJg1_y2kRqiP"  
sleep 20

# unity导出iOS项目
$unityPath -quit -batchmode -logFile tempLog.txt -executeMethod BuildSample.BuildiOS


cd $WORKSPACE/iOSDemo/

if [ ! -d "$WORKSPACE/iOSDemo/output/" ]; then
  mkdir $WORKSPACE/iOSDemo/output/
fi

# $SHPATH=$WORKSPACE/iOSDemo/Libraries/DianDianSDK/Plugins/iOS/dd-ios-sdk/install/buildIpa.sh

# 编译iOS项目成ipa安装包
# $SHPATH Unity-iPhone $WORKSPACE/iOSDemo 1 $provision_uuid

projPath=$WORKSPACE/iOSDemo

if [ "$max_enable" = true ];  then
	ruby AppLovinQualityServiceSetup-ios.rb
    sleep 60
fi

#rm -r /Users/platform/.jenkins/workspace/centurygame_build_ios_demo_in_global_unity_2019/iOSDemo/Frameworks/com.centurygame.rtm.plugin
xcodebuild archive -workspace Unity-iPhone.xcworkspace -scheme Unity-iPhone -configuration Release -archivePath $projPath/output/Unity-iPhone.xcarchive  CODE_SIGN_STYLE="Manual" CODE_SIGN_IDENTITY="$codeSigin" PROVISIONING_PROFILE_APP="$provision_uuid" PRODUCT_BUNDLE_IDENTIFIER_APP="$bundle_id"  > output/archiveLog.txt
xcodebuild -exportArchive -archivePath $projPath/output/Unity-iPhone.xcarchive -exportPath $projPath/output/ -exportOptionsPlist output/buildIpa.plist > output/ipaLog.txt


# 修改ipa的名字
mv $WORKSPACE/iOSDemo/output/*.ipa $WORKSPACE/iOSDemo/output/$app_id-Demo.ipa 
