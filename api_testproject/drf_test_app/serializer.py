from rest_framework import serializers
from .models import UserInfo

# UserInfoモデルのフィールドをJSON形式でシリアライズするための設定
class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        # json で出力するフィールド
        fields = "__all__"