import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.Controller,
    this.keyBoardType,
    this.labelText,
    this.icon,
    this.prefixIcon,
    this.hintText,
    this.suffixIcon,
    this.msg,
  }) : super(key: key);

  final TextEditingController Controller;
  final TextInputType? keyBoardType;
  final String? labelText;
  final IconData? icon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          showInToast(msg!);
        }
      },
      controller: Controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: btnPrimary),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: btnPrimary),
          borderRadius: BorderRadius.circular(40),
        ),
        hintStyle: myStyle(20, btnTextColor.withOpacity(0.5)),
        labelStyle: myStyle(20, btnPrimary, FontWeight.bold),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
          size: 26,
          color: btnTextColor.withOpacity(0.7),
        ),
        suffixIcon: Icon(
          suffixIcon,
          size: 26,
          color: btnTextColor,
        ),
      ),
      style: myStyle(24, contClr1),
    );
  }
}
