import sys
import os 
import shutil
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Base.CGBase import CGErrorCode
from Utils.JSONParser import JSONUtil

class CGFileUtil:
    @classmethod
    def remove_firebase_folder(cls, workspace):
        firebase_path = f"{workspace}/Assets/CGUnityPlugins/Firebase/Firebase"
        shutil.rmtree(firebase_path)
        
    @classmethod
    def reset_firebase_folder(cls, workspace):
        firebase_module_path = f"{workspace}/Assets/CGUnityPlugins/Firebase"
        previous_dir = os.getcwd()
        os.chdir(firebase_module_path)
        os.system("git clean -df")
        os.system("git reset --hard")
        os.chdir(previous_dir)
        
        
    @classmethod
    def copy_ddcommon(cls, workspace):
        # 读取 AppleCert.json 读取 bundle_id 
        apple_cert_json = "Jenkins_Pipeline/iOS/Temp/AppleCert.json"
        bundle_id_key = "bundle_id"
        bundle_id = JSONUtil.get_value_from_json_path(apple_cert_json, bundle_id_key)
        command = f"cp -f {workspace}/ddCommon.json {workspace}/Assets/WebPlayerTemplates/dd-sdk-config/{bundle_id}/"
        os.system(command)
        
    @classmethod
    def copy_ddcommon_2(cls):
        apple_cert_json = "Jenkins_Pipeline/iOS/Temp/AppleCert.json"
        bundle_id_key = "bundle_id"
        bundle_id = JSONUtil.get_value_from_json_path(apple_cert_json, bundle_id_key)
        workspace = os.environ.get('WORKSPACE')
        command = f"cp -f {workspace}/ddCommon.json {workspace}/Assets/WebPlayerTemplates/dd-sdk-config/{bundle_id}/"
        print(command)
        os.system(command)
        

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("CGError : Param Missing")
        sys.exit(CGErrorCode.CG_Missing_Params)
    
    method_name = sys.argv[1]
    workspace = sys.argv[2]
    if not method_name.__contains__('-'):
        sys.exit('CGError : method name not specified !')
    
    if method_name.__eq__("-removefirebase"):
        CGFileUtil.remove_firebase_folder(workspace)
        
    if method_name.__eq__("-resetfirebase"):
        CGFileUtil.reset_firebase_folder(workspace)
    
    if method_name.__eq__("-ddcommon"):
        CGFileUtil.copy_ddcommon(workspace)
    