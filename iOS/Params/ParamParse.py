import sys
import os 
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from Base.CGBase import CGErrorCode

class JenkinsParamParser:
    @classmethod
    def parse_adOption(cls, ad_option):
        _ad_type = None
        if ad_option == "无":
            _ad_type = 0
        elif ad_option == "admob":
            _ad_type = 1
        elif ad_option == "max":
            _ad_type = 2
        elif ad_option == "topon":
            _ad_type = 4
        return _ad_type

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("CGError : 参数转换时缺少参数")
        sys.exit(CGErrorCode.CG_Missing_Params)
    
    method_name = sys.argv[1]
    if not method_name.__contains__('-'):
        sys.exit('CGError : method name not specified !')
    
    
    if method_name.__eq__("-adoption"):
        ad_option = sys.argv[2]
        # 解析 ad_option
        ad_type = JenkinsParamParser.parse_adOption(ad_option)
        if ad_type is None:
            print("CGError : ad_option 参数类型转换出错 !")
            sys.exit(1)
        else:
            print(ad_type)