from django import template
from django.conf import settings
from collections import OrderedDict
from cmdbapi import models as api_models
from ..forms.server_form import ServerForm

from cmdbweb.utils.pagination import Pagination

register = template.Library()

@register.inclusion_tag('bak/l1_menu.html')
def static_menu(request):
    """创建一级菜单"""

    menu_list = request.session[settings.MENU_SESSION_KEY]
    return {'menu_list': menu_list}

@register.inclusion_tag("bak/l2_menu.html")
def multi_menu(request):
    """创建二级菜单"""
    menu_dict = request.session[settings.MENU_SESSION_KEY]

    # 对字典的key进行排序
    key_list = sorted(menu_dict)

    # 空的有序字典
    ordered_dict = OrderedDict()

    # 构造有序字典, 保证菜单在页面上总是按顺序显示.
    for key in key_list:
        val = menu_dict[key]
        val['class'] = 'hide'

        for per in val['children']:
            # 给默认选中的二级菜单加class, 并展开一级菜单.
            if per['id'] == request.current_selected_permission:
                per['class'] = 'active'
                val['class'] = ''
        ordered_dict[key] = val

    return {'menu_dict': ordered_dict}

@register.inclusion_tag('rbac/breadcrumb.html')
def breadcrumb(request):
    """实现路径导航功能"""
    # print(request.breadcrumb)
    record_list = request.breadcrumb
    print("====>", record_list)
    return {'record_list': request.breadcrumb}