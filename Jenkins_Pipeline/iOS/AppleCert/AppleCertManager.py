import os 
import sys 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil
from Base.CGBase import CGErrorCode
from AppleCertServiceInterface import AppleCertServiceInterface


class AppleCertManager:
    _game_id = None
    _cert_manage_service_path = None
    
    @classmethod
    def retrive_save_cert_info(cls, agent_name, game_id, push_enable):
        cls.setup(agent_name, game_id)
        game_key = cls.get_game_key()
        bundle_id = cls.get_bundle_id()
        team_id = cls.get_team_id()
        cert_name = cls.get_cert_name()
        main_uuid = cls.get_provision_uuid()
        push_uuid = "~"
        if type(push_enable) is str and push_enable == 'true':
            # 兼容 Shell 调用 python
            push_uuid = cls.get_push_provision_uuid()
        if push_enable == True:
            push_uuid = cls.get_push_provision_uuid()
            
        # 保存到临时文件. 
        cert_info_json = {
            "game_id" : game_id,
            "game_key" : game_key,
            "bundle_id" : bundle_id,
            "team_id" : team_id,
            "cert_name" : cert_name,
            "main_uuid" : main_uuid,
            "push_uuid" : push_uuid   
        }
        
        temp_json_path = "Jenkins_Pipeline/iOS/Temp/AppleCert.json"
        
        JSONUtil.write_json_to_file(cert_info_json, temp_json_path)
        
    
    @classmethod
    def setup(cls, agent_name, game_id):
        cls._game_id = game_id
        agent_config_path = "Jenkins_Pipeline/iOS/Config/Agent/AgentConfig.json"
        key_path = f"{agent_name}.apple_cert_path"
        cls._cert_manage_service_path = JSONUtil.get_value_from_json_path(agent_config_path, key_path)
        
        
    @classmethod
    def get_game_key(cls):
        game_key = AppleCertServiceInterface.get_cer_info_with_key(cls._cert_manage_service_path, cls._game_id, "game_key")
        return game_key
    
    @classmethod
    def get_bundle_id(cls):
        bundle_id = AppleCertServiceInterface.get_cer_info_with_key(cls._cert_manage_service_path, cls._game_id, "bundle_id")
        return bundle_id
    
    @classmethod
    def get_team_id(cls):
        team_id = AppleCertServiceInterface.get_cer_info_with_key(cls._cert_manage_service_path, cls._game_id, "team_id")
        return team_id

    @classmethod
    def get_cert_name(cls):
        cer_name = AppleCertServiceInterface.get_cer_info_with_key(cls._cert_manage_service_path, cls._game_id, "cer_name")
        return cer_name
        
    @classmethod
    def get_provision_uuid(cls):
        main_uuid = AppleCertServiceInterface.get_cer_info_with_key(cls._cert_manage_service_path, cls._game_id, "uuid")
        return main_uuid
        
    @classmethod
    def get_push_provision_uuid(cls):
        push_uuid = AppleCertServiceInterface.get_push_uuid(cls._cert_manage_service_path, cls._game_id)
        return push_uuid


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("CGError : 获取 Apple 证书时, 缺少参数")
        sys.exit(CGErrorCode.CG_Missing_Params)
    
    agent_name = sys.argv[1]
    game_id = sys.argv[2]
    push_enable = sys.argv[3]
    
    AppleCertManager.retrive_save_cert_info(agent_name, game_id, push_enable)
    
    