import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'userdetailscreen.dart';

class UserInfoListScreen extends StatefulWidget {
  final String token;

  const UserInfoListScreen({Key? key, required this.token}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserInfoListScreenState createState() => _UserInfoListScreenState();
}

class _UserInfoListScreenState extends State<UserInfoListScreen> {
  late Future<List<dynamic>> _userInfoListFuture;

  @override
  void initState() {
    super.initState();
    _userInfoListFuture = _fetchUserInfoList();
  }

  Future<List<dynamic>> _fetchUserInfoList() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/v1/drf_test_app/'),
      headers: {'Authorization': 'Token ${widget.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes));
      return jsonData;
    } else {
      throw Exception('Failed to load user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザーリスト'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _userInfoListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<dynamic> userInfoList = snapshot.data!;
            return ListView.separated(
              itemCount: userInfoList.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final userInfo = userInfoList[index];
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${userInfo['username']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Email: ${userInfo['email']}'),
                        const SizedBox(height: 4),
                        Text('Age: ${userInfo['age'] ?? 'Unknown'}'),
                      ],
                    ),
                    leading: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('images/onepiece2.jfif'),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsScreen(userInfo: userInfo),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}




// class UserInfoListScreen extends StatefulWidget {
//   final String token;

//   const UserInfoListScreen({Key? key, required this.token}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _UserInfoListScreenState createState() => _UserInfoListScreenState();
// }

// class _UserInfoListScreenState extends State<UserInfoListScreen> {
//   late Future<List<dynamic>> _userInfoListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _userInfoListFuture = _fetchUserInfoList();
//   }

//   Future<List<dynamic>> _fetchUserInfoList() async {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8000/api/v1/drf_test_app/'),
//       headers: {'Authorization': 'Token ${widget.token}'},
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData =
//           json.decode(utf8.decode(response.bodyBytes));
//       return jsonData;
//     } else {
//       throw Exception('Failed to load user info');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ユーザーリスト'),
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: _userInfoListFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             final List<dynamic> userInfoList = snapshot.data!;
//             return ListView.builder(
//               itemCount: userInfoList.length,
//               itemBuilder: (context, index) {
//                 final userInfo = userInfoList[index];
//                 return ListTile(
//                   title: Text('User: ${userInfo['username']}'),
//                   subtitle: Text('Email: ${userInfo['email']}'),
//                   trailing: Text('age: ${userInfo['age']}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             UserDetailsScreen(userInfo: userInfo),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
