import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/login/admin_login.dart';
import 'package:my_project/screens/login/sign_in.dart';
import 'package:my_project/screens/login/sign_up.dart';
import 'package:my_project/widgets/custom_button.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Event\n    Management\n     Application',
              style: myStyle(40, btnTextColor, FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            customButton("User Login", () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            }),
            SizedBox(
              height: 30,
            ),
            customButton("Admin Login", () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AdminLogin()));
            }),
          ],
        ),
      ),
    );
  }
}
