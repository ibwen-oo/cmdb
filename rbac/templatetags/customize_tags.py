import logging

from django import template
from django.conf import settings
from collections import OrderedDict

from rbac.utils import urls

register = template.Library()


@register.inclusion_tag('rbac/l1_menu.html')
def static_menu(request):
    """创建一级菜单"""

    menu_list = request.session[settings.MENU_SESSION_KEY]
    return {'menu_list': menu_list}


@register.inclusion_tag("rbac/l2_menu.html")
def multi_menu(request):
    """创建二级菜单"""
    menu_dict = request.session[settings.MENU_SESSION_KEY]

    # 对字典的key进行排序
    key_list = sorted(menu_dict)

    # 空的有序字典
    ordered_dict = OrderedDict()

    # 构造有序字典,保证菜单在页面上总是按顺序显示.
    # 构造时展开选择的菜单,隐藏未选中的菜单.
    # 提示选择中的二级菜单.
    for key in key_list:
        val = menu_dict[key]
        val['class'] = 'hide'

        for per in val['children']:
            # 给默认选中的二级菜单加class, 并展开一级菜单.
            if per['id'] == request.current_selected_permission:
                per['class'] = 'active'
                val['class'] = ''
        ordered_dict[key] = val
    # print("ordered_dict: ", ordered_dict)

    return {'menu_dict': ordered_dict}


@register.inclusion_tag('rbac/breadcrumb.html')
def breadcrumb(request):
    """实现路径导航功能"""
    if hasattr(request, "breadcrumb"):
        return {'record_list': request.breadcrumb}
    return {}


@register.filter
def has_permission(request, name):
    """
    自定义filter, 判断是否有权限.
    用于粒度到按钮级别的权限控制.
    :param request: request
    :param name: 配置url中的 name+请求方法(比如:cmdbweb:detail-GET),用来代表对应的权限和反向解析url.
    :return:

    示例：
        urls.py:
            app_name = "cmdbweb"

            urlpatterns = [
                ......
                path('index/', views.IndexView.as_view(), name="index"),
                path('server/', views.ServerView.as_view(), name="server"),
                re_path(r'detail/(?P<server_id>\d+)/$', views.ServerDetails.as_view(), name="detail"),
            ]
        server.html:
            {# 使用自定义过滤器验证是否有操作服务器信息的权限 #}
            {% if request|has_permission:"cmdbweb:detail-GET" or request|has_permission:"cmdbweb:server-PUT" %}
                <th>选项</th>
            {% endif %}
            ......
            {% if request|has_permission:"cmdbweb:server-PUT" %}
                <button class="btn-info edit-button">编辑</button>
            {% endif %}
    """
    if name in request.session[settings.PERMISSION_SESSION_KEY]:
        return True


@register.simple_tag
def memory_url(request, name, *args, **kwargs):
    """
    生成带有原搜索条件的URL（替代了模板中的url）
    :param request:
    :param name: url 别名
    :return:
    """
    return urls.memory_url(request, name, *args, **kwargs)
