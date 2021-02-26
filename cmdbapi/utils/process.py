from .. import models

class ProcessServerInfo:
    """
    处理采集器发来的宿主机信息.
    """
    def __init__(self, server_base_info, server_disk_info):
        # 解析server基础信息
        self.server_base_info = server_base_info
        if not self.server_base_info["status"]:
            # 如果有异常,处理异常
            print(self.server_base_info["error"])
            raise
        else:
            self.server_info = server_base_info["data"]
            # print(self.server_info)
            self.server_name = self.server_info["name"]
            # 通过uuid查看数据库中是否已存在server
            self.server_uuid = self.server_info["uuid"]
            self.server_obj = models.Server.objects.filter(uuid=self.server_uuid).first()
            self.network = self.server_info.pop("network")
            # 解析服务器类型
            _type = self.server_info.pop("virtual")
            self.server_type = "A" if _type == "physical" else "B"

        # 解析disk信息
        self.server_disk = server_disk_info
        if not self.server_disk["status"]:
            print(self.server_disk["error"])
            raise
        else:
            self.server_disk_data = self.server_disk["data"]

    def process_server(self):
        """处理采集器发送来的宿主机信息"""

        # 采集器发送来的数据字典的key要跟数据库字段一致
        if not self.server_obj:
            models.Server.objects.create(**self.server_info, server_type=self.server_type)
        else:
            # 更新(使用反射)
            for key, value in self.server_info.items():
                setattr(self.server_obj, key, value)
            self.server_obj.save()

            # 删除(以后实现)

    def process_network(self):
        """新增、更新、删除宿主机网络信息"""

        # 采集器发送来的最新的网络信息
        new_network_set = set(self.network)

        # 数据库中的保存的之前的网络信息
        db_network_queryset = models.ServerNetwork.objects.filter(server=self.server_obj)
        db_network_dict = {row.interface: row for row in db_network_queryset}
        db_network_set = set(db_network_dict)

        # 通过set找出新增、删除、更新的网卡
        create_network_set = new_network_set - db_network_set
        delete_network_set = db_network_set - new_network_set
        update_network_set = new_network_set & db_network_set

        # 新增
        for interface in create_network_set:
            value_dict = self.network[interface]
            models.ServerNetwork.objects.create(**value_dict, server=self.server_obj)

        # 删除
        models.ServerNetwork.objects.filter(server=self.server_obj, interface__in=delete_network_set).delete()

        # 更新
        for key in update_network_set:
            value_dict = self.network[key]
            for field, value in value_dict.items():
                # print(field, value, type(value))
                setattr(db_network_dict[key], field, value)
            db_network_dict[key].save()

    def process_disk(self):
        """处理采集器发送来的磁盘信息"""
        # 新增disk
        new_disk_dict = self.server_disk_data[self.server_name]
        new_disk_set = set(new_disk_dict)
        disk_queryset = models.Mount.objects.filter(server=self.server_obj)
        db_disk_dict = {row.disk_name: row for row in disk_queryset}
        db_disk_set = set(db_disk_dict)
        # print(new_disk_set, db_disk_set)

        # 集合运算获取新增/更新/删除的磁盘
        create_disk_set = new_disk_set - db_disk_set
        update_disk_set = new_disk_set & db_disk_set
        delete_disk_set = db_disk_set - new_disk_set

        # 新增
        for name in create_disk_set:
            size = new_disk_dict[name]
            models.Mount.objects.create(disk_name=name, disk_size=size, server=self.server_obj)

        # 更新
        for name in update_disk_set:
            size = new_disk_dict[name]
            db_disk_dict[name].disk_name = name
            db_disk_dict[name].disk_size = size
            db_disk_dict[name].save()

        # 删除
        models.Mount.objects.filter(server=self.server_obj, disk_name__in=delete_disk_set).delete()



"""
class ProcessVirtualMachine:
    def __init__(self, vm_info, vm_obj, host_obj):
        self.vm_info = vm_info
        self.vm_obj = vm_obj
        self.host_obj = host_obj
        self.base_info = vm_info["data"]
        self.status = self.vm_info["status"]
        # 如获取数据失败，抛出异常
        if not self.status:
            print("获取宿主机信息失败")
            print(self.vm_info["error"])
            raise

    def process_vm(self):
        vm_name = self.base_info["name"]
        # boot_time转成datetime类型
        boot_time = self.base_info.pop("boot_time")
        boot_time = datetime.datetime.strptime(boot_time, "%Y-%m-%d %H:%M:%S %Z") if boot_time else None
        boot_time = boot_time.astimezone(pytz.UTC) if boot_time else None

        # 新增或更新
        self.base_info.update({"boot_time": boot_time, "host": self.host_obj})
        obj, create = models.VirtualServer.objects.update_or_create(name=vm_name, defaults=self.base_info)
"""

