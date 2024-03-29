# python3 ./Utils/AES/AESParser.py 

# apple_cert_path=`python3 Utils/JSONParser.py -set iOS/Config/Project/ProjectConfig.json test_key.abc luck`
# echo $apple_cert_path


# apple_cert_path=`python3 Utils/JSONParser.py iOS/Config/Agent/AgentConfig.json dd.apple_cert_path`
# echo $apple_cert_path


# 测试 AES 解析并读取 json 中key 
# cipher_key="sctucodm5vc9llbt61j8jpymt4kuilkw"
# cipher_content="BGlA+9uLMBdvtM1k3oHir6MZYPKSgrTt+0iACflzImdC3Socz4KjT0KWOF9ADYwVdiGGtwfxfdIOPEcfaKLYSQdhPE1LNJTbPY8jLmTg6nAsYE6l5SVWkgZLdmsN+fLsUjaIIOIi/402XGYBzk7cIdiZQ0sobsC58eAf3W8XSViU4X8IxKRJ0efBhNTgLB2FWsxSc6VmIhy7RNjkUAdwI0jpSg4HfVxoO22VKfsEz5YCmtK9/X1rm+6Hz8Sjw9/0ObMBnxfgp/c5kimWrOCujVmL2gPKOHRy7WIHysuaHvjyiwet9QSuUi7REbQxrQ5ebO4pEww4Iaa9ixLZMao7lotGmSWYHtGBgv/0qctRVxoo9TS6nNJQE9v2e5ELfGEaanT+thNvBDJgwoeDoZ8uHe4/iBxCTm5TaEOwl4CMwk5Ul9MQl+ZCfYhpUB/2KEaMTaXwcN540CxRprIeotPVEMMt+pDiRsBzHMDJF4TLdRectzY4mtxaRGrjyz/ZvZl3egBCkKubEYn0NYEpWKsEHZhvI1i2gvtnnuFL1haVNfpBL48eH9VdPIqsDz1A6N8C6FJHf0VU87OOb1jUWvaprGEj995bD3P8/goh/b97s4KesbC7wFeql2KzomcMhDCynK77n/JXHZFsRHo+rPkJIb+Vhv2DMjPZzD4ZPInJPLyiA97zb2qMjIl04qf/4fpgOzBPJ8jfj5ZSWvq+i7OTHeSD1tKeF6w1btxOFC+9bGmKfYDlh5bZsBAvG8oZZKttE65DdN20GW7YfChiOav9J4FiCkiMYfSMBEZL0lrGZDbzmOqWJsxmk9jrJ6rQVJ+/g1v07uQ8SooDFgHedNH4itHih4bUzjOCnGpRc3MsyktQ0WJHBStzRuZUWg51azVb+RnY8nJw+pi0XRFtKyhCOZF6kNsbPH0Z6PqlUGoHByEw84yQIzg/9H7sOa6UFcCkCoTAq3XLYFPVZSGyZvsjRDVg86UGF2Ars176LSOrcPE2IysFGTRSCdJ5nIFGAwqzOMuVW1U2TWjOgwMSgBSX/KV9vOm2n2bUJl4WsRp0lgkOT80ahBUtotHofBXnt3dKJfyj4vMxhoTYAI1XEI5TBpvhg6BmlEFqaDVYaFJzkYGpyb2WE4fejWDBxh1e0R1BW0V4EDz5+AqL8JF7+wtRt+bSFxwyskoTmKznh3coixAOT80ahBUtotHofBXnt3dKbUStTPLVvVow1USr1zHFmifszKgK+5Nv2XGMMWPeMKYLkthduPEJB6sb+SbAk0d3V0JfYMAvp3sAWK+c3lysDTb1AjGPdJzMGXKn90R89P2jV1KQFAgrMLShlHKFwIbr+OsbwP1be7v8ugl7GoW+hj8dLKfyoIoi5V9dBuHJNpdUDGXpzBie6jCqta3XiMUxEQ9PwbGP5FEeZYaSkWTDylhje9tI0Ri/exRdAIZiaBU="
# res=`python3 Utils/AESParser.py $cipher_key $cipher_content 'pod_group_token'`
# echo $res

# 测试修改 config.json

# echo "直接在脚本中使用 job param :"
# echo "${WORKSPACE}"
# echo "${game_id}"

# Error : 不能用 params
# ehco "${params.game_id}"


# my_string="Hello World"

# lowercase_string=$(echo "$my_string" | tr '[:upper:]' '[:lower:]')

# echo "Lowercase string: $lowercase_string"


# repoList=$(echo `pod repo list`)
# echo "repoList: ${repoList}" 

# echo "\n\n"

# repoList=$(echo "${repoList}" | tr '[:upper:]' '[:lower:]')
# echo $repoList

# $my_string 
# -quit 
# -batchmode 
# -logFile ${}


# Unity_Path=$(python3 ./iOS/Unity/UnityUtil.py -getpath deven unity_2019)
# Unity_Path=sh "python3 iOS/Unity/UnityUtil.py -getpath deven unity_2019"
# echo $Unity_Path


# Unity_Path=$(sh 'iOS/Unity/UnitySetup.sh')
# echo "fuck :$Unity_Path"