from django.urls import include, path
from rest_framework.routers import DefaultRouter
from .views import UserInfoViewSet

router = DefaultRouter()
router.register(r'drf_test_app', UserInfoViewSet)

urlpatterns = [
    path('', include(router.urls))
]