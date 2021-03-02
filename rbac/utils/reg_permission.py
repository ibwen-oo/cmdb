from django.conf import settings


def register_permission(current_user, request):
    """
    用户权限的初始化
    :param current_user: 当前用户对象
    :param request: 请求相关所有数据
    :return:
    """
    # 2. 权限信息初始化
    # 根据当前用户信息获取此用户所拥有的所有权限,并放入session.

    # 当前用户所有权限
    permission_queryset = current_user.roles.filter(permissions__isnull=False).values("permissions__id",
                                                                                      "permissions__title",
                                                                                      "permissions__url",
                                                                                      "permissions__name",
                                                                                      "permissions__action",
                                                                                      "permissions__pid_id",
                                                                                      "permissions__pid__title",
                                                                                      "permissions__pid__url",
                                                                                      "permissions__menu_id",
                                                                                      "permissions__menu__title",
                                                                                      "permissions__menu__icon"
                                                                                      ).distinct()

    # 3. 获取权限+菜单信息
    permission_dict = {}

    menu_dict = {}

    for item in permission_queryset:
        # 以url别名和请求方法为每个权限的key
        key = "{}-{}".format(item['permissions__name'], item['permissions__action'])
        permission_dict[key] = {
            'id': item['permissions__id'],
            'title': item['permissions__title'],
            'url': item['permissions__url'],
            'action': item['permissions__action'],
            'pid': item['permissions__pid_id'],
            'p_title': item['permissions__pid__title'],
            'p_url': item['permissions__pid__url'],
        }

        menu_id = item['permissions__menu_id']
        if not menu_id:
            continue
        node = {'id': item['permissions__id'], 'title': item['permissions__title'], 'url': item['permissions__url']}

        if menu_id in menu_dict:
            menu_dict[menu_id]['children'].append(node)
        else:
            menu_dict[menu_id] = {
                'title': item['permissions__menu__title'],
                'icon': item['permissions__menu__icon'],
                'children': [node, ]
            }
    request.session[settings.PERMISSION_SESSION_KEY] = permission_dict
    request.session[settings.MENU_SESSION_KEY] = menu_dict
