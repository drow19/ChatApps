import 'package:flutter/material.dart';
import 'package:flutterchat/auth/auth_function.dart';
import 'package:flutterchat/auth/authenticated.dart';
import 'package:flutterchat/view/home_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLogin;

  getLoginState() async {
    await SharedHelper.getUserLogin().then((value) {
      setState(() {
        _isLogin = value;
      });
    });
  }

  @override
  void initState() {
    getLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffEEEEEE),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _isLogin != null
          ? _isLogin ? HomePages() : Authenticated() /*double condition*/
          : Authenticated(),
      debugShowCheckedModeBanner: false,
    );
  }
}
