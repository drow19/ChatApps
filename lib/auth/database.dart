import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {

  //create user
  createUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  //get user info
  getUserInfo(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  //get user email
  getUserEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  //search user by username
  searchByName(String search){
    return Firestore.instance
        .collection("users")
        .where("name", isEqualTo: search)
        .getDocuments();
  }

  //create chatroom
  Future<bool> createConversation(chat, roomId) {
    Firestore.instance
        .collection("conversation")
        .document(roomId)
        .setData(chat)
        .catchError((e) {
      print(e.toString());
    });
  }

  //send message in chatroom
  addMessages(String roomId, message) {
    Firestore.instance
        .collection('conversation')
        .document(roomId)
        .collection('chat')
        .add(message)
        .catchError((e) {
      print(e.toString());
    });
  }

  //get message from other users
  getMessages(String roomId) async {
    return Firestore.instance
        .collection('conversation')
        .document(roomId)
        .collection('chat')
        .orderBy("time")
        .snapshots();
  }

  //get list chatrooms
  getUserChat(String username) async {
    return await Firestore.instance
        .collection('conversation')
        .where('users', arrayContains: username)
        .snapshots();
  }
}
