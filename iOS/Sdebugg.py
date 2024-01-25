import sys
import os 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil

if __name__ == '__main__':
    print("main func bye bye !")
    
    # # 测试 修改 json
    # json_path = sys.argv[1]
    # key = sys.argv[2]
    # new_key = sys.argv[3]
    
    # JSONUtil.modify_json(json_path, key, new_key)
    
    
    # 测试 python 脚本。直接读取 jenkins 环境变量. 
    jenkins_job_name = os.environ.get('JOB_NAME')
    work_space = os.environ.get('WORKSPACE')
    is_china = os.environ.get('is_china')
    firebase_enable = os.environ.get('firebase_enable')
    
    print(f"jenkins_job_name : {jenkins_job_name}")
    print(f"is_china : {is_china}")
    print(f"WORKSPACE : {work_space}")
    print(f"firebase_enable : {firebase_enable}")