import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/constant/style.dart';
import 'package:my_project/screens/login/sign_up.dart';
import 'package:my_project/screens/login/splash.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_textfield.dart';
import 'package:my_project/widgets/my_pages.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool isObsecure = true;

  signIn(email, password) async {
    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? _authCredential = _userCredential.user;
      if (_authCredential!.uid.isNotEmpty) {
        // return 'Data added';
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => MyPage()));
        showInToast('Welcome to Home!');
      } else {
        showInToast('Something is wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        showInToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        showInToast("Wrong password provided for that user.");
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
              'Welcome Back!',
              style: myStyle(40, btnTextColor, FontWeight.bold),
            ),
            top: 180,
            left: 50,
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
                    customButton("Sign In", () {
                      if (_formkey.currentState!.validate()) {
                        signIn(_emailController.text, _passwordController.text);
                      } else {
                        showInToast("Enter all fields");
                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: myStyle(22, btnTextColor, FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Registration()));
                            },
                            child: Text(
                              'Sign Up',
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
            top: 300,
          ),
        ],
      ),
    );
  }
}
