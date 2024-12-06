import 'package:flutter/material.dart';
import 'package:responsi_124220018/screens/home_page.dart';
import 'package:responsi_124220018/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CheckLogin(),
    );
  }
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool _isLoggedIn = false;

  Future<void> isLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if ((prefs.getString('username') ?? '').isNotEmpty) {
        setState(() {
          _isLoggedIn = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoggedIn = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? HomePage() : LoginPage();
  }
}
