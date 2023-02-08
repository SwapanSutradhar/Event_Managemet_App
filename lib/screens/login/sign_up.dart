import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/login/sign_in.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_textfield.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool isObsecure = true;

  signUp(email, password) async {
    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? _authCredential = _userCredential.user;
      if (_authCredential!.uid.isNotEmpty) {
        // return 'Data added';
        showInToast('Congratulation! Your account has been created');
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else {
        showInToast('Something is wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        showInToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showInToast('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var isObsecure = true;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: primaryColor,
          ),
          Positioned(
            child: Image.network("https://wallpapercave.com/wp/wp2894132.jpg"),
            top: 0,
            left: 0,
          ),
          Positioned(
            child: Text(
              'Welcome Buddy!',
              style: myStyle(40, btnTextColor, FontWeight.bold),
            ),
            top: 150,
            left: 40,
          ),
          Positioned(
            // ignore: sort_child_properties_last
            child: Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // ignore: sort_child_properties_last
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      Controller: _nameController,
                      hintText: "Enter your name",
                      labelText: "Name",
                      prefixIcon: Icons.person_add,
                      msg: "Name is required",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      Controller: _emailController,
                      hintText: "Enter your email",
                      labelText: "Email",
                      prefixIcon: Icons.email,
                      msg: "Email is required",
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
                            color:
                                isObsecure == false ? Colors.green : Colors.red,
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customButton("Sign Up", () {
                      if (_formkey.currentState!.validate()) {
                        signUp(_emailController.text, _passwordController.text);
                      } else {
                        showInToast("Enter all fields");
                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Alrady have an account!',
                          style: myStyle(22, btnTextColor, FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              'Sign In',
                              style: myStyle(22, btnPrimary),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            right: 10,
            left: 10,
            top: 270,
          ),
        ],
      ),
    );
  }
}
