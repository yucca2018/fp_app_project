from django.db import models
from django.contrib.auth.models import (BaseUserManager, AbstractBaseUser, PermissionsMixin)
from django.utils.translation import gettext_lazy as _

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created and instance is not None:
        Token.objects.create(user=instance)


class UserManager(BaseUserManager):
    def _create_user(self, email, username, password, **extra_fields):
        email = self.normalize_email(email)
        user = self.model(email=email, username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        user.full_clean()

        Token.objects.update_or_create(user=user)


        return user

    def create_user(self, email, username, password=None, **extra_fields):
        extra_fields.setdefault('is_active', True)
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(
            email=email,
            username=username,
            password=password,
            **extra_fields,
        )

    def create_superuser(self, email, username, password, **extra_fields):
        extra_fields['is_active'] = True
        extra_fields['is_staff'] = True
        extra_fields['is_superuser'] = True
        return self._create_user(
            email=email,
            username=username,
            password=password,
            **extra_fields,
        )

class UserInfo(AbstractBaseUser, PermissionsMixin):

    username = models.CharField(
        verbose_name=_("username"),
        unique=True,
        max_length=150
    )
    email = models.EmailField(
        verbose_name=_("Email Adress"),
        unique=True
    )
    age = models.IntegerField(
        verbose_name=_("age"),
        null=True,
        blank=True
    )
    birthday = models.DateField(
        verbose_name=_("birthday"),
        null=True,
        default='1900-01-01'
    )
    introduction = models.TextField(
        verbose_name=_("introduction"),
        default='introduction'
    )
    is_superuser = models.BooleanField(
        verbose_name=_("is_superuer"),
        default=False
    )
    is_staff = models.BooleanField(
        _('staff status'),
        default=False,
    )
    is_active = models.BooleanField(
        _('active'),
        default=True,
    )

    objects = UserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']

    def __str__(self):
        return self.username


# # ユーザ情報を格納する
# class UserInfo(models.Model):
#     user_name = models.CharField(verbose_name='ユーザ名',max_length=32)
#     birth_day = models.DateField(verbose_name='生年月日')
#     age = models.PositiveSmallIntegerField(verbose_name='年齢',null=True,unique=False)
#     introduction = models.TextField(verbose_name='自己紹介')
#     created_at = models.DateTimeField(verbose_name='作成日時',auto_now_add=True)

#     #管理者ページに表示させる項目
#     def __str__(self):
#         return f"{self.user_name}({self.age})"
