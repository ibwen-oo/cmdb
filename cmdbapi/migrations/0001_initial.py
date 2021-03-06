# Generated by Django 3.1 on 2020-08-12 10:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Department',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, verbose_name='部门名称')),
            ],
        ),
        migrations.CreateModel(
            name='IDC',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, verbose_name='IDC名称')),
                ('address', models.CharField(max_length=32, verbose_name='IDC地址')),
            ],
        ),
        migrations.CreateModel(
            name='Server',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, verbose_name='主机名称')),
                ('hostname', models.CharField(max_length=32, null=True, verbose_name='hostname')),
                ('cpu', models.CharField(max_length=32, null=True, verbose_name='cpu')),
                ('cpu_model', models.CharField(max_length=64, null=True, verbose_name='cpu_model')),
                ('memory', models.CharField(max_length=32, null=True, verbose_name='内存')),
                ('system', models.CharField(max_length=32, null=True, verbose_name='操作系统')),
                ('kernelrelease', models.CharField(max_length=32, null=True, verbose_name='内核版本')),
                ('manufacturer', models.CharField(max_length=32, null=True, verbose_name='制造商')),
                ('productname', models.CharField(max_length=64, null=True, verbose_name='产品名称')),
                ('serialnumber', models.CharField(max_length=128, null=True, verbose_name='SN')),
                ('status', models.CharField(choices=[('on', 'online'), ('off', 'offline')], default='on', max_length=8, verbose_name='服务器状态')),
                ('type', models.CharField(choices=[('A', '物理机'), ('B', '虚拟机'), ('C', '云主机')], default='A', max_length=8, verbose_name='服务器类型')),
                ('desc', models.CharField(max_length=128, null=True, verbose_name='描述信息')),
                ('department', models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='cmdbapi.department')),
                ('idc', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='cmdbapi.idc')),
            ],
        ),
        migrations.CreateModel(
            name='VirtualServerList',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=64, null=True, verbose_name='虚拟机名称')),
                ('ip', models.CharField(max_length=64, null=True, verbose_name='虚拟机ip')),
                ('power_state', models.CharField(default='poweredOff', max_length=32, verbose_name='电源状态')),
                ('vm_state', models.CharField(default='Running', max_length=32, verbose_name='服务器状态')),
                ('boot_time', models.DateTimeField(null=True, verbose_name='开机时间')),
                ('resourcePool', models.CharField(max_length=32, null=True, verbose_name='资源池')),
                ('folder', models.CharField(max_length=32, null=True, verbose_name='虚拟机所在folder')),
                ('desc', models.CharField(max_length=64, null=True, verbose_name='描述信息')),
                ('host', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='cmdbapi.server')),
            ],
        ),
        migrations.CreateModel(
            name='ServerNetwork',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('interface', models.CharField(max_length=32, null=True, verbose_name='网络接口')),
                ('ipaddress', models.CharField(max_length=32, null=True, verbose_name='ip地址')),
                ('hwaddr', models.CharField(max_length=32, null=True, verbose_name='MAC地址')),
                ('netmask', models.CharField(max_length=32, null=True, verbose_name='netmask')),
                ('state', models.BooleanField(default=False, verbose_name='网络状态')),
                ('desc', models.CharField(max_length=64, null=True, verbose_name='描述信息')),
                ('host', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='cmdbapi.server')),
            ],
        ),
        migrations.CreateModel(
            name='HostStore',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, verbose_name='存储名称')),
                ('store_size', models.CharField(max_length=32, null=True, verbose_name='磁盘存储')),
                ('store_free', models.CharField(max_length=32, null=True, verbose_name='可用存储空间')),
                ('store_used_percent', models.CharField(max_length=32, null=True, verbose_name='磁盘使用率')),
                ('desc', models.CharField(max_length=64, null=True, verbose_name='描述信息')),
                ('host', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='cmdbapi.server')),
            ],
        ),
    ]
