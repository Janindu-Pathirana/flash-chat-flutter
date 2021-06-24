import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/FireBaseProp.dart';
import 'package:flash_chat/FirebaseErrorHandle.dart';
import 'package:flash_chat/RegisterColumn.dart';
import 'package:flash_chat/Validation.dart';
import 'package:flash_chat/screens/Chat_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "register";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email = " ";
  String _password = " ";
  String _name = " ";
  String _conform;

  String _conformError;
  String _emailError;
  String _passwordError;
  String _nameError;

  String _finalError = " ";

  bool _inAsync = false;

  void register() async {
    _email = RegisterColumn.email;

    // _emailError = RegisterColumn.emailError;
    _password = RegisterColumn.password;
    // _passwordError = RegisterColumn.passwordError;
    _name = RegisterColumn.name;

    _conform = RegisterColumn.conform;

    setState(() {
      _passwordError = Validation.checkPassword(_password);
      _emailError = Validation.emailValidation(_email);
      _conformError = Validation.checkConform(_password, _conform);
    });

    if (_name == " " || _name == null) {
      setState(() {
        _nameError = "Enter your name";
      });
    } else {
      setState(() {
        _nameError = null;
      });
    }
    print("name $_name");
    print("password $_password");
    print("email $_email");
    print("conform $_conform");
    print("name Error $_nameError");
    print("password Error $_passwordError");
    print("email Error$_emailError");
    print("conform Error$_conformError");

    try {
      if (_emailError == null &&
          _conformError == null &&
          _passwordError == null &&
          _emailError == null &&
          _nameError == null) {
        setState(() {
          _inAsync = true;

          _finalError = " ";
        });
        final newUser = await FireBaseProp.auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        await FireBaseProp.auth.currentUser.updateProfile(displayName: _name);

        setState(() {
          _inAsync = false;
        });
        if (newUser != null) {
          var _firebase = await FirebaseFirestore.instance
              .collection(FireBaseProp.auth.currentUser.email);

          _firebase.add({
            "myEmail": FireBaseProp.auth.currentUser.email,
            "myName": _name
          });

          Navigator.pushNamed(context, ChatListScreen.id);
        }
      }
    } catch (e) {
      print("Error code ${e.code}");

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
              SizedBox(
                height: 48.0,
              ),
              RegisterColumn(
                passwordHint: "Enter your password",
                passwordLabel: "Password",
                conformHint: "Enter your password again",
                finalError: _finalError,
                nameError: _nameError,
                passwordError: _passwordError,
                emailError: _emailError,
                conformError: _conformError,
                buttonName: "Register",
                buttonAction: () {
                  register();
                  print("FinalError $_finalError");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
