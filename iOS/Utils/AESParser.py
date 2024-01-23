# pip install pycrypto
from Crypto.Cipher import AES
# pip install pycryptodome
from Crypto.Util.Padding import unpad
import base64
import json
import sys
import os
import shutil

class AESUtil:
    def decrypt_ecb_pkcs7_256(self, decrypt_key, cipher_text):        
        cipher = AES.new(decrypt_key.encode(), AES.MODE_ECB)
        encrypted_bytes = base64.b64decode(cipher_text)
        decrypted_bytes = cipher.decrypt(encrypted_bytes)
        plain_text = unpad(decrypted_bytes, AES.block_size).decode()
        return plain_text
    
    def json_from_decrypt_content(self, decrypt_key, cipher_text):
        plain_text = self.decrypt_ecb_pkcs7_256(decrypt_key,cipher_text)
        plain_dict = json.loads(plain_text)
        return plain_dict
    
    def get_value_for_key_in_encrypted_content(self, decrypt_key, cipher_text, json_key):
        plain_dict = self.json_from_decrypt_content(decrypt_key, cipher_text)
        value = plain_dict[json_key]
        return value

if __name__ == '__main__':
    decrypt_key = sys.argv[1]
    cipher_text = sys.argv[2]
    json_key = sys.argv[3]
    
    value = AESUtil().get_value_for_key_in_encrypted_content(decrypt_key, cipher_text, json_key)
    print(value)