import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double? size, Color? clr, [FontWeight? fw]) {
  return GoogleFonts.nunito(
    fontSize: size,
    color: clr,
    fontWeight: fw,
  );
}

showInToast(String title) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: btnPrimary,
      textColor: btnTextColor,
      fontSize: 16.0);
}

//Light theme
Color lightScaffoldColor = const Color(0xFFEEF2F1);
Color lightCardColor = const Color(0xFFFfFFFf); //F0FFFF
Color lightBackgroundColor = Colors.white;
Color lightIconsColor = const Color(0xFF79A3B1);

//  Color lightTextColor = const Color(0xff324558);
//Dark theme
Color darkScaffoldColor = const Color(0xFF1A1A2E);
Color darkCardColor = Colors.black12;
Color darkBackgroundColor = Colors.black;
Color darkIconsColor = const Color(0xFFE94560);
Color blueColor = const Color(0xFF4B73CC);
Color secondaryColor = const Color(0xff292B3E);
Color primaryColor = const Color(0xff191A22);
Color txtColor1 = const Color(0xffE4E4E6);
Color txtColor2 = const Color(0xffE9E9EB);
Color txtColor3 = const Color(0xff8A8A8E);
Color btnPrimary = const Color(0xff246BFD);
Color btnTextColor = Color(0xffFFFFFF);
Color lblColor = Color(0xff292B3E);

//Another
Color bgClrPri = Color(0xff272B3B);

Color bgClrSec = Color(0xffF5F5F5);

Color bgClr1 = Color(0xffEAEBEC);

Color cntClr = Color(0xffFFFFFF);

Color contClr1 = Color(0xffE4E1DE);

Color btnClr = Color(0xffF87B36);

Color btnClr1 = Color(0xff2A2F43);
