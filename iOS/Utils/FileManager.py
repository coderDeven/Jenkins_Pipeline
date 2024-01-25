import os

class FileManager:
    @classmethod
    def create_file(cls, file_path):
        cls.remove_file(file_path)
        try:
            with open(file_path, 'w') as file:
                pass  # 可以在此处写入初始内容
            print(f"File created: {file_path}")
        except Exception as e:
            print(f"Failed to create file: {file_path} - {e}")
        
    @classmethod
    def remove_file(cls, file_path):
        if os.path.exists(file_path):
            try:
                os.remove(file_path)
                print(f"删除文件成功: {file_path}")
                return True
            except Exception as e:
                print(f"删除文件失败: {file_path} , exception: {e}")
                return False
        else :
            print(f"目标删除文件不存在 : {file_path}")
