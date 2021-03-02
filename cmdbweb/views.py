import json
from django.views import View
from django.http.response import JsonResponse
from django.db.models import Q
from django.shortcuts import render, HttpResponse, redirect

from .utils.reg_group import reg_group
from rbac.utils.reg_permission import register_permission

from cmdbapi import models as api_models
from . import models
from .forms.server_form import ServerForm

from cmdbweb.utils.pagination import Pagination
from cmdbweb.utils.saltapi import sapi


class Login(View):
    def get(self, request, *args, **kwargs):
        return render(request, "login.html")

    def post(self, request, *args, **kwargs):
        data = {"status": 0, "msg": ""}
        post_data = request.body.decode("utf-8")
        name, pwd = post_data.split("&")

        username = name.split("=")[-1]
        password = pwd.split("=")[-1]

        user_obj = models.User.objects.filter(username=username, password=password).first()
        if user_obj:
            # session 中注册用户信息
            request.session["user_info"] = {"id": user_obj.id, "username": user_obj.username, "email": user_obj.email}
            # session中注册权限信息
            register_permission(user_obj, request)
            reg_group(user_obj, request)
            data["msg"] = "/index/"
        else:
            data["status"] = 1
            data["msg"] = "用户名或密码错误"

        return JsonResponse(data)


def logout(request):
    if request.method == "GET":
        request.session = ""
        return redirect("/login/")


class IndexView(View):
    def get(self, request, *args, **kwargs):
        return render(request, "index.html")


class ServerView(View):
    """管理服务器视图"""
    def get(self, request, *args, **kwargs):
        # 过滤出用户所在组服务器
        group_id = request.session.get("group_id")
        # print(request.session.get("group_title"))
        if group_id != 1:  # 非运维部用户只能查看本部门服务器(运维部id为1)
            group_server_queryset = api_models.Server.objects.filter(department_id=group_id)
        else:  # 运维部可以查看所有服务器
            group_server_queryset = api_models.Server.objects.all()

        # 处理搜索
        search_field = request.GET.get("search_field")
        search_content = request.GET.get("search_content")
        if search_content:
            # 使用Q构建搜索条件
            q = Q()
            search_content = search_content.strip()
            if search_field == "ipaddress":
                ip = api_models.ServerNetwork.objects.filter(ipaddress__icontains=search_content).first()
                search_field = "id"
                search_content = ip.server.id
                q.children.append((search_field, search_content))
            elif search_field == "department":
                search_field = "department__name__icontains"
                q.children.append((search_field, search_content))
            else:
                search_field = search_field + "__icontains"
                q.children.append((search_field, search_content))

            servers_queryset = group_server_queryset.filter(q).all()
            server_count = servers_queryset.count()
        else:
            servers_queryset = group_server_queryset.all()
            server_count = servers_queryset.count()

        paginator = Pagination(total_data_count=server_count, request=request)
        pagination_html_str = paginator.get_html_code()

        servers = servers_queryset[paginator.begin:paginator.end]

        server_form = ServerForm()

        return render(request, "server.html", {
            "servers": servers,
            "pagination_html_str": pagination_html_str,
            "begin": paginator.begin,
            "server_form": server_form
        })

    def post(self, request, *args, **kwargs):
        return HttpResponse("111122223333")

    def put(self, request, *args, **kwargs):
        msg = {"status": None}
        # 获取ajax发送来的数据
        server_data = request.body.decode("utf-8")
        server_data = json.loads(server_data)
        # 修改数据库中的记录
        server_id = server_data.pop("server_id")
        server_obj = api_models.Server.objects.filter(id=server_id).first()
        if not server_id:
            return HttpResponse("服务器不存在")

        server_form = ServerForm(instance=server_obj, data=server_data)
        if server_form.is_valid():
            server_form.save()
            msg["status"] = "success"
        else:
            msg["status"] = "failed"
        return JsonResponse(msg)

class ServerDetails(View):
    """服务器详情页视图"""
    def get(self, request, *args, **kwargs):
        server_id = kwargs["server_id"]
        server_obj = api_models.Server.objects.filter(pk=server_id).first()
        base_info = {}
        base_info["操作系统"] = server_obj.system
        base_info["制造商"] = server_obj.manufacturer
        base_info["产品名称"] = server_obj.productname
        base_info["SN号"] = server_obj.serialnumber
        base_info["SN号"] = server_obj.serialnumber
        base_info["CPU核数"] = server_obj.cpu
        base_info["CPU型号"] = server_obj.cpu_model
        base_info["内存"] = server_obj.memory

        base_info["IDC"] = server_obj.idc.name if server_obj.idc else None

        # print(base_info)

        nic_queryset = server_obj.nic.all()
        nic_info = nic_queryset.values_list("interface", "ipaddress", "hwaddr", "netmask")
        # print(nic_info)

        disk_queryset = server_obj.mount_set.all()
        disk_info = disk_queryset.values_list("disk_name", "disk_size")
        # print(disk_info)

        return render(request, "server_detail.html",
                      {"server_obj": server_obj, "base_info": base_info, "nic_info": nic_info, "disk_info": disk_info})

class Hosts(View):
    def get(self, request, *args, **kwargs):
        hosts = api_models.Server.objects.filter(is_virtual=True).count()

        return HttpResponse("112211")

class VMView(View):
    def get(self, request, *args, **kwargs):
        vm_count = api_models.Server.objects.filter(server_type="B").count()
        paginator = Pagination(total_data_count=vm_count, request=request)
        pagination_html_str = paginator.get_html_code()

        vms = api_models.Server.objects.filter(server_type="B")[paginator.begin:paginator.end]
        #
        # for vm in vms:
        #     print(vm.name)

        return render(request, "vm.html", {
            "vms": vms,
            "pagination_html_str": pagination_html_str,
            "begin": paginator.begin,
        })

class VmDetails(View):
    def get(self, request, *args, **kwargs):
        vm_id = kwargs["vm_id"]
        server_obj = api_models.Server.objects.filter(pk=vm_id).first()
        base_info = {}
        base_info["操作系统"] = server_obj.system
        base_info["制造商"] = server_obj.manufacturer
        base_info["产品名称"] = server_obj.productname
        base_info["SN号"] = server_obj.serialnumber
        base_info["SN号"] = server_obj.serialnumber
        base_info["CPU核数"] = server_obj.cpu
        base_info["CPU型号"] = server_obj.cpu_model
        base_info["内存"] = server_obj.memory

        base_info["IDC"] = server_obj.idc.name if server_obj.idc else None

        # print(base_info)

        nic_queryset = server_obj.nic.all()
        nic_info = nic_queryset.values_list("interface", "ipaddress", "hwaddr", "netmask")
        # print(nic_info)

        disk_queryset = server_obj.mount_set.all()
        disk_info = disk_queryset.values_list("disk_name", "disk_size")
        # print(disk_info)

        return render(request, "server_detail.html",
                      {"server_obj": server_obj, "base_info": base_info, "nic_info": nic_info, "disk_info": disk_info})


from .utils.sendEmail import send_email

class DeployView(View):
    def get(self, request):
        # 过滤出用户所在组服务器
        group_id = request.session.get("group_id")
        # print(request.session.get("group_title"))
        if group_id != 1:  # 非运维部用户只能查看本部门服务器(运维部id为1)
            group_server_queryset = api_models.Server.objects.filter(department_id=group_id)
        else:  # 运维部可以查看所有服务器
            group_server_queryset = api_models.Server.objects.all()

        # 处理搜索
        search_field = request.GET.get("search_field")
        search_content = request.GET.get("search_content")
        if search_content:
            # 使用Q构建搜索条件
            q = Q()
            search_content = search_content.strip()
            if search_field == "ipaddress":
                ip = api_models.ServerNetwork.objects.filter(ipaddress__icontains=search_content).first()
                search_field = "id"
                search_content = ip.server.id
                q.children.append((search_field, search_content))
            elif search_field == "department":
                search_field = "department__name__icontains"
                q.children.append((search_field, search_content))
                # d = api_models.Server.objects.filter(department__name__icontains=)
            else:
                search_field = search_field + "__icontains"
                q.children.append((search_field, search_content))

            servers_queryset = group_server_queryset.filter(q).all()
            server_count = servers_queryset.count()
        else:
            servers_queryset = group_server_queryset.all()
            server_count = servers_queryset.count()

        paginator = Pagination(total_data_count=server_count, request=request)
        pagination_html_str = paginator.get_html_code()

        servers = servers_queryset[paginator.begin:paginator.end]

        server_form = ServerForm()

        return render(request, "deploy.html", {
            "servers": servers,
            "pagination_html_str": pagination_html_str,
            "begin": paginator.begin,
            "server_form": server_form
        })

    def post(self, request):
        """
        请求salt-api,根据选择环境执行sls.

        :param request:
        :return:
        """
        data = request.body.decode("utf-8")
        data = json.loads(data)
        option = data.get("option")
        tgt_list = data.get("hostname")
        sls_data = {
            'client': 'local',
            'fun': 'state.highstate',
            'tgt': tgt_list,
            'arg': (),
            'kwarg': {
                "saltenv": "base",
                "test": False
            },
            'tgt_type': 'list',
            'timeout': 180
        }
        if option == "NGINX":
            sls_data['kwarg']["saltenv"] = "nginx"
            sls_data['kwarg']["test"] = False
            response_dict = sapi.run(sls_data)
            print(response_dict)
        elif option == "PHP":
            sls_data['kwarg']["saltenv"] = "php"
            # 是否测试
            sls_data['kwarg']["test"] = True
            response_dict = sapi.run(sls_data)
            print(response_dict)
        elif option == "MySQL":
            sls_data['kwarg']["saltenv"] = "mysql"
            sls_data['kwarg']["test"] = True
            response_dict = sapi.run(sls_data)
            print(response_dict)
        else:
            sls_data['kwarg']["saltenv"] = "lnmp"
            sls_data['kwarg']["test"] = True
            response_dict = sapi.run(sls_data)
            print(response_dict)

        msg = ""
        for tgt, value_dict in response_dict.items():
            status = ""
            for _, value in value_dict.items():
                if value["result"] == False:
                    status += "{} 安装失败,请登录服务器解决错误后重试.".format(option)
                    break
            status = "{} 安装成功!".format(option) if not status else status
            msg += "{}: {}\n\n".format(tgt, status)

        email_address = request.session["user_info"]["email"]
        subject = "Install {}".format(option)
        message = msg
        email = send_email(subject=subject, message=message, to=[email_address, ])
        email.send()
        return HttpResponse("ajax success")