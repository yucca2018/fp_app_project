from rest_framework import viewsets
from .models import UserInfo
from .serializer import UserInfoSerializer



# CRUD操作を可能にする
class UserInfoViewSet(viewsets.ModelViewSet):
    # モデルのオブジェクトを取得
    queryset = UserInfo.objects.all()
    # シリアライザーを取得
    serializer_class = UserInfoSerializer

    def list(self, request, *args, **kwargs):
        # GETメソッドを許可する
        return super().list(request, *args, **kwargs)







