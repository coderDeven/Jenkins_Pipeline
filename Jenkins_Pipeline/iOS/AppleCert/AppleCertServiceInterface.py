import os 
import sys 
import json
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil
from Base.CGBase import CGErrorCode

# 用于读取证书管理服务中证书信息. 
class AppleCertServiceInterface:
    
    @classmethod
    def _load_proj_data(self, file_path, game_id):
        project_dict = JSONUtil.json_from_json_path(file_path)
        for dic in project_dict:
            if int(game_id) == dic['game_id']:
                return dic

        print ("没有找到game id :"+game_id)
        return {}
    
    @classmethod
    def _load_cert(self, file_path, build_id):
        cer_list = JSONUtil.json_from_json_path(file_path)
        for dic in cer_list:
            if build_id == dic['bundle_id'] and 'DEV' in dic['cer_name'].upper() and dic['cer_type'] == 'mobileprovision':
                return dic

        print ("没有找到build id :" + build_id) 
        return {}  

    @classmethod
    def get_cer_info_with_key(self, file_path, game_id, key):
        cer_file_path = file_path+'/check/cer.json'
        proj_data_file_path = file_path + '/check/proj.json'
        project_json = self._load_proj_data(proj_data_file_path, game_id)
        build_id = project_json['bundle_id']
        cer_dic = self._load_cert(cer_file_path, build_id)
        
        value = None
        if key == 'game_key':
            return project_json[key]
        else:
            return cer_dic[key]
    
    @classmethod
    def get_push_uuid(self, file_path, game_id):
        cer_file_path = file_path+'/check/cer.json'
        project_json_path = file_path + '/check/proj.json'
        project_json = self._load_proj_data(project_json_path, game_id)
        build_id = project_json['bundle_id']
        push_cert_json = self._get_push_cert_dict(cer_file_path, build_id)
        push_uuid = push_cert_json['uuid']
        return push_uuid
    
    @classmethod
    def _get_push_cert_dict(self, file_path, build_id):
        cer_list = JSONUtil.json_from_json_path(file_path)
        for dic in cer_list:
            is_push = 'PUSH' in dic['cer_name'].upper()
            if build_id in dic['bundle_id'] and 'DEV' in dic['cer_name'].upper() and is_push and dic['cer_type'] == 'mobileprovision':
                return dic
        return {}
    

if __name__ == '__main__':
    
    if len(sys.argv) < 4:
        print("CGError : 读取 Apple 证书信息时, 缺少参数")
        sys.exit(1)
    
    # 示例 :
    # python3 Jenkins_Pipeline/iOS/AppleCert/AppleCertServiceInterface.py -pushuuid /Users/centurygame/.jenkins/workspace/Apple_Cert_Notice 20075
    
    method_name = sys.argv[1]
    path = sys.argv[2]
    game_id = sys.argv[3]
    
    if not method_name.__contains__('-'):
        sys.exit('CGError : method name not specified !')
    
    if method_name.__eq__("-bundleid"):
        bundle_id = AppleCertServiceInterface.get_cer_info_with_key(path, game_id, "bundle_id")
        print(bundle_id)
        
    if method_name.__eq__("-gamekey"):
        game_key = AppleCertServiceInterface.get_cer_info_with_key(path, game_id, "game_key")
        print(game_key)
        
    if method_name.__eq__("-teamid"):
        team_id = AppleCertServiceInterface.get_cer_info_with_key(path, game_id, "team_id")
        print(team_id)
        
    if method_name.__eq__("-cername"):
        cer_name = AppleCertServiceInterface.get_cer_info_with_key(path, game_id, "cer_name")
        print(cer_name)
        
    if method_name.__eq__("-mainuuid"):
        uuid = AppleCertServiceInterface.get_cer_info_with_key(path, game_id, "uuid")
        print(uuid)
        
    if method_name.__eq__("-pushuuid"):
        push_uuid = AppleCertServiceInterface.get_push_uuid(path, game_id)
        print(push_uuid)
