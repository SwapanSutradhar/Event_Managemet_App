import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/about_page.dart';
import 'package:my_project/screens/home_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentIndex = 0;
  final pages = [HomePage(), AboutPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: secondaryColor,
        elevation: 0.0,
        iconSize: 35,
        selectedItemColor: btnPrimary,
        unselectedItemColor: btnPrimary.withOpacity(0.3),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: ""),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
