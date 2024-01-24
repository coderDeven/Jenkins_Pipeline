import os 
import sys 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Utils.JSONParser import JSONUtil

class AppleCertificateManager:
    _apple_cert_manage_service_path = None
    _apple_cert_manage_service_cert_path = None
    _apple_cert_manage_service_script_path = None
    
    @classmethod
    def get_game_key(cls, game_id):
        command = f"python3 {cls._apple_cert_manage_service_script_path} {cls._apple_cert_manage_service_cert_path} {game_id} 'game_key'"
        game_key = os.system(command)
        return game_key
    @classmethod
    def get_bundle_id(cls, game_id):
        command = f"python3 {cls._apple_cert_manage_service_script_path} {cls._apple_cert_manage_service_cert_path} {game_id} 'bundle_id'"
        
    @classmethod
    def get_team_id(cls):
        print("")

    @classmethod
    def get_cert_name(cls):
        print("")
        

if __name__ == "__main__":
    print("");
    