import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/auth/auth_function.dart';
import 'package:flutterchat/auth/database.dart';
import 'package:flutterchat/helper/constant.dart';
import 'package:flutterchat/view/chatroom_pages.dart';
import 'package:flutterchat/widget/widget.dart';

class SearchPages extends StatefulWidget {
  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  TextEditingController _searchController = new TextEditingController();

  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  QuerySnapshot searchResult;

  String myName;
  bool _isLoading = false;
  bool haveUserSearched = false;

  getUsername() async {
    myName = await SharedHelper.getUserName();
  }

  initiateSearch() async {
    if (_searchController.text.isNotEmpty) {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        _isLoading = true;
      });
      await dataBaseMethods.searchByName(_searchController.text).then((value) {
        searchResult = value;
        setState(() {
          _isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  createConversation(String username) async {
    if (username != myName) {
      String roomId = getChatRoomId(username, myName);

      List<String> users = [username, myName];

      Map<String, dynamic> chatMap = {
        "users": users,
        "chatroomId": roomId,
      };

      print("$roomId x $chatMap");

      await dataBaseMethods.createConversation(chatMap, roomId);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoomPages(
                    roomId: roomId,
                    sendBy: myName,
                    name: username,
                  )));
    } else {
      print("");
    }
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xfffefefe),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: "search username", border: InputBorder.none),
                )),
                InkWell(
                    onTap: () async {
                      initiateSearch();
                    },
                    child: Container(child: Icon(Icons.search)))
              ],
            ),
          ),
          _isLoading
              ? Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: isLoading(),
                  ),
                )
              : _listData()
        ],
      ),
    );
  }

  Widget _listData() {
    return haveUserSearched
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: searchResult.documents.length,
                itemBuilder: (context, index) {
                  if (searchResult.documents[index].data['name'] != myName) {
                    return ListTile(
                      title: Text(searchResult.documents[index].data['name']),
                      subtitle: Text(
                        searchResult.documents[index].data['email'],
                        style: smallTextStyle(context, Colors.black54),
                      ),
                      leading: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue),
                        child: Text(
                          searchResult.documents[index].data['name'][0]
                              .toString()
                              .toUpperCase(),
                          style: mediumTextStyle(context, Colors.white),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          print("this is room id" +
                              searchResult.documents[index].data['name']);
                          createConversation(
                              searchResult.documents[index].data['name']);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[200]),
                          child: Image.asset(
                            "images/bubble_chat.png",
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: Text("User not found"),
                    );
                  }
                }),
          )
        : Container();
  }
}
