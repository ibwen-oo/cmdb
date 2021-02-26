from django.db import models


class Department(models.Model):
    name = models.CharField(verbose_name="部门名称", max_length=32, null=True)

    def __str__(self):
        return self.name

class IDC(models.Model):
    region = models.CharField(verbose_name="区域", max_length=64, null=True)
    name = models.CharField(verbose_name="IDC名称", max_length=32, null=True)
    floor = models.IntegerField(verbose_name='楼层', default=1, null=True)
    address = models.CharField(verbose_name="IDC地址", max_length=32, null=True)
    desc = models.CharField(verbose_name="描述信息", max_length=64, null=True)

    def __str__(self):
        return self.name

class Server(models.Model):
    """服务器表"""
    uuid = models.CharField(verbose_name="服务器唯一标识符", max_length=64, null=True)
    name = models.CharField(verbose_name="主机名称", max_length=32)
    hostname = models.CharField(verbose_name="hostname", max_length=32, null=True)
    cpu = models.CharField(verbose_name="cpu", max_length=32, null=True)
    cpu_model = models.CharField(verbose_name="cpu_model", max_length=64, null=True)
    memory = models.CharField(verbose_name="内存", max_length=32, null=True)
    system = models.CharField(verbose_name="操作系统", max_length=32, null=True)
    kernelrelease = models.CharField(verbose_name="内核版本", max_length=32, null=True)
    manufacturer = models.CharField(verbose_name="制造商", max_length=32, null=True)
    productname = models.CharField(verbose_name="产品名称", max_length=64, null=True)
    serialnumber = models.CharField(verbose_name="SN", max_length=128, null=True)
    STATUS_CHOICES = (("on", "online"), ("off", "offline"))
    status = models.CharField(verbose_name="服务器状态", choices=STATUS_CHOICES, max_length=8, default="on")
    TYPE_CHOICE = (("A", "物理机"), ("B", "虚拟机"), ("C", "云主机"))
    server_type = models.CharField(verbose_name="服务器类型", choices=TYPE_CHOICE, max_length=8, default="A")
    is_virtual = models.BooleanField(verbose_name="是否是虚拟化", blank=True, default=False)
    create_at = models.DateTimeField(verbose_name="添加时间", blank=True, auto_now_add=True, null=True)
    update_at = models.DateTimeField(verbose_name="更新时间", blank=True, auto_now=True, null=True)
    idc = models.ForeignKey(to=IDC, on_delete=models.CASCADE, null=True)
    department = models.ForeignKey(to="Department", on_delete=models.CASCADE, default=1)
    desc = models.CharField(verbose_name="描述信息", max_length=128, null=True)


    def __str__(self):
        return self.name

class HostStore(models.Model):
    """ESXI物理机存储表"""
    name = models.CharField(verbose_name="存储名称", max_length=32)
    store_size = models.CharField(verbose_name="磁盘存储", max_length=32, null=True)
    store_free = models.CharField(verbose_name="可用存储空间", max_length=32, null=True)
    store_used_percent = models.CharField(verbose_name="磁盘使用率", max_length=32, null=True)
    host = models.ForeignKey(to="Server", on_delete=models.CASCADE)
    desc = models.CharField(verbose_name="描述信息", max_length=64, null=True)

    def __str__(self):
        return self.name

class VirtualServerList(models.Model):
    """用于存储每台宿主机上有哪些虚拟机"""
    name = models.CharField(verbose_name="虚拟机名称", max_length=64, null=True)
    ip = models.CharField(verbose_name="虚拟机ip", max_length=64, null=True)
    power_state = models.CharField(verbose_name="电源状态", max_length=32, default="poweredOff")
    vm_state = models.CharField(verbose_name="服务器状态", max_length=32, default="Running")
    boot_time = models.DateTimeField(verbose_name="开机时间", null=True)
    resourcePool = models.CharField(verbose_name="资源池", max_length=32, null=True)
    folder = models.CharField(verbose_name="虚拟机所在folder", max_length=32, null=True)
    host = models.ForeignKey(to="Server", on_delete=models.CASCADE)
    desc = models.CharField(verbose_name="描述信息", max_length=64, null=True)

    def __str__(self):
        return self.name

class ServerNetwork(models.Model):
    """服务器网络表"""
    interface = models.CharField(verbose_name="网卡名", max_length=32, null=True)
    ipaddress = models.CharField(verbose_name="ip地址", max_length=32, null=True)
    hwaddr = models.CharField(verbose_name="MAC地址", max_length=32, null=True)
    netmask = models.CharField(verbose_name="netmask", max_length=32, null=True)
    state = models.BooleanField(verbose_name="网络状态", default=False)
    desc = models.CharField(verbose_name="描述信息", max_length=64, null=True)
    server = models.ForeignKey(to="Server", related_name="nic", on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.interface

class Disk(models.Model):
    """硬盘表(物理机硬盘信息)"""
    name = models.CharField(verbose_name='磁盘名', max_length=32, blank=True, null=True)
    slot = models.CharField(verbose_name='插槽位', max_length=32, blank=True, null=True)
    model = models.CharField(verbose_name='磁盘型号', max_length=128, blank=True, null=True)
    capacity = models.FloatField(verbose_name='磁盘容量GB', blank=True, null=True)
    disk_iface_choice = (
        ('A', 'SATA'),
        ('B', 'SAS'),
        ('C', 'SCSI'),
        ('D', 'SSD'),
    )
    pd_type = models.CharField(verbose_name='磁盘类型', choices=disk_iface_choice, max_length=64, blank=True, null=True)
    desc = models.TextField(verbose_name='备注', blank=True, null=True)
    create_at = models.DateTimeField(blank=True, auto_now_add=True)
    update_at = models.DateTimeField(blank=True, auto_now=True)
    server = models.ForeignKey('Server', on_delete=models.CASCADE, null=True)

    def __str__(self):
        return 'slot:%s size:%s' % (self.slot, self.capacity)

class Mount(models.Model):
    """磁盘信息(获取盘符及磁盘大小)"""
    disk_name = models.CharField(verbose_name="盘符", max_length=16, null=True)
    disk_size = models.CharField(verbose_name="磁盘大小", max_length=16, null=True)
    server = models.ForeignKey(to="Server", on_delete=models.CASCADE, null=True)


class HandleLog(models.Model):
    """资产变更记录"""
    content = models.TextField(null=True, blank=True, verbose_name="变更记录")
    create_at = models.DateTimeField(auto_now_add=True)
    servers = models.ForeignKey('Server', on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.content



'''
class ServerDisk(models.Model):
    """服务器磁盘表"""
    pass

class EsxiMetaInfo(models.Model):
    """
    存储ESXI的基本信息,比如folder、resourcePool等等,
    用于clone虚拟机时提供可选参数.
    """
    folder_name = models.CharField(verbose_name="目录", max_length=64, null=True)
    resourcePool = models.CharField(verbose_name="", max_length=64, null=True)
    ...
'''









