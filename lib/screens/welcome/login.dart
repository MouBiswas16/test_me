// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_me/screens/home.dart';
import 'package:test_me/utils/app_color.dart';
import 'package:test_me/widgets/custom_back_button.dart';
import 'package:test_me/widgets/custom_button.dart';
import 'package:test_me/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  Future signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
      );
      if (userCredential.user != null) {
        // print("ass");
        Route route = MaterialPageRoute(builder: (ctx) => HomeScreen());
        Navigator.push(context, route);
      }
    } catch (err) {
      const snackBar = SnackBar(
        content: Text("You are not a registered user"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.primaryColor,
          leadingWidth: 100,
          leading: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: AppColor.secondaryColor,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Enter you email address and password to acess to your account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColor.secondaryColor,
                  ),
                ),
                SizedBox(height: 102),
                CustomTextField(
                  controller: _emailEditingController,
                  hintText: "Email",
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller: _passwordEditingController,
                  obscureText: true,
                  hintText: "Password",
                  suffixIcon: Icon(
                    Icons.visibility,
                  ),
                ),
                SizedBox(height: 59),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onTap: () {
                          signIn();
                        },
                        color: AppColor.secondaryColor,
                        levelColor: AppColor.primaryColor,
                        buttonLevel: "Login",
                      ),
                // Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have any account?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
