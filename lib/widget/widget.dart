import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarStyle(BuildContext context) {
  return AppBar(
    title: Text('FlutterChat'),
    backgroundColor: Color(0xff00AFF0),
  );
}

InputDecoration textFieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  );
}

Widget loginWithGoogle(BuildContext context) {
  return RichText(
      text: TextSpan(
          text: "G",
          style: GoogleFonts.averiaSerifLibre(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.blue),
          children: [
            TextSpan(
              text: "o",
              style: GoogleFonts.averiaSerifLibre(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.red),
            ),
            TextSpan(
              text: "o",
              style: GoogleFonts.averiaSerifLibre(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.yellow),
            ),
            TextSpan(
              text: "g",
              style: GoogleFonts.averiaSerifLibre(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue),
            ),
            TextSpan(
              text: "l",
              style: GoogleFonts.averiaSerifLibre(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.green),
            ),
            TextSpan(
              text: "e",
              style: GoogleFonts.averiaSerifLibre(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.red),
            ),
          ]));
}

TextStyle textFieldStyle(BuildContext context) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black);
}

TextStyle smallTextStyle(BuildContext context, Color colors) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colors);
}

TextStyle mediumTextStyle(BuildContext context, Color colors) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: colors);
}

TextStyle biggerTextStyle(BuildContext context, Color colors) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: colors);
}

Widget isLoading() {
  return Center(
    child: Container(
      child: CircularProgressIndicator(),
    ),
  );
}
