# external param : pod_env -- from jenkins job 

# 本地测试使用:
# WORKSPACE=`pwd`
# pod_env='prod'

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

# modify pod env 
# 将 Jenkins 选定的 Pod 环境参数 （dev/prod）写入到配置文件中.
pod_env_key="pod_env"

json_parser_script="$WORKSPACE/Jenkins_Pipeline/iOS/Utils/JSONParser.py"
python3 $json_parser_script -set $pod_env_config_path $pod_env_key $pod_env

source ./Jenkins_Pipeline/iOS/Pod/RemoveSDKPodSpec.sh