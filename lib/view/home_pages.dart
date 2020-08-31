import 'package:flutter/material.dart';
import 'package:flutterchat/auth/auth_function.dart';
import 'package:flutterchat/auth/authenticated.dart';
import 'package:flutterchat/auth/database.dart';
import 'package:flutterchat/auth/firebaseAuth.dart';
import 'package:flutterchat/helper/constant.dart';
import 'package:flutterchat/view/chatroom_pages.dart';
import 'package:flutterchat/view/search_pages.dart';
import 'package:flutterchat/widget/widget.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  FireBaseAuthMethods _fireBaseAuthMethods = new FireBaseAuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  String myName;
  Stream chatRooms;

  getChats() async {
    myName = await SharedHelper.getUserName();

    dataBaseMethods.getUserChat(myName).then((value) {
      setState(() {
        print(
            "yeay data + ${chatRooms.toString()} this is name  ${myName}");
        chatRooms = value;
      });
    });
  }

  @override
  void initState() {
    this.getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterChat"),
        backgroundColor: Color(0xff00AFF0),
        actions: [
          PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext ctx) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              })
        ],
      ),
      body: _listMessage(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchPages()));
          }),
    );
  }

  Widget _listMessage() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return _messageTile(
                        snapshot.data.documents[index].data['chatroomId']
                            .replaceAll("_", "")
                            .replaceAll(myName, ""),
                        snapshot.data.documents[index].data['chatroomId']);
                  })
              : Container();
        } else {
          print(snapshot.hasError.toString());
          return Container();
        }
      },
    );
  }

  Widget _messageTile(String name, String roomId) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatRoomPages(
                          roomId: roomId,
                          sendBy: myName,
                          name: name,
                        )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: ListTile(
              title: Text(name),
              leading: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue),
                child: Text(
                  name[0].toUpperCase(),
                  style: mediumTextStyle(context, Colors.white),
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
        )
      ],
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.SignOut) {
      _fireBaseAuthMethods.logout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Authenticated()));
    } else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }
}
