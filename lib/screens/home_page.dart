import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/login/splash.dart';
import 'package:my_project/screens/ui/photography/photo_home.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/my_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.sort,
              size: 30,
              color: btnPrimary,
            )),
        centerTitle: true,
        title: Text(
          "Home Page",
          style: myStyle(35, btnPrimary, FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyPage()));
              },
              icon: Icon(
                Icons.home,
                size: 30,
                color: btnPrimary,
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your\n   Category',
              style: myStyle(32, btnTextColor, FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            customButton("Venue", () {}),
            SizedBox(
              height: 20,
            ),
            customButton("Photography", () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PhotographyHome()));
            }),
            SizedBox(
              height: 20,
            ),
            customButton("Sound System", () {}),
            SizedBox(
              height: 20,
            ),
            customButton("Catering", () {}),
            SizedBox(
              height: 20,
            ),
            customButton("Decorator", () {}),
          ],
        ),
      ),
    );
  }
}
