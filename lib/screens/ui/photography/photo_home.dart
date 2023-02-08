import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/home_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PhotographyHome extends StatefulWidget {
  const PhotographyHome({super.key});

  @override
  State<PhotographyHome> createState() => _PhotographyHomeState();
}

class _PhotographyHomeState extends State<PhotographyHome> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('photography').snapshots();
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('photography').snapshots();
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Icon(
            Icons.home,
            size: 30,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Photography",
          style: myStyle(35, Colors.blue, FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.more_vert_outlined,
            size: 30,
            color: Colors.blue,
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading"),
                      ],
                    ));
                  }

                  return ListView(
                    scrollDirection: Axis.vertical,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 3.0),
                            borderRadius: BorderRadius.circular(24)),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                data['img'],
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 20,
                              child: Container(
                                child: Text(
                                  data['title'],
                                  style:
                                      myStyle(30, txtColor2, FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              right: 55,
                              child: Container(
                                child: Text(
                                  '⭐',
                                  style:
                                      myStyle(20, txtColor2, FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: Container(
                                child: Text(
                                  data['rating'],
                                  style:
                                      myStyle(22, txtColor2, FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
