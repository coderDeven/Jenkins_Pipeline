import os
import sys
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from DDCommonParam import DDCommonParam
from Base.CGBase import CGErrorCode

class JenkinsJobParam:
    _game_id = None
    _pod_source = None
    _pod_env = None
    _sdk_environment = None
    _push_enable = None
    _firebase_enable = None
    _universal_link = None
    _adjust_universal_link = None
    _ad_option = None
    _ddCommon = DDCommonParam
    

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print('CGError : param missing', flush=True)
        sys.exit(CGErrorCode.CG_Missing_Params)
        
    game_id = sys.argv[1]
    push_enable = sys.argv[2]
    firebase_enable = sys.argv[3]
    job_params = sys.argv[4]
    
    JenkinsJobParam._game_id = game_id
    JenkinsJobParam._push_enable = push_enable
    JenkinsJobParam._firebase_enable = firebase_enable
    print("job_params : ")
    print(job_params)
    
    print("after set:")
    print(JenkinsJobParam._firebase_enable)
    