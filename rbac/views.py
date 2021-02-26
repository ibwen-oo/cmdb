import json
from collections import OrderedDict
from django.conf import settings
from django.shortcuts import render, redirect, HttpResponse
from django.http import JsonResponse
from django.utils.module_loading import import_string
from django.views import View
from django.urls import reverse
from django.forms import formset_factory

from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

from rbac import models
from cmdbweb import models as web_model
from rbac.utils.urls import memory_reverse
from rbac.utils.router import get_all_url_dict
from rbac.form.rbac_form import (RoleModelForm, MenuModelForm, SecondMenuModelForm,
                                 PermissionModelForm, MultiEditPermissionForm,
                                 MultiAddPermissionForm, UserModelForm, UpdateUserModelForm
                                 )

class RolesViews(View):
    def get(self, request, rid=None):
        """返回角色列表"""
        role_queryset = models.Role.objects.all()
        # print(role_queryset)
        if not rid:
            role_form = RoleModelForm()
        else:  # 传入rid,表示是编辑角色请求
            role_obj = models.Role.objects.filter(id=rid).first()
            role_form = RoleModelForm(instance=role_obj)
            return render(request, "rbac/change.html", {"form": role_form})
        return render(request, 'rbac/role_list.html', {'roles': role_queryset, "role_form": role_form})

    def post(self, request, rid=None):
        if not rid:  # 没有rid,表示是新建角色请求
            role_form = RoleModelForm(data=request.POST)
        else: # 传入rid,表示是保存编辑角色请求
            role_obj = models.Role.objects.filter(id=rid).first()
            role_form = RoleModelForm(instance=role_obj, data=request.POST)
        if role_form.is_valid():
            # print("开始保存角色数据")
            role_form.save()
            return redirect(reverse("rbac:roles"))
        else:
            # print("角色数据验证失败")
            return render(request, "rbac/change.html", {"form": role_form})

    def put(self, request, *args, **kwargs):
        data = request.body.decode("utf-8")
        # print(data)
        return JsonResponse({"status": "success"})

    def delete(self, request):
        msg = {"status": None}
        data = request.body.decode("utf-8")
        data = json.loads(data)
        # print(data)
        role_id = data.get("role_id", None)
        if not role_id:
            return HttpResponse("角色不存在")
        try:
            role_id = int(role_id)
            models.Role.objects.filter(id=role_id).delete()
            msg["status"] = "success"
            return JsonResponse(msg)
        except Exception as e:
            msg["status"] = str(e)
            return JsonResponse(msg)


class PermissionViews(View):
    """分配权限视图"""
    def get(self, request, *args, **kwargs):
        # 业务中的用户表(cmdbweb.models.User)
        user_model_class = import_string(settings.RBAC_USER_MODLE_CLASS)

        user_id = request.GET.get("uid")
        user_object = user_model_class.objects.filter(id=user_id).first()
        if not user_object:
            user_id = None

        role_id = request.GET.get("rid")
        role_obj = models.Role.objects.filter(id=role_id).first()
        if not role_obj:
            role_id = None

        # 获取当前用户的所有角色
        if user_id:
            user_has_roles = user_object.roles.all()
        else:
            user_has_roles = []

        # user_has_roles_dict = {item.id: None for item in user_has_roles}
        # 当前点击选取用户的所有角色的角色id列表
        user_has_roles_list = [item.id for item in user_has_roles]
        # print(user_has_roles_list)

        # 如果选择了角色,优先显示选中角色所拥有的权限
        # 如果没有选择角色,显示用户所拥有的权限
        if role_obj:  # 选中了角色
            user_has_permissions = role_obj.permissions.all()
            user_has_permissions_list = [item.id for item in user_has_permissions]
        elif user_object:  # 选中了用户但为选中角色
            user_has_permissions = user_object.roles.filter(permissions__id__isnull=False).values('id', 'permissions').distinct()
            user_has_permissions_list = [item["permissions"] for item in user_has_permissions]
        else:
            user_has_permissions_list = []


        # 所有的菜单(一级菜单)
        all_menu_list = models.Menu.objects.values('id', 'title')
        # print(all_menu_list)
        all_menu_dict = {}

        for item in all_menu_list:
            item["children"] = []
            all_menu_dict[item['id']] = item

        # print("all_menu_dict: ", all_menu_dict)

        # 所有二级菜单
        all_second_menu_list = models.Permission.objects.filter(menu__isnull=False).values('id', 'title', 'menu_id')
        # print(all_second_menu_list)
        all_second_menu_dict = {}

        for row in all_second_menu_list:
            row["children"] = []
            all_second_menu_dict[row['id']] = row
            menu_id = row['menu_id']
            all_menu_dict[menu_id]['children'].append(row)

        # 所有的不能做菜单的权限
        all_permission_list =models.Permission.objects.filter(menu__isnull=True).values("id", "title", "pid_id")
        # print(all_permission_list)
        for row in all_permission_list:
            pid = row['pid_id']
            if not pid:
                continue
            all_second_menu_dict[pid]['children'].append(row)

        # print(all_menu_dict)
        # print(all_second_menu_dict)

        all_user_list = user_model_class.objects.all()
        all_role_list = models.Role.objects.all()

        return render(request, "rbac/permission_distribute.html", {
            "user_list": all_user_list,
            "role_list": all_role_list,
            "user_id": user_id,
            "role_id": role_id,
            "user_has_roles_list": user_has_roles_list,
            "all_menu_list": all_menu_list,
            "user_has_permissions_list": user_has_permissions_list
        })

    def post(self, request, *args, **kwargs):
        # 处理修改用户角色的情况
        if request.POST.get("type") == "role":
            role_id_list = request.POST.getlist('roles')
            user_id = request.GET.get("uid")
            user_model_class = import_string(settings.RBAC_USER_MODLE_CLASS)
            user_obj = user_model_class.objects.filter(id=user_id).first()
            if not user_obj:
                return HttpResponse("请先选择用户,再分配角色!!!")
            user_obj.roles.set(role_id_list)

        # 处理修改角色权限的情况
        if request.POST.get("type") == "permission":
            permission_id_list = request.POST.getlist('permissions')
            role_id = request.GET.get("rid")
            role_object = models.Role.objects.filter(id=role_id).first()
            if not role_object:
                return HttpResponse('请选择角色,再分配权限!!!')
            role_object.permissions.set(permission_id_list)

        return redirect(reverse("rbac:permissions"))


class MenuPermissionViews(View):
    def get(self, request, *args, **kwargs):
        # 所有的一级菜单
        menus = models.Menu.objects.all()
        # 用户选择的一级菜单的id
        menu_id = request.GET.get("mid")
        # 用户选择的二级菜单
        second_menu_id = request.GET.get("sid")

        # 判断一级菜单是否存在
        menu_exists = models.Menu.objects.filter(id=menu_id).exists()
        if not menu_exists:
            menu_id = None

        second_menus = models.Permission.objects.filter(menu_id=menu_id) if menu_id else None


        # 判断二级菜单是否存在
        second_menu_exists = models.Permission.objects.filter(id=second_menu_id).exists()
        if not second_menu_exists:
            second_menu_id = None

        permissions = models.Permission.objects.filter(pid=second_menu_id) if second_menu_id else []

        return render(request, "rbac/menu_list.html", {
            "menus": menus,
            "second_menus": second_menus,
            'permissions': permissions,
            'menu_id': menu_id,
            'second_menu_id': second_menu_id,
        })

    def post(self, request, *args, **kwargs):
        pass


class ManageMenuView(View):
    """管理一级菜单视图(增/删/编辑)"""
    def get(self, request):
        menu_id = request.GET.get("mid")
        if not menu_id:  # 没有menu_id,表示新建一级菜单
            form = MenuModelForm()
        else:  # 传入menu_id,表示编辑指定的一级菜单
            menu_obj = models.Menu.objects.filter(id=menu_id).first()
            form = MenuModelForm(instance=menu_obj)
        return render(request, 'rbac/change.html', {'form': form})

    def post(self, request):
        """处理创建或编辑一级菜单的form请求"""
        form = MenuModelForm(data=request.POST)
        if form.is_valid():
            form.save()
            return redirect(memory_reverse(request, 'rbac:menu_permission'))
        return render(request, 'rbac/change.html', {'form': form})

    def delete(self, request, *args, **kwargs):
        msg = {"status": None}
        data = request.body.decode("utf-8")
        menu_data = json.loads(data)
        try:
            menu_id = int(menu_data["menu_id"])
            models.Menu.objects.filter(id=menu_id).delete()
            msg["status"] = "success"
        except Exception as e:
            msg["status"] = str(e)
        return JsonResponse(msg)


class ManageSecondMenuView(View):
    """管理二级菜单"""
    def get(self, request, sid=None):
        if not sid:  # 没有sid,表示新建二级菜单
            form = SecondMenuModelForm()
        else:  # 传入sid,表示编辑指定的二级菜单
            permission_object = models.Permission.objects.filter(id=sid).first()
            form = SecondMenuModelForm(instance=permission_object)
        return render(request, 'rbac/change.html', {'form': form})

    def post(self, request, sid=None):
        permission_object = models.Permission.objects.filter(id=sid).first()
        form = SecondMenuModelForm(data=request.POST, instance=permission_object)
        if form.is_valid():
            form.save()
            return redirect(memory_reverse(request, 'rbac:menu_permission'))
        return render(request, 'rbac/change.html', {'form': form})

    def delete(self, request):
        msg = {"status": None}
        data = request.body.decode("utf-8")
        menu_data = json.loads(data)
        try:
            sid = int(menu_data["sid"])
            models.Permission.objects.filter(id=sid).delete()
            msg["status"] = "success"
        except Exception as e:
            msg["status"] = str(e)
        return JsonResponse(msg)


class ManagePermissionView(View):
    def get(self, request, pk=None):
        """
        生成添加/修改权限的form表单
        :param request:
        :param pk: 权限id,如果有值,说明是在编辑权限,无值则是在添加权限.
        :return:
        """
        if pk:  # 修改权限
            permission_obj = models.Permission.objects.filter(id=pk).first()
            print("permission_obj", permission_obj)
            form = PermissionModelForm(instance=permission_obj)
        else:  # 添加权限
            form = PermissionModelForm()
        return render(request, "rbac/change.html", {"form": form})

    def post(self, request, pk=None):
        """
        添加/编辑权限
        :param request:
        :param pk: 权限id,如果有值,说明是在编辑权限,无值则是在添加权限.
        :return:
        """
        if not pk:  # 添加权限
            sid = request.GET.get("sid")
            if not sid:
                return HttpResponse("二级菜单不存在，请重新选择!")
            form = PermissionModelForm(data=request.POST)
            if form.is_valid():
                second_menu_object = models.Permission.objects.filter(id=sid).first()
                if not second_menu_object:
                    return HttpResponse('二级菜单不存在，请重新选择！')
                form.instance.pid = second_menu_object
                form.save()
                return redirect(memory_reverse(request, 'rbac:menu_permission'))
        else:  # 修改权限
            permission_object = models.Permission.objects.filter(id=pk).first()
            form = PermissionModelForm(data=request.POST, instance=permission_object)
            if form.is_valid():
                form.save()
                return redirect(memory_reverse(request, 'rbac:menu_permission'))

        return render(request, 'rbac/change.html', {'form': form})

    def delete(self, request):
        msg = {"status": None}
        data = request.body.decode("utf-8")
        permission_data = json.loads(data)
        try:
            permission_id = int(permission_data["permission_id"])
            models.Permission.objects.filter(id=permission_id).delete()
            msg["status"] = "success"
        except Exception as e:
            msg["status"] = str(e)
        return JsonResponse(msg)


class MultiPermissionView(View):
    """批量管理权限"""
    def get(self, request):
        """
        使用 formset 生成批量管理权限的form表单.
        更新和删除部分还有bug,因为使用的是CBV,要是用url别名+请求方法才能完整表达一个权限,
        所以批量更新和删除部分的计算有问题,以后解决.
        :param request:
        :return:
        """
        generate_formset_class = formset_factory(MultiAddPermissionForm, extra=5)
        update_formset_class = formset_factory(MultiEditPermissionForm, extra=0)

        generate_formset = None
        update_formset = None

        # 获取项目中所有的url
        # 1. 获取项目中所有的URL
        all_url_dict = get_all_url_dict()
        # print("all_url_dict: ", all_url_dict)

        router_name_set = set(all_url_dict.keys())
        # print("router_name_set: ", router_name_set)

        # 2. 取出数据库中的所有permission
        permissions = models.Permission.objects.all().values('id', 'title', 'name', 'url', 'action', 'menu_id', 'pid_id')
        permission_dict = OrderedDict()
        permission_name_set = set()
        for row in permissions:
            key = "{}-{}".format(row['name'], row["action"])
            permission_dict[key] = row
            permission_name_set.add(row['name'])

        for name, value in permission_dict.items():
            router_row_dict = all_url_dict.get(name)
            if not router_row_dict:
                continue
            if value["url"] != router_row_dict["url"]:
                value["url"] = "路由和数据库中的不一致"

        # 3. 计算出应该增加的权限(路由中有,数据库中没有的)
        if not generate_formset:
            generate_name_list = router_name_set - permission_name_set
            # print("router_name_set: ", router_name_set)
            # print("permission_name_set: ", permission_name_set)
            # print("generate_name_list: ", generate_name_list)
            generate_formset = generate_formset_class(
                initial=[row_dict for name, row_dict in all_url_dict.items() if name in generate_name_list]
            )

        delete_name_list = permission_name_set - router_name_set
        delete_row_list = [row_dict for name, row_dict in permission_dict.items() if name in delete_name_list]

        if not update_formset:
            update_formset = update_formset_class(
                initial=[row_dict for name, row_dict in permission_dict.items()])

        # print(permission_dict)
        return render(request, "rbac/multi_permissions.html", {
            "generate_formset": generate_formset,
            "update_formset": update_formset,
            "delete_row_list": delete_row_list
        })

    def post(self, request):
        post_type = request.GET.get('type')  # update(批量更新权限)/generate(批量新增权限)

        update_formset = None

        # 批量更新
        if post_type == 'update':
            update_formset_class = formset_factory(MultiEditPermissionForm, extra=0)
            formset = update_formset_class(data=request.POST)
            update_formset = formset

            if formset.is_valid():
                post_row_list = formset.cleaned_data
                for i in range(0, formset.total_form_count()):
                    row_dict = post_row_list[i]
                    permission_id = row_dict.pop('id')
                    try:
                        row_object = models.Permission.objects.filter(id=permission_id).first()
                        for k, v in row_dict.items():
                            setattr(row_object, k, v)
                        row_object.validate_unique()
                        row_object.save()
                    except Exception as e:
                        print("保存失败")
                        formset.errors[i].update(e)
                        update_formset = formset
            else:
                print("formset验证失败")
                update_formset = formset

            return render(request, "rbac/multi_permissions.html", {
                "update_formset": update_formset,
            })

        if post_type == "generate":
            generate_formset_class = formset_factory(MultiAddPermissionForm, extra=0)
            formset = generate_formset_class(data=request.POST)
            generate_formset = formset
            if formset.is_valid():
                object_list = []
                post_row_list = formset.cleaned_data
                has_error = False
                for i in range(0, formset.total_form_count()):
                    row_dict = post_row_list[i]
                    try:
                        new_object = models.Permission(**row_dict)
                        new_object.validate_unique()
                        object_list.append(new_object)
                    except Exception as e:
                        formset.errors[i].update(e)
                        generate_formset = formset
                        has_error = True
                if not has_error:
                    models.Permission.objects.bulk_create(object_list, batch_size=100)
            else:
                generate_formset = formset

            return render(request, "rbac/multi_permissions.html", {
                "generate_formset": generate_formset,
            })

@method_decorator(csrf_exempt, name='dispatch')
class UserView(View):
    """管理用户"""
    def get(self, request):
        user_queryset = web_model.User.objects.all()
        user_form = UpdateUserModelForm()
        return render(request, "rbac/user_list.html", {"users": user_queryset, "user_form": user_form})

    def post(self, request):
        if request.POST.get("name"):
            user_form = UserModelForm()
        else:
            user_form = UserModelForm(request.POST)
            if user_form.is_valid():
                user_form.save()
                return redirect(reverse("rbac:user"))
            else:
                # 处理form验证的异常
                pass
        return render(request, 'rbac/change.html', {'form': user_form})

    def put(self, request):
        msg = {"status": None}
        # 获取ajax发送来的数据
        data = request.body.decode("utf-8")
        user_info = json.loads(data)
        print(user_info)
        # 正在编辑的用户id
        uid = user_info.pop("uid")
        if not uid:
            return HttpResponse("用户不存在")
        user_obj = web_model.User.objects.filter(id=uid).first()
        user_form = UpdateUserModelForm(instance=user_obj, data=user_info)
        if user_form.is_valid():
            user_form.save()
            msg["status"] = "success"
        else:
            msg["status"] = "failed"
        return JsonResponse(msg)

    def delete(self, request):
        msg = {"status": None}
        data = request.body.decode("utf-8")
        data = json.loads(data)
        user_id = data.get("user_id", None)
        if not user_id:
            return HttpResponse("该用户不存在")
        try:
            web_model.User.objects.filter(id=user_id).delete()
            msg["status"] = "success"
        except Exception as e:
            msg["status"] = str(e)
        finally:
            return JsonResponse(msg)


