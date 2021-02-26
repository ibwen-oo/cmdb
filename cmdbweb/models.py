from django.db import models
from rbac.models import UserInfo

class Group(models.Model):
    """
    用户部门表,用于控制用户能看到的服务器列表.
    只能看到自己部门的服务器.
    id的值和cmdbapi中的Department表中的id相对应.
    title和cmdbapi中的Department表中的name相对应
    """
    title = models.CharField(verbose_name="组名称", max_length=32, null=True)

    def __str__(self):
        return self.title

class User(UserInfo):
    avatar = models.FileField(upload_to="avatars/%Y%m%d/", default="avatars/default.jpg", verbose_name="头像")
    group = models.ForeignKey(to=Group, on_delete=models.CASCADE, null=True)


