import 'package:flutter/material.dart';
import '../database/database.dart';
import '../util/widget_utils.dart';

class IntroductionScreen extends StatelessWidget {
  final UserInfo userInfo;

  const IntroductionScreen({Key? key, required this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ユーザー情報'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUserInfoText('名前', userInfo.userName),
              buildUserInfoText('誕生日', userInfo.birthDay),
              buildUserInfoText('年齢', userInfo.age.toString()),
              buildUserInfoText('自己紹介', userInfo.introduction),
            ],
          ),
        ),
      ),
    );
  }
}
