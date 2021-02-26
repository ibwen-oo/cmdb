from .. import models


def reg_group(user_obj, request):
    """
    用户组信息注册到request
    暂定一个用户只能属于一个组
    """
    group_obj = models.Group.objects.filter(user=user_obj).first()
    try:
        request.session["group_id"] = group_obj.id
        request.session["group_title"] = group_obj.title
    except Exception as e:
        raise Exception("未获取到用户组...")

