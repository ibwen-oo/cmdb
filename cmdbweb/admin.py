from django.contrib import admin

from . import models
from rbac import models as rbac_models

admin.site.register(models.User)
admin.site.register(rbac_models.Role)
admin.site.register(rbac_models.Permission)
admin.site.register(rbac_models.Menu)

