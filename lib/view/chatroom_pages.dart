import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/auth/database.dart';
import 'package:flutterchat/helper/constant.dart';
import 'package:flutterchat/widget/widget.dart';
import 'package:intl/intl.dart';

class ChatRoomPages extends StatefulWidget {
  final String roomId;
  final String sendBy;
  final String name;

  ChatRoomPages({@required this.roomId, @required this.sendBy, @required this.name});

  @override
  _ChatRoomPagesState createState() => _ChatRoomPagesState();
}

class _ChatRoomPagesState extends State<ChatRoomPages> {
  TextEditingController _sendMessage = new TextEditingController();

  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  Stream<QuerySnapshot> chatMessages;

  sendMessage() async {
    if (_sendMessage.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "message": _sendMessage.text,
        "sendBy": widget.sendBy,
        "time": DateTime.now(),
      };

      dataBaseMethods.addMessages(widget.roomId, message);
      _sendMessage.clear();
    }
  }

  @override
  void initState() {
    dataBaseMethods.getMessages(widget.roomId).then((value) {
      chatMessages = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getUpperCase(widget.name)),
      ),
      body: Column(
        children: [
          Expanded(child: _listChat()),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xfffefefe),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _sendMessage,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff81D4FA),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset(
                      "images/send.png",
                      scale: 2.5,
                      color: Color(0xfffefefe),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listChat() {
    return StreamBuilder(
        stream: chatMessages,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _chatBubble(
                        snapshot.data.documents[index].data['message'],
                        snapshot.data.documents[index].data['sendBy'] ==
                            widget.sendBy,
                        snapshot.data.documents[index].data['time'].toDate());
                  })
              : Container();
        });
  }

  //Todo diff room id

  Widget _chatBubble(String chat, bool sendByMe, DateTime date) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
          margin: EdgeInsets.only(top: 16, bottom: 6),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: sendByMe
                      ? [const Color(0xffBBDEFB), const Color(0xffBBDEFB)]
                      : [const Color(0xff9E9E9E), const Color(0xff9E9E9E)],
                ),
                borderRadius: sendByMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))
                    : BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
            child: Text(
              chat,
              textAlign: TextAlign.justify,
              style: mediumTextStyle(
                  context, sendByMe ? Colors.black : Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(
              left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(DateFormat.jm().format(date)),
        )
      ],
    );
  }
}
