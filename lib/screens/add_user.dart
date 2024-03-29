// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:test_me/utils/app_color.dart';
import 'package:test_me/widgets/custom_button.dart';
import 'package:test_me/widgets/custom_textfield.dart';

// ignore: constant_identifier_names
enum Gender { Male, Female }

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  Gender? _gender = Gender.Male;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          title: Text(
            "Add New User",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage("assets/image/profile.jpg"),
                      ),
                      Transform.translate(
                        offset: Offset(-20, 45),
                        child: ElevatedButton(
                          onPressed: () {},
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
                  hintText: "Enter Mobile Number",
                ),
                SizedBox(height: 14),
                Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: AppColor.secondaryColor,
                  ),
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
                    SizedBox(width: 43),
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
                  ],
                ),
                SizedBox(height: 32),
                CustomButton(
                  onTap: () {},
                  color: AppColor.primaryColor,
                  buttonLevel: "Save",
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
