// ignore_for_file: constant_identifier_names, unused_field, prefer_final_fields, unused_local_variable, avoid_print, prefer_const_constructors, unused_element, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, annotate_overrides, unnecessary_brace_in_string_interps, await_only_futures

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_me/screens/home.dart';
import 'package:test_me/utils/app_color.dart';
import 'package:test_me/widgets/custom_back_button.dart';
import 'package:test_me/widgets/custom_button.dart';
import 'package:test_me/widgets/custom_textfield.dart';

enum Gender { Male, Female }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
  // State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Gender? _gender = Gender.Male;

  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _mobileEditingController = TextEditingController();
  bool isLoading = false;

  Future signUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailEditingController.text,
              password: _passwordEditingController.text);
      if (userCredential.user != null) {
        createUser();
        Route route = MaterialPageRoute(builder: (ctx) => HomeScreen());
        Navigator.push(context, route);
      }
    } catch (err) {
      print(err);
    }

    setState(() {
      isLoading = false;
    });
  }

  var imagePath;
  Future pickedImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      setState(() {
        imagePath = File(image.path);
        print("Image: $imagePath");
        uploadProfileImage();
      });
    }
  }

  var imageUrl;

  Future uploadProfileImage() async {
    String image = imagePath.toString();
    var _image = image.split("/")[6];
    Reference reference =
        FirebaseStorage.instance.ref().child("ProfileImage/${_image}");
    UploadTask uploadTask = reference.putFile(imagePath);

    TaskSnapshot snapshot = await uploadTask;
    var _imageUrl;
    _imageUrl = await snapshot.ref.getDownloadURL();
    if (_imageUrl != null) {
      setState(() {
        imageUrl = _imageUrl;
        print("imageUrl: $imageUrl");
      });
    }
  }

  Future createUser() async {
    CollectionReference users =
        await FirebaseFirestore.instance.collection("users");
    try {
      users
          .add({
            "name": _nameEditingController.text,
            "email": _emailEditingController.text,
            "mobile": _mobileEditingController.text,
            "gender": _gender!.index.toString(),
            "image": imageUrl.toString(),
          })
          .then((value) => print("Sucessfully created user"))
          .catchError((err) => print("$err"));
    } catch (err) {
      print("$err");
    }
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
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: AppColor.secondaryColor,
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      imagePath == null
                          ? CircleAvatar(
                              radius: 36,
                              backgroundImage:
                                  AssetImage("assets/image/profile.jpg"),
                            )
                          : CircleAvatar(
                              radius: 36,
                              backgroundImage: FileImage(imagePath),
                            ),
                      Transform.translate(
                        offset: Offset(-20, 45),
                        child: ElevatedButton(
                          onPressed: () {
                            pickedImageFromCamera();
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 102),
                CustomTextField(
                  controller: _nameEditingController,
                  hintText: "Name",
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller: _emailEditingController,
                  hintText: "Email",
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller: _passwordEditingController,
                  obscureText: true,
                  hintText: "Password",
                  suffixIcon: Icon(Icons.visibility),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller: _mobileEditingController,
                  hintText: "Enter Mobile Number",
                ),
                SizedBox(height: 14),
                Text(
                  "Gender",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: AppColor.secondaryColor),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        Radio(
                          value: Gender.Male,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Text(
                      "Female",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Radio(
                      value: Gender.Female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ],
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onTap: () {
                          signUp();
                        },
                        color: AppColor.secondaryColor,
                        levelColor: AppColor.primaryColor,
                        buttonLevel: "Sign up",
                      ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Login",
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
