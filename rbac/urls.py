from django.urls import path, re_path
from . import views

app_name = 'rbac'

urlpatterns = [
    path('roles/', views.RolesViews.as_view(), name='roles'),
    re_path(r'roles/(?P<rid>\d+)/$', views.RolesViews.as_view(), name='edit_role'),
    path('permissions/', views.PermissionViews.as_view(), name='permissions'),
    path('menu/', views.MenuPermissionViews.as_view(), name='menu_permission'),
    path('managemenu/', views.ManageMenuView.as_view(), name='manage_menu'),
    path('secondmenu/', views.ManageSecondMenuView.as_view(), name='manage_second_menu'),
    re_path(r'^secondmenu/(?P<sid>\d+)/$', views.ManageSecondMenuView.as_view(), name='edit_second_menu'),
    path('managepermission/', views.ManagePermissionView.as_view(), name='manage_permission'),
    re_path(r'^managepermission/(?P<pk>\d+)/$', views.ManagePermissionView.as_view(), name='edit_permission'),
    path('multipermission/', views.MultiPermissionView.as_view(), name="multi_manage_permission"),
    path("user/", views.UserView.as_view(), name="user"),
]
