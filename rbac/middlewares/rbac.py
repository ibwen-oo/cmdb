import re
from django.conf import settings
from django.shortcuts import HttpResponse, redirect
from django.utils.deprecation import MiddlewareMixin

class RbacMiddleware(MiddlewareMixin):
    """用户权限校验"""

    def process_request(self, request):
        """
        当用户请求刚进入时候触发执行.
        流程如下:
        1.获取当前用户请求的url,
        2.获取当前用户在session中注册的权限信息
        3.权限信息匹配
        :param request:
        :return:
        """
        # 当前请求的url
        current_url = request.path_info

        # 判断是否在白名单中
        for valid_url in settings.VALID_URL_LIST:
            if re.match(valid_url, current_url):
                # 白名单中的URL无需权限验证即可访问
                return None

        # 获取当前用户的所有权限
        permission_dict = request.session.get(settings.PERMISSION_SESSION_KEY)
        # 如果session中没有权限信息,认为用户未登录
        if not permission_dict:
            return HttpResponse('未获取到用户权限信息, 请登录!')

        # 面包屑title和对应url
        url_record = [
            {'title': '首页', 'url': '/index/'}
        ]

        # 处理需要登录,但无需权限校验的url
        for url in settings.NO_PERMISSION_LIST:
            if re.match(url, current_url):
                # 需要登录,但无需权限校验
                request.current_selected_permission = 0
                request.breadcrumb = url_record
                return None

        flag = False
        for item in permission_dict.values():
            reg = "^%s$" % item['url']
            action = item["action"]
            if re.match(reg, current_url) and request.method == action:
                flag = True

                request.current_selected_permission = item['pid'] or item['id']
                if not item['pid']:
                    url_record.extend([{'title': item['title'], 'url': item['url'], 'class': 'active'}])
                else:
                    url_record.extend([
                        {'title': item['p_title'], 'url': item['p_url']},
                        {'title': item['title'], 'url': item['url'], 'class': 'active'},
                    ])
                request.breadcrumb = url_record
                break

        if not flag:
            return HttpResponse('您无权访问')