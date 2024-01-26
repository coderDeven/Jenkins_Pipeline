import sys
import os 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Base.CGBase import CGErrorCode
from Utils.JSONParser import JSONUtil

class CGFileUtil:
    @classmethod
    def remove_firebase_folder(cls):
        print("remove firebase")
        
    @classmethod
    def reset_firebase_folder(cls):
        print("")
    
    @classmethod
    def copy_ddcommon(cls):
        command = "cp -f ${WORKSPACE}/ddCommon.json ${WORKSPACE}/Assets/WebPlayerTemplates/dd-sdk-config/${bundle_id}/"
        

if __name__ == '__main':
    if len(sys.argv) < 2:
        print("CGError : 重置环境, 缺少参数")
        sys.exit(CGErrorCode.CG_Missing_Params)
    
    method_name = sys.argv[1]
    if not method_name.__contains__('-'):
        sys.exit('CGError : method name not specified !')
    
    if method_name.__eq__("-setupfirebase"):
        CGFileUtil.remove_firebase_folder()
        
    if method_name.__eq__("-resetfirebase"):
        CGFileUtil.reset_firebase_folder()
    
    if method_name.__eq__("-ddcommon"):
        CGFileUtil.copy_ddcommon()