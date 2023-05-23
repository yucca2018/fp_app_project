from rest_framework import viewsets
from .models import UserInfo
from .serializer import UserInfoSerializer
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated



# CRUD操作を可能にする
class UserInfoViewSet(viewsets.ModelViewSet):
    # モデルのオブジェクトを取得
    queryset = UserInfo.objects.all()
    # シリアライザーを取得
    serializer_class = UserInfoSerializer
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated, )

    # def list(self, request, *args, **kwargs):
    #     # GETメソッドを許可する
    #     return super().list(request, *args, **kwargs)

# class UserViewSet(viewsets.ModelViewSet):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer
#     authentication_classes = (TokenAuthentication,)
#     permission_classes = (IsAuthenticated, )







