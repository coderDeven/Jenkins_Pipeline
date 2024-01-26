import os
import sys
import json
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.AESParser import AESUtil
from Utils.JSONParser import JSONUtil

class CGParamLoader :
    _ddCommon = None
    _unityConfig = None
    
    @classmethod
    def load_ddcommon(cls, ddcommon_path):
        if cls._ddCommon is None:
            with open(ddcommon_path) as file:
                cls._ddCommon = json.load(file)
        return cls._ddCommon
    
    @classmethod
    def load_unity_config(cls, encrypt_key, unity_config_encrypt_string):
        if cls._unityConfig is None:
            cls._unityConfig = AESUtil().json_from_decrypt_content(encrypt_key, unity_config_encrypt_string)
        return cls._unityConfig