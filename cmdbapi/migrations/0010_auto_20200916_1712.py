# Generated by Django 3.1 on 2020-09-16 17:12

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('cmdbapi', '0009_auto_20200916_1543'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='server',
            name='group',
        ),
        migrations.DeleteModel(
            name='Group',
        ),
    ]
