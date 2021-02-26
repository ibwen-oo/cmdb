from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include("cmdbapi.urls", namespace="cmdbapi")),
    path('rbac/', include("rbac.urls", namespace="rbac")),
    path('', include("cmdbweb.urls", namespace="cmdbweb")),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
