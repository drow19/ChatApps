import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/auth/auth_function.dart';
import 'package:flutterchat/auth/database.dart';
import 'package:flutterchat/auth/firebaseAuth.dart';
import 'package:flutterchat/view/home_pages.dart';
import 'package:flutterchat/widget/widget.dart';

class LoginPages extends StatefulWidget {
  final Function switchView;

  LoginPages({this.switchView});

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  FireBaseAuthMethods fireBaseAuthMethod = new FireBaseAuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  QuerySnapshot querySnapshot;

  login() async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await fireBaseAuthMethod
          .loginWithEmail(_emailController.text, _passwordController.text)
          .then((value) async {
        if (value != null) {
          await dataBaseMethods
              .getUserEmail(_emailController.text)
              .then((value) {
            querySnapshot = value;
            SharedHelper.setUserName(querySnapshot.documents[0].data['name']);
            SharedHelper.setUserEmail(querySnapshot.documents[0].data['email']);
            SharedHelper.setUserLogin(true);
          });

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePages()));
        } else {
          setState(() {
            _isLoading = false;
            final snackbar = SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color(0xff00AFF0),
                duration: Duration(seconds: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                content: Text(
                  "The email address is already in use by another account",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xfffefefe),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ));
            scaffoldKey.currentState.showSnackBar(snackbar);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _isLoading
          ? isLoading()
          : Container(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)
                                  ? null
                                  : "Incorrect email";
                            },
                            controller: _emailController,
                            style: textFieldStyle(context),
                            decoration: textFieldDecoration("Email"),
                            maxLines: 1,
                            minLines: 1,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Password must not empty";
                              } else if (value.length < 6) {
                                return "Password must 6 character or more";
                              } else {
                                return null;
                              }
                            },
                            controller: _passwordController,
                            obscureText: true,
                            decoration: textFieldDecoration("Password"),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Forgot Password ?',
                          style: mediumTextStyle(context, Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        login();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff29B6F6),
                              Color(0xff81D4FA),
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Login",
                          style: biggerTextStyle(context, Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        fireBaseAuthMethod.loginWithGoogle(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffFAFAFA),
                              Color(0xfffefefe),
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login With ",
                              style: mediumTextStyle(context, Colors.black),
                            ),
                            loginWithGoogle(context)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account? ",
                            style: mediumTextStyle(context, Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.switchView();
                            },
                            child: Text(
                              "Register now",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
