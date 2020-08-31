import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

//three dots menu
class Constants {
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    SignOut,
  ];
}

//create chatroom id
getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

//chat time
String formatTimestamp(int timestamp) {
  var format = new DateFormat('d MMM, hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

//chat time using time ago (ex: 1 min ago)
getTime(DateTime date) {
  Timestamp timestamp = Timestamp.fromDate(date);
  timeago.setLocaleMessages('en', timeago.EnMessages());
  return timeago
      .format(DateTime.tryParse(timestamp.toDate().toString()))
      .toString();
}

//capitalize first letter of username
getUpperCase(String letter){
  return letter.capitalize();
}

//extension for capitalize letter
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}