import 'package:flutter/material.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserInfoScreen(),
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late Future<List<UserInfo>> _futureUserInfos;

  @override
  void initState() {
    super.initState();
    _futureUserInfos = fetchUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザーリスト'),
      ),
      body: Center(
        child: FutureBuilder<List<UserInfo>>(
          future: _futureUserInfos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final userInfo = snapshot.data![index];
                  return ListTile(
                    title: Text(userInfo.userName),
                    subtitle: Text(userInfo.introduction),
                    trailing: Text(userInfo.age.toString()),
                    leading: Text(userInfo.createdAt),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
