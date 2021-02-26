from django import forms
from cmdbapi import models

class ServerForm(forms.ModelForm):
    class Meta:
        model = models.Server
        fields = ["hostname", "system", "cpu", "memory", "status", "department", "idc", "desc"]

        labels = {
            "hostname": "主机名",
            "system": "操作系统",
            "cpu": "CPU",
            "memory": "内存",
            "status": "状态",
            "department": "部门",
            "idc": "机房",
            "desc": "描述"
        }

    def __init__(self, *args, **kwargs):
        super(ServerForm, self).__init__(*args, **kwargs)
        # 统一给ModelForm生成字段添加样式
        for name, field in self.fields.items():
            # print("name: ", name)
            # print("field: ", field)
            # print("field_dir: ", dir(field))
            # field.initial = "112211"
            field.widget.attrs['class'] = 'form-control'