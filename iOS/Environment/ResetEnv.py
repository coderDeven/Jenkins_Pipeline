import sys 
import os 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Base.CGBase import CGErrorCode

class BuildEnv:
    _workspace_path = None 
    @classmethod
    def reset_firebase_folder(cls):
        print("")

    # def remove_firebase_folder(cls):
        

if __name__ == '__main':
    if len(sys.argv) < 2:
        print("CGError : 重置环境, 缺少参数")
        sys.exit(CGErrorCode.CG_Missing_Params)
    
    method_name = sys.argv[1]
    if not method_name.__contains__('-'):
        sys.exit('CGError : method name not specified !')
    
    if method_name.__eq__("-firebase"):
        print("")