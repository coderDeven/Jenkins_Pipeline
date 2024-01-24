import sys
import os 

sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil

if __name__ == '__main__':
    
    print("设置 Mac 环境变量, 先不执行这一步, 测试是否有必要")
    
    # project_config_iOS_path = "iOS/Config/Agent/AgentConfig.json"
    # export_param_key_path = "dd.export_path"
    # path_env = JSONUtil.get_value_from_json_path(project_config_iOS_path, export_param_key_path)
    # command = "export PATH=" + '"' + path_env + '"'
    # print(command)
    # os.system(command)