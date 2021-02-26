#!/bin/env python3

import copy
import requests
from requests.packages import urllib3

# salt api 配置
SALTURL = "http://10.0.6.110:8000"
SALTUSERNAME = "saltapi"
SALTPASSWORD = "123456"

# 关闭ssl报警信息
urllib3.disable_warnings()


class SaltAPI():

    def __init__(self, url, username, password, eauth):
        self.__url = url
        self.__username = username
        self.__password = password
        self.__eauth = eauth
        self.__base_headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
        self.__base_data = dict(
            username=self.__username,
            password=self.__password,
            eauth=self.__eauth
        )
        self.__token = self._get_token()
        self.__headers_token = {'X-Auth-Token': self.__token}
        self.__headers_token.update(self.__base_headers)

    # 获取token
    def _get_token(self):
        params = copy.deepcopy(self.__base_data)
        try:
            response = requests.post(url=self.__url + '/login', verify=False, headers=self.__base_headers, json=params)
            ret_json = response.json()
            token = ret_json["return"][0]["token"]
            return token
        except Exception as ErrorMsg:
            print(ErrorMsg)

    # 发送 post 请求
    def __post(self, **kwargs):
        try:
            response = requests.post(url=self.__url, verify=False, headers=self.__headers_token, **kwargs)
            ret_code, ret_data = response.status_code, response.json()
            return (ret_code, ret_data)
        except Exception as ErrorMsg:
            print(ErrorMsg)
            exit()

    def list_all_key(self):
        """
        获取所有认证和未认证的salt主机
        :return:
        """
        params = {'client': 'wheel', 'fun': 'key.list_all'}
        response = self.__post(json=params)
        accepted_minions = response[1]['return'][0]['data']['return']['minions']
        unaccepted_minions = response[1]['return'][0]['data']['return']['minions_pre']
        return accepted_minions, unaccepted_minions

    def run(self, params):
        """
        远程执行salt通用接口,需要自定义参数字典.
        格式如下:
            params = {
                'client': 'local',
                'fun': 'grains.item',
                'tgt': '*',
                'arg': ('os', 'id', 'host' ),
                'kwargs': {},
                'expr_form': 'glob',
                'timeout': 60
            }
         """
        response = self.__post(json=params)
        return response[1]['return'][0]

    def salt_state(self, tgt, arg, tgt_type='list'):
        """salt state.sls"""
        params = {'client': 'local', 'tgt': tgt, 'fun': 'state.sls', 'arg': arg, 'tgt_type': tgt_type}
        response = self.__post(json=params)
        return response[1]['return'][0]



sapi = SaltAPI(url=SALTURL, username=SALTUSERNAME, password=SALTPASSWORD, eauth="pam")
