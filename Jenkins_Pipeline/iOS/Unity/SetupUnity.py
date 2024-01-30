import os
import sys 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil
from Base.CGBase import CGErrorCode
from UnityUtil import UnityUtil

class UnityManager:
    _unity_binary = None
    @classmethod
    def specify_native_OS(cls, workspace, mobile_os="ios"):
        if cls._unity_binary == None:
            cls._unity_binary = UnityUtil.get_unity_path("name", "version")
        specify_os_command = f"{cls._unity_binary} -quit -batchmode -logFile tempLog1.txt -projectPath {workspace} -buildTarget ios"
        
    @classmethod
    def modify_unity_config_param(cls):
        print("bye")    
    
    @classmethod
    def export_xcode_project(cls):
        print("xxx")
    

if __name__ == '__main__':
    print("main func")