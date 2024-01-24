import sys
import json

class JSONUtil:

    @classmethod
    def get_value_from_json(cls, json_dict, key_path):
        data = json_dict
        keys = key_path.split('.')  # 将嵌套路径拆分为列表
        
        value = data
        for key in keys:
            if key in value:
                if type(value) is str:
                    sub_json_object = json.loads(value)
                    if type(sub_json_object) is dict:
                        value = sub_json_object[key]
                elif type(value) is dict:
                    value = value[key]
                   
            else:
                return None  # 如果找不到指定的 key，返回 None
        return value
    
    @classmethod
    def get_value_from_json_path(cls, json_path, key_path):
        with open(json_path) as file:
            data = json.load(file)

        res = cls.get_value_from_json(data,key_path)
        return res
    
    @classmethod
    def modify_json(cls, json_path, key_path, value):
        with open(json_path, 'r') as file:
            data = json.load(file)

        keys = key_path.split('.')
        current = data

        for key in keys[:-1]:
            if key in current:
                current = current[key]
            else:
                current[key] = {}
                current = current[key]

        current[keys[-1]] = value

        with open(json_path, 'w') as file:
            json.dump(data, file, indent=4)

    @classmethod
    def write_json_to_file(cls, json_dict, file_path):
        try:
            with open(file_path, 'w') as file:
                json.dump(json_dict, file, indent=4)
            print(f"JSON written to file: {file_path}")
        except Exception as e:
            print(f"CGError : Failed to write JSON to file: {file_path} - {e}")
            
    @classmethod
    def pretty(cls, d):
        return json.dumps(d, indent=4, ensure_ascii=True)
    
    @classmethod
    def is_jsonString(cls, string):
        try:
            json_object = json.loads(string)
        except ValueError:
            return False
        return True


if __name__ == '__main__':

    if len(sys.argv) < 3:
        print('CGError : param missing', flush=True)
        sys.exit(1)
    
    method_name = sys.argv[1]
    if not method_name.__contains__('-'):
        sys.exit(arg='CGError : method name not specified !')
    
    if method_name.__eq__("-get"):
        # path :
        json_path = sys.argv[2]
        # key :
        key_path = sys.argv[3]
        result = JSONUtil.get_value_from_json_path(json_path, key_path)
        print(result)
    
    if method_name.__eq__("-set"):
        # path :
        json_path = sys.argv[2]
        # key :
        key_path = sys.argv[3]
        # new_value :
        new_value = sys.argv[4]
        JSONUtil.modify_json(json_path, key_path, new_value)

    
    

