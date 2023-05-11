from rest_framework import serializers
from .models import UserInfo

# UserInfoモデルのフィールドをJSON形式でシリアライズするための設定
class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        # json で出力するフィールド
        fields = ('id','user_name', 'introduction','birth_day','age','created_at')