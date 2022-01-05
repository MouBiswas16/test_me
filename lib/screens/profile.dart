// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_me/utils/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(
          "User List",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColor.secondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/image/profile.jpg"),
            ),
            Text(
              "Mr. John Doe",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor,
              ),
            ),
            Text(
              "email@email.com",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor,
              ),
            ),
            Text(
              "012345678901",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryColor,
              ),
            ),
            Card(
              child: SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Created Date & Time",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Text(
                      "1/1/2022 12.35 AM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  "Location",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/image/google_map.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
