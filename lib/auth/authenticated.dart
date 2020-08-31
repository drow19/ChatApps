import 'package:flutter/material.dart';
import 'package:flutterchat/view/login_pages.dart';
import 'package:flutterchat/view/register_pages.dart';

class Authenticated extends StatefulWidget {
  @override
  _AuthenticatedState createState() => _AuthenticatedState();
}

class _AuthenticatedState extends State<Authenticated> {

  bool _isLogged = true;

  void switchView(){
    setState(() {
      _isLogged = !_isLogged;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_isLogged){
      return LoginPages(switchView: switchView);
    }else{
      return RegisterPages(switchView: switchView);
    }
  }
}
