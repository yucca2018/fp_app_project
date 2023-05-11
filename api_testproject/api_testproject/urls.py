from django.contrib import admin
from django.urls import path,include
from rest_framework import routers
from drf_test_app.views import UserInfoViewSet



# DefaultRouter クラスのインスタンスを代入
defaultRouter = routers.DefaultRouter()
# userInfo/ にUserInfoViewSetをルーティングする(エンドポイントの設定)
defaultRouter.register('userInfo',UserInfoViewSet)

urlpatterns = [
    path('admin/',admin.site.urls),
    # defaultRouter をinclude する
    path('api/',include(defaultRouter.urls)),
]
