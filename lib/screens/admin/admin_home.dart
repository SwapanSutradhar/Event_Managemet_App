import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/admin/admin_add.dart';
import 'package:my_project/screens/admin/admin_edit.dart';
import 'package:my_project/screens/login/admin_login.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('photography').snapshots();
  Future<dynamic> deleteItem(selectedItem) {
    return FirebaseFirestore.instance
        .collection('photography')
        .doc(selectedItem)
        .delete()
        .then((value) => print('Item data is deleted'));
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('photography').snapshots();
    return Scaffold(
      backgroundColor: bgClrPri,
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: myStyle(20, Colors.white.withOpacity(0.9),
                                FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 25,
                            color: Colors.green,
                          ),
                          Text(
                            'Admin',
                            style: myStyle(30, Colors.white.withOpacity(0.9),
                                FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AdminAdd()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: btnPrimary,
                            ),
                            child: Text(
                              'Add',
                              style: myStyle(18, Colors.white, FontWeight.bold),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => AdminLogin()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: btnPrimary,
                            ),
                            child: Text(
                              'Back',
                              style: myStyle(18, Colors.white, FontWeight.bold),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.80,
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
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: data == context ? bgClrPri : bgClrSec,
                              border:
                                  Border.all(color: btnPrimary, width: 3.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            data['img'],
                                            fit: BoxFit.cover,
                                            width: 140,
                                            height: 140,
                                          ),
                                        ),
                                        Text(
                                          data['title'],
                                          style: myStyle(24, Colors.black,
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '⭐',
                                        style: myStyle(
                                            20, Colors.black, FontWeight.bold),
                                      ),
                                      Text(
                                        data['rating'],
                                        style: myStyle(
                                            22, Colors.black, FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => AdminEdit(
                                                    document.id,
                                                    data['title'],
                                                    data['rating'],
                                                    data['img'])));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 28,
                                        color: Colors.green,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Delete Item",
                                                  style: myStyle(
                                                      22,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                content: Text(
                                                  "Are you sure want to delete?",
                                                  style: myStyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            deleteItem(
                                                                document.id);
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Item data is deleted');
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                color: Colors
                                                                    .green),
                                                            child: Text(
                                                              'Yes',
                                                              style: myStyle(
                                                                  14,
                                                                  Colors.white,
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              color: Colors.red,
                                                            ),
                                                            child: Text(
                                                              'No',
                                                              style: myStyle(
                                                                  14,
                                                                  Colors.white,
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 28,
                                        color: Colors.red,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
