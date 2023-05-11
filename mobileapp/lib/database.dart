import 'dart:convert';
import 'package:http/http.dart' as http;

class UserInfo {
  final int id;
  final String userName;
  final String birthDay;
  final int age;
  final String introduction;
  final String createdAt;

  UserInfo({
    required this.id,
    required this.userName,
    required this.birthDay,
    required this.age,
    required this.introduction,
    required this.createdAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      userName: json['user_name'],
      birthDay: json['birth_day'],
      age: json['age'],
      introduction: json['introduction'],
      createdAt: json['created_at'],
    );
  }
}

Future<List<UserInfo>> fetchUserInfos() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/api/userInfo/'));
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => UserInfo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load user infos');
  }
}
