from django.urls import path, re_path
from . import views

app_name = "cmdbweb"

urlpatterns = [
    path('login/', views.Login.as_view(), name="login"),
    path('logout/', views.logout, name="logout"),
    path('index/', views.IndexView.as_view(), name="index"),
    path('server/', views.ServerView.as_view(), name="server"),
    path('vm/', views.VMView.as_view(), name="vm"),
    path('deploy/', views.DeployView.as_view(), name="deploy"),
    re_path(r'detail/(?P<server_id>\d+)/$', views.ServerDetails.as_view(), name="detail"),
    re_path(r'vm_detail/(?P<vm_id>\d+)/$', views.VmDetails.as_view(), name="vm_detail"),
]
