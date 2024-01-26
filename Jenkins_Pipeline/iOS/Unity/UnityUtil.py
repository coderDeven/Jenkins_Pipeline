import sys 
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil

class UnityUtil:
    _unity_path = None 
    @classmethod
    def setup_linear_color_space(cls, color_space):
        if type(color_space) is str and color_space == "true":
            command = "sed -i '' 's/\(m_ActiveColorSpace\): [0-9]\{1\}/\1: 1/g'  ProjectSettings/ProjectSettings.asset"
        elif color_space == True:
            command = "sed -i '' 's/\(m_ActiveColorSpace\): [0-9]\{1\}/\1: 1/g'  ProjectSettings/ProjectSettings.asset"
        else:
            command = "sed -i '' 's/\(m_ActiveColorSpace\): [0-9]\{1\}/\1: 0/g'  ProjectSettings/ProjectSettings.asset"
        os.system(command)
        
    @classmethod
    def get_unity_path(cls, agent_name, unity_version):
        agent_config_path = "Jenkins_Pipeline/iOS/Config/Agent/AgentConfig.json"
        key_path = f"{agent_name}.unity.{unity_version}"
        cls._unity_path = JSONUtil.get_value_from_json_path(agent_config_path, key_path)
        return cls._unity_path
        

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("CGError : Param missing !")
        sys.exit(1)
    
    method_name = sys.argv[1]
    
    if not method_name.__contains__('-'):
        sys.exit('CGError : method name not specified !')
    
    if method_name.__eq__("-colorspace"):
        color_space = sys.argv[2]
        UnityUtil.setup_linear_color_space(color_space)
        
    if method_name.__eq__("-getpath"):
        agent_label_name = sys.argv[2]
        unity_version = sys.argv[3]
        unity_path = UnityUtil.get_unity_path(agent_label_name, unity_version)
        print(unity_path)