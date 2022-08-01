// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/pages/userProfile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  static const routeName = '/log-in';

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool passObsecure = true;
  String error = '';
  bool isLogIn = true;
  final formkey = GlobalKey<FormState>();

  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset('images/R.png'),
              ),
              const SizedBox(height: 20),
              Text(
                'Log In As Mess Manager',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email_Controller,
                      cursorColor: Color(0xff63BF96),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: Color(0xff63BF96),
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xff63BF96),
                        ),
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: password_Controller,
                      obscureText: passObsecure,
                      cursorColor: Color(0xff63BF96),
                      style: TextStyle(
                          color: Color(0xff63BF96),
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        errorText: error,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff63BF96),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passObsecure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xff63BF96),
                          ),
                          onPressed: () {
                            setState(() {
                              passObsecure = !passObsecure;
                            });
                          },
                        ),
                        hintText: "Enter Password Password",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  isLogIn = true;
                  authenticate();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff63BF96),
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'New User? Register Here',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    isLogIn = false;
                    authenticate();
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.red),
              ),
            ],
          ),
        ),
      )),
    );
  }

  authenticate() async {
    if (formkey.currentState!.validate()) {
      bool status;
      try {
        if (isLogIn) {
          status = await AuthService.logIn(email_Controller.text, password_Controller.text);
        }
        else {
          status = await AuthService.register(email_Controller.text, password_Controller.text);
        }
        if (status) {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, UserProfilePage.routeName);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          error = e.message!;
        });
      }
    }
  }
}
