
### 
# warning  -- TODO
### 

# 需要通过 Agent 来从 config 文件中读取证书管理的地址. 
# agent=$3 
agent=deven

game_id=$1
push_enable=$2

apple_cert_path=`python3 iOS/Utils/JSONParser.py -get ./iOS/Config/Agent/AgentConfig.json "${agent}.apple_cert_path"`
echo $apple_cert_path

cer_path="${apple_cert_path}/check"
get_cer_info_script="${apple_cert_path}/getCerInfo.py"

game_key=$(python3 $get_cer_info_script $cer_path $game_id 'game_key')
bundle_id=$(python3 $get_cer_info_script $cer_path $game_id 'bundle_id')
team_id=$(python3 $get_cer_info_script $cer_path $game_id 'team_id')
cert_name=$(python3 $get_cer_info_script $cer_path $game_id 'cer_name')
provision_uuid=$(python3 $get_cer_info_script $cer_path $game_id 'uuid')


if [ "$push_enable" = false ]; then
	push_provision_uuid="~" # 如果不开启push功能需要设置一个占位符，以免push_provision参数被下一个占用，导致参数错位
else  
	push_provision_uuid=$(python3 $get_cer_info_script $cer_path $game_id 'push_uuid')
fi

echo "bundle_id : ${bundle_id} \n"
echo "team_id : ${team_id} \n"
echo "game_key : ${game_key}\n "
echo "cert_name : ${cert_name} \n"
echo "provision_uuid : ${provision_uuid}\n "
echo "push_provision_uuid : ${push_provision_uuid}\n "