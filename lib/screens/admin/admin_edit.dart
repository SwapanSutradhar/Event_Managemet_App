import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/admin/admin_home.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_textfield.dart';

class AdminEdit extends StatefulWidget {
  String documentId;
  String title;
  String rating;
  String img;
  AdminEdit(this.documentId, this.title, this.rating, this.img);
  @override
  State<AdminEdit> createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  bool obscureText = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.title;
    _ratingController.text = widget.rating;
    _imgUrl = widget.img;
  }

  XFile? _photoImage;
  String? _imgUrl;
  chooseImageFromCG() async {
    ImagePicker _picker = ImagePicker();
    _photoImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  updateData() async {
    CollectionReference _photoItems =
        await FirebaseFirestore.instance.collection('photography');
    _photoItems.doc(widget.documentId).update({
      'title': _titleController.text,
      'rating': _ratingController.text,
      'img': _imgUrl
    }).then((value) => print('updated'));
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
                      Navigator.of(context).push(MaterialPageRoute(
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
              'Edit New Item!',
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
                  'Edit Title & Rating:',
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
                  'Edit Image:',
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
                          ? Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.img,
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        chooseImageFromCG();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 35,
                                        color: Colors.green,
                                      )))
                            ])
                          : Image.file(
                              File(_photoImage!.path),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                customButton("Update Item", () {
                  updateData();
                  Fluttertoast.showToast(msg: 'Data Updated Successfully!');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminHomePage()));
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
