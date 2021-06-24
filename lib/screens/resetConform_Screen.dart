import 'package:flash_chat/CustomButton.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ResetConformScreen extends StatelessWidget {
  static String id = "resetConfirm";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Hero(
                tag: "Flash_pic",
                child: Container(
                  height: 200,
                  child: Image.asset("images/logo.png"),
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                height: 50,
              ),
            ),
            Container(
              child: Text(
                "Check your mail box for password reset link. \n Check Spam folder also.",
                style: TextStyle(fontSize: 17, color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: SizedBox(
                height: 40,
              ),
            ),
            CustomButton(
              action: () {
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
              label: "Log In",
              backgroundColor: Colors.blue,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.blue,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
