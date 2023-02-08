import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/admin/admin_home.dart';
import 'package:my_project/screens/login/splash.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_textfield.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;
  void clearText() {
    _nameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: bgClrPri,
          ),
          Positioned(
            child: Image.network(
              "https://cdn.pixabay.com/photo/2015/05/31/15/02/bokeh-792083__340.jpg",
              fit: BoxFit.cover,
            ),
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
          ),
          Positioned(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SpashScreen()));
              },
              icon: Icon(
                Icons.home,
                size: 35,
                color: btnPrimary,
              ),
            ),
            top: 40,
            right: 20,
          ),
          Positioned(
            child: Text(
              'Admin Login!',
              style: myStyle(40, Colors.white, FontWeight.bold),
            ),
            top: 200,
            left: 70,
          ),
          Positioned(
            // ignore: sort_child_properties_last
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  Controller: _nameController,
                  hintText: "Enter your name",
                  labelText: "Name",
                  prefixIcon: Icons.person,
                  msg: "Name is required",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      showInToast("Password is required");
                    }
                  },
                  obscureText: isObsecure,
                  obscuringCharacter: '*',
                  style: myStyle(24, contClr1),
                  controller: _passwordController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: btnPrimary),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: btnPrimary),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintStyle: myStyle(20, btnTextColor.withOpacity(0.5)),
                      labelStyle: myStyle(20, btnPrimary, FontWeight.bold),
                      hintText: "Enter your password",
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 26,
                        color: btnTextColor.withOpacity(0.7),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon: Icon(isObsecure == false
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: isObsecure == false ? Colors.green : Colors.red,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                customButton("Log In", () {
                  if (_nameController.text == 'swapan' &&
                      _passwordController.text == '1234') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminHomePage()));
                    Fluttertoast.showToast(msg: 'Admin Login Successfull!');
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Incorrect username & password');
                  }
                  this.setState(() {
                    _nameController.clear();
                    _passwordController.clear();
                  });
                })
              ],
            ),
            right: 20,
            left: 20,
            top: 320,
          ),
        ],
      ),
    );
  }
}
