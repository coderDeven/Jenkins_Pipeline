import os
import sys
import json

sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil
from ParamLoader import CGParamLoader
from DDCommonParam import DDCommonParam
from JenkinsJobParam import JenkinsJobParam

CG_Invalid_DDCommon = 11
CG_DDcommon_Jenkins_Param_Not_Match = 12

class CGParamValidator:
    
    @classmethod
    def validate_parse_ddcommon(cls, ddcommon_path):
        ddcommon_dict = CGParamLoader.load_ddcommon(ddcommon_path)
        if ddcommon_dict is None:
            print("❎ CGError : DDCommon 格式错误 - 不是 Json 格式")
            return False
        else:
            return cls.validate_ddcommon(ddcommon_dict)
    
    # 判断 ddcommon 有效
    @classmethod
    def validate_ddcommon(cls, ddcommon_dict):
        # 1. platform.ios 不为空
        iOS_key_exist = cls.check_iOS_exist(ddcommon_dict)
        if iOS_key_exist is False:
            print("❎ CGError : DDCommon 中 platform->ios 不存在 !")
            return False
    
        # 2. unityConfig 可以解析成功
        unity_config_key = "unity_config"
        project_config_iOS_path = "iOS/Config/Project/projectConfig_iOS.json"
        encrypt_unity_config_key = JSONUtil.get_value_from_json_path(project_config_iOS_path,"unity_config_decrypt_key")
        encrypted_unity_config = JSONUtil().get_value_from_json(ddcommon_dict, unity_config_key)
        plain_unity_config = CGParamLoader.load_unity_config(encrypt_unity_config_key, encrypted_unity_config)
        
        print("unity config dict : ")
        print(plain_unity_config)
        print(type(plain_unity_config))
        # if plain_unity_config is not dict:
        if not isinstance(plain_unity_config, dict):
            print("❎ CGError : DDCommon 中 unityConfig 解析失败 !")
            return False
        else:
            # 3. 解析 DDCommon, 获取部分key
            ddcommon_game_id = plain_unity_config["game_id"]
            ddcommon_game_key = plain_unity_config["game_key"]
            ddcommon_push = plain_unity_config["ios_push"]
            ddcommon_firebase = plain_unity_config["firebase_module"]
            ddcommon_pod_token = plain_unity_config["pod_group_token"]
            
            DDCommonParam._game_id = ddcommon_game_id
            DDCommonParam._game_key = ddcommon_game_key
            DDCommonParam._push_enable = ddcommon_push
            DDCommonParam._firebase_enable = ddcommon_firebase
            DDCommonParam._pod_token = ddcommon_pod_token
            
            DDCommonParam._complete_json = ddcommon_dict
            DDCommonParam._unity_config_encrypt_string = encrypted_unity_config
            DDCommonParam._unity_config_decrypt_json = plain_unity_config
            return True
        
    
    @classmethod
    def check_jenkins_match_ddcommon(cls):
        game_id_match = cls.check_game_id()
        push_tag_match = cls.check_push_tag()
        firebase_tag_match = cls.check_firebase_tag()
        if game_id_match == False or push_tag_match == False or firebase_tag_match == False :
            return False
        return True
        
    @classmethod
    def check_push_tag(cls):
        if JenkinsJobParam._push_enable != DDCommonParam._push_enable:
            print("❎ CGerror : DDcommon 中的 push tag 与 Jenkins 设置的 push tag 不一致 !")
            return False
        return True
    
    @classmethod
    def check_firebase_tag(cls):
        if JenkinsJobParam._firebase_enable != DDCommonParam._firebase_enable:
            print("❎ CGerror : DDcommon 中的 firebase tag 与 Jenkins 设置的 firebase tag 不一致 !")
            return False
        return True
    
    @classmethod
    def check_game_id(cls):
        if JenkinsJobParam._game_id != DDCommonParam._game_id:
            print("❎ CGerror : DDcommon 中的 game_id 与 Jenkins 设置的 game_id 不一致 !")
            return False
        return True
    
    @classmethod
    def check_iOS_exist(cls, ddcommon_dict):
        # platform.ios 不为空
        iOS_key = "platform.ios"
        iOS_config = JSONUtil().get_value_from_json(ddcommon_dict, iOS_key)
        if iOS_config is None:
            return False
        return True
      

if __name__ == '__main__':
    if len(sys.argv) < 1:
        print('CGError : param missing', flush=True)
        sys.exit(1)
    
    # 1. ddcommon path
    ddcommon_path = sys.argv[1]
    
    # 2. 校验 DDCommon
    ddcommon_valid = CGParamValidator.validate_parse_ddcommon(ddcommon_path)
    if ddcommon_valid == False:
        print("❎ CGError : ddCommon 校验失败 ❎")
        sys.exit(CG_Invalid_DDCommon)
    else :
        print("CGPass : ddCommon 校验通过 ✅")
    
    # 3. ddCommon 与 Jenkins 参数比对是否匹配
    param_match = CGParamValidator.check_jenkins_match_ddcommon()
    if param_match == False:
        print("❎ CGError : ddCommon 与 Jenkins 参数不匹配 ❎")
        sys.exit(CG_DDcommon_Jenkins_Param_Not_Match)
    else :
        print("CGPass : ddCommon 与 Jenkins 参数匹配 ✅")