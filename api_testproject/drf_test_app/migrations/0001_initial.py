# Generated by Django 4.0.2 on 2023-05-10 01:11

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='UserInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_name', models.CharField(max_length=32, verbose_name='ユーザ名')),
                ('birth_day', models.DateField(verbose_name='生年月日')),
                ('age', models.PositiveSmallIntegerField(null=True, verbose_name='年齢')),
                ('introduction', models.TextField(verbose_name='自己紹介')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='作成日時')),
            ],
        ),
    ]