import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsi_124220018/screens/home_page.dart';
import 'package:responsi_124220018/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Future<void> _login() async {
      try {
        final String? username = await AuthService()
            .login(_usernameController.text, _passwordController.text);

        if (username!.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Login berhasil")));

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login gagal, email atau password salah: $e")));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username tidak boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Username")),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  return null;
                },
                controller: _passwordController,
                decoration: InputDecoration(label: Text("Password")),
              ),
              MaterialButton(
                onPressed: _login,
                color: Colors.orange,
                child: Text("Login"),
              )
            ],
          )),
    );
  }
}
