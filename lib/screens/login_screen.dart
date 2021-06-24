import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/CustomButton.dart';
import 'package:flash_chat/CustomTextField.dart';
import 'package:flash_chat/ErrorContainer.dart';
import 'package:flash_chat/FirebaseErrorHandle.dart';
import 'package:flash_chat/Validation.dart';
import 'package:flash_chat/screens/Chat_list_screen.dart';
import 'package:flash_chat/screens/password_reset_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String _email = " ";
  String _emailError;
  String _password;
  String _passwordError;

  String _finalError = " ";

  bool _inAsync = false;

  void login() async {
    setState(() {
      checkPassword();
      _emailError = Validation.emailValidation(_email);
    });

    try {
      if (_passwordError == null && _emailError == null) {
        setState(() {
          _inAsync = true;
          _finalError = " ";
        });

        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        setState(() {
          _inAsync = false;
        });

        if (user != null) {
          Navigator.pushNamed(context, ChatListScreen.id);
        }
      }
    } catch (e) {
      print(e.code);

      setState(() {
        _finalError = FirebaseErrorHandle.AuthExceptionHandler(e.code);
        _inAsync = false;
      });
    }
  }

  void checkPassword() {
    if (_password == null) {
      _passwordError = "Password field cannot be empty";
    } else {
      _passwordError = null;
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
                  height: 8.0,
                ),
              ),
              CustomTextField(
                onChanged: (value) {
                  _password = value;
                  setState(() {
                    checkPassword();
                  });
                },
                errorText: _passwordError,
                suffixicon: Icons.security,
                hintText: "Enter your password",
                labelText: "Password",
                password: true,
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
                  login();
                },
                label: "Log In",
                backgroundColor: Colors.lightBlueAccent,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PasswordReset.id);
                  },
                  child: Text("Forgot password")),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, WelcomeScreen.id);
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
      ),
    );
  }
}
