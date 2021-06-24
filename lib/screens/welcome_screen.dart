import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/CustomButton.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  double logoSiz = 60;
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 1,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    ;

    controller.forward();

    animation.addListener(() {
      setState(() {
        backgroundColor = animation.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "Flash_pic",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logoSiz,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Flash Chat",
                      speed: Duration(milliseconds: 150),
                      textStyle:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
                    ),
                  ],
                  totalRepeatCount: 2,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            CustomButton(
              label: "Log In",
              backgroundColor: Colors.lightBlueAccent,
              action: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            CustomButton(
                action: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                backgroundColor: Colors.blueAccent,
                label: "Register"),
          ],
        ),
      ),
    );
  }
}
