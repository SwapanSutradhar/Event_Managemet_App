import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/admin/admin_home.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_textfield.dart';

class AdminAdd extends StatefulWidget {
  const AdminAdd({super.key});

  @override
  State<AdminAdd> createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  bool obscureText = true;
  XFile? _photoImage;
  String? _imgUrl;
  chooseImageFromCG() async {
    ImagePicker _picker = ImagePicker();
    _photoImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  sendData() async {
    File _imageFile = File(_photoImage!.path);
    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask _uploadTask = _storage
        .ref('photography')
        .child(_photoImage!.name)
        .putFile(_imageFile);
    TaskSnapshot _snapShot = await _uploadTask;
    _imgUrl = await _snapShot.ref.getDownloadURL();
    CollectionReference _photoItems =
        await FirebaseFirestore.instance.collection('photography');

    _photoItems.add(({
      'title': _titleController.text,
      'rating': _ratingController.text,
      'img': _imgUrl,
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr1,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: bgClrPri,
          ),
          Positioned(
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AdminHomePage()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            ),
            left: 10,
            top: 40,
          ),
          Positioned(
            child: Text(
              'Add New Item!',
              style: myStyle(40, Colors.white, FontWeight.bold),
            ),
            top: 120,
            left: 20,
          ),
          Positioned(
            // ignore: sort_child_properties_last
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Title & Rating:',
                  style: myStyle(30, contClr1, FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  Controller: _titleController,
                  hintText: "Enter Title",
                  labelText: "Title",
                  prefixIcon: Icons.title,
                  msg: "Title is required",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  Controller: _ratingController,
                  hintText: "Enter Rating",
                  labelText: "Rating",
                  prefixIcon: Icons.star,
                  msg: "Rating is required",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Image:',
                  style: myStyle(30, contClr1, FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        border: Border.all(color: btnPrimary, width: 3)),
                    child: Center(
                      child: _photoImage == null
                          ? IconButton(
                              onPressed: () {
                                chooseImageFromCG();
                              },
                              icon: Icon(
                                Icons.camera,
                                size: 35,
                                color: btnPrimary,
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(_photoImage!.path),
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                customButton("Add Item", () {
                  if (_titleController.text.isEmpty && _imgUrl == null) {
                    Fluttertoast.showToast(msg: 'Field is empty');
                  } else {
                    sendData();
                    Fluttertoast.showToast(msg: 'Data Added Successfully!');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminHomePage()));
                  }
                })
              ],
            ),
            right: 20,
            left: 20,
            top: 200,
          ),
        ],
      ),
    );
  }
}
