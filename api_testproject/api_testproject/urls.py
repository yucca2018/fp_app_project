# from django.contrib import admin
# from django.urls import path,include
# from rest_framework.authtoken import views

from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('drf_test_app.urls')),
    path('api-token-auth/', views.obtain_auth_token),
]



# # DefaultRouter クラスのインスタンスを代入
# defaultRouter = routers.DefaultRouter()
# # userInfo/ にUserInfoViewSetをルーティングする(エンドポイントの設定)
# defaultRouter.register('userInfo',UserInfoViewSet)

# urlpatterns = [
#     path('admin/',admin.site.urls),
#     # defaultRouter をinclude する
#     path('api/v1/', include('drf_test_app.urls')),
#     # path('api/',include(defaultRouter.urls)),
#     path('api-token-auth/', views.obtain_auth_token),
# ]
