import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/CustomButton.dart';
import 'package:flash_chat/CustomTextField.dart';
import 'package:flash_chat/ErrorContainer.dart';
import 'package:flash_chat/FirebaseErrorHandle.dart';
import 'package:flash_chat/Validation.dart';
import 'package:flash_chat/screens/resetConform_Screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PasswordReset extends StatefulWidget {
  static String id = "passwordReset";

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _emailError;

  String _finalError = " ";

  bool _inAsync = false;

  void reset() async {
    print("pass method");

    if (_email == " ") {
      setState(() {
        _emailError = Validation.emailValidation(_email);
      });
    }

    try {
      if (_emailError == null) {
        print("pass if");
        setState(() {
          _inAsync = true;
          print("pass loading");
          _finalError = " ";
          print("pass finalError");
        });
        await _auth.sendPasswordResetEmail(email: _email);

        print("pass reset");
        setState(() {
          _inAsync = false;
        });

        Navigator.pushNamed(context, ResetConformScreen.id);
      }
    } catch (e) {
      print(e);

      setState(() {
        _finalError = FirebaseErrorHandle.AuthExceptionHandler(e.code);
        _inAsync = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _inAsync,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: "Flash_pic",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 48.0,
                ),
              ),
              CustomTextField(
                onChanged: (value) {
                  _email = value;
                },
                suffixicon: Icons.email_rounded,
                hintText: "Enter your email",
                labelText: "Email",
                errorText: _emailError,
                inputType: TextInputType.emailAddress,
                onEditingComplete: () {
                  setState(() {
                    _emailError = Validation.emailValidation(_email);
                  });
                },
              ),
              Flexible(
                child: SizedBox(
                  height: 24.0,
                ),
              ),
              ErrorContainer(
                errorMessage: _finalError,
              ),
              CustomButton(
                action: () {
                  reset();
                },
                label: "Reset",
                backgroundColor: Colors.blueAccent,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                    size: 50,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
