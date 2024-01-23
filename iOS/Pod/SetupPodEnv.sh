pod_env=$1

# Pod 隔离所需的配置文件和脚本
pod_env_config_path="$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/pod_env/pod_env_config.json"
pod_internal_shell_path="$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/pod_env/autoUpdateInternalRepo.sh"
change_pod_env_config_script="$WORKSPACE/Assets/WebPlayerTemplates/dd-sdk-config/pod_env/modifyConfig.py"

if [ ! -f "$pod_env_config_path" ]; then
	echo "Unity 工程文件夹中缺少 pod_env 配置文件，请将合适的 pod_env 配置文件放置到 ${pod_env_config_path}"
    exit 1
fi

if [ ! -f "$pod_internal_shell_path" ]; then
	echo "Unity 工程文件夹中缺少 Pod 所需脚本文件，请将合适的 autoUpdateInternalRepo.sh 脚本放置到 ${pod_internal_shell_path}"
    exit 1
fi

# 将 Jenkins 选定的 Pod 环境参数 （dev/prod）写入到配置文件中.
python3 $change_pod_env_config_script $pod_env_config_path $pod_env

# 删除所有 Spec 
repoList=`pod repo list`
echo ${repoList}
dev_pod="platform-sdk/CenturyGameSDKPodSpecInternal.git"
prod_pod="bitbucket.org/funplus/centurygamesdkpodspec.git"
gitlab_public_pod="platform-sdk-ios-pod/CenturyGameSDKPodSpecPublic.git"

## 删除 Gitlab Public Spec
if [[ $repoList =~ $gitlab_public_pod ]]
then
    echo "本机 Pod Repo 存在 CenturyGameSDKPodSpecPublic -> 移除 Repo !" 
    updateOutput=`pod repo remove CenturyGameSDKPodSpecPublic`
    updateRes=$?
    if [[ $updateRes == 0 ]]
    then
        echo "remove CenturyGameSDKPodSpecPublic 执行成功"
    else
        echo "remove CenturyGameSDKPodSpecPublic 执行失败" 
    fi
fi

## 删除 Gitlab Internal Spec 
if [[ $repoList =~ $dev_pod ]]
then
    echo "本机 Pod Repo 存在 CenturyGameSDKPodSpecInternal -> 移除 Repo !" 
    updateOutput=`pod repo remove CenturyGameSDKPodSpecInternal`
    updateRes=$?
    if [[ $updateRes == 0 ]]
    then
        echo "remove CenturyGameSDKPodSpecInternal 执行成功"
    else
        echo "remove CenturyGameSDKPodSpecInternal 执行失败" 
    fi
fi

## 删除 Bitbucket Prod Spec 
if [[ $repoList =~ $prod_pod ]]
then
    echo "本机 Pod Repo 存在 CenturyGameSDKPodSpec -> 移除 Repo !" 
    updateOutput=`pod repo remove CenturyGameSDKPodSpec`
    updateRes=$?
    if [[ $updateRes == 0 ]]
    then
        echo "remove CenturyGameSDKPodSpec 执行成功"
    else
        echo "remove CenturyGameSDKPodSpec 执行失败" 
    fi
fi
