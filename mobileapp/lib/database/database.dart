import 'dart:convert';
import 'package:http/http.dart' as http;

class UserInfo {
  final int id;
  final String userName;
  final String password;
  final String birthDay;
  final int age;
  final String introduction;

  UserInfo({
    required this.id,
    required this.userName,
    required this.password,
    required this.birthDay,
    required this.age,
    required this.introduction,
  });

// jsonオブジェクトデータをUserInfoオブジェクトに変換
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      userName: json['user_name'],
      password: json['password'],
      birthDay: json['birth_day'],
      age: json['age'],
      introduction: json['introduction'],
    );
  }
}

//非同期処理で実行し、jsonデータをデコードしUserInfoリストに格納
Future<List<UserInfo>> fetchUserInfos() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/drf_test_app/'));
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => UserInfo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load user infos');
  }
}
