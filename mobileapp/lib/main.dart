import 'package:flutter/material.dart';
import 'database.dart';
import 'screens/introduction_screen.dart';
import 'util/widget_utils.dart';

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
        centerTitle: true,
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
                    subtitle: Text(
                      StringUtils.truncateText(userInfo.introduction, 10),
                    ),
                    trailing: Text(userInfo.age.toString()),
                    onTap: () {
                      // 画面遷移の処理を記述する
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              IntroductionScreen(userInfo: userInfo),
                        ),
                      );
                    },
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
