import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';

Widget customButton(String buttonText, onTap) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: btnPrimary),
        child: Center(
            child: Text(
          buttonText,
          style: myStyle(26, btnTextColor, FontWeight.bold),
        )),
      ),
    ),
  );
}
