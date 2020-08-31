import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterchat/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //authentication with firebase
  User _user(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future loginWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser firebaseUser = result.user;
      return _user(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  //authentication with google
  Future<FirebaseUser> loginWithGoogle(BuildContext context) async {
    final GoogleSignIn _google = new GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await _google.signOut();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser userDetail = result.user;

   if(result == null){
     print(userDetail.toString() + " " + result.toString());
   }else{
     print(userDetail.toString() + " " + result.toString());
   }
  }

  Future registerWithEmail(String email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser firebaseUser = result.user;
      return _user(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
