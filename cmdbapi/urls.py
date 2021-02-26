from django.urls import re_path
from . import views

app_name = "cmdbapi"

urlpatterns = [
    re_path(r'(?P<version>\w+)/server/$', views.Server.as_view(), name="server"),
]