import sys
import os 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil

if __name__ == '__main__':
    print("main func bye bye !")
    
    # 测试 修改 json
    json_path = sys.argv[1]
    key = sys.argv[2]
    new_key = sys.argv[3]
    
    JSONUtil.modify_json(json_path, key, new_key)