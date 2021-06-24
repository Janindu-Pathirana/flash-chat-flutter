import 'package:flash_chat/CustomButton.dart';
import 'package:flash_chat/CustomTextField.dart';
import 'package:flash_chat/ErrorContainer.dart';
import 'package:flash_chat/Validation.dart';
import 'package:flutter/material.dart';

class RegisterColumn extends StatefulWidget {
  final Function buttonAction;
  final String buttonName;
  final String passwordLabel;
  final String passwordHint;
  final String conformHint;

  String finalError;
  String nameError;
  String emailError;
  String passwordError;
  String conformError;

  static String email;
  static String password;
  static String name;
  static String conform;
  // static String emailError;
  // static String passwordError;

  // static String nameError;

  RegisterColumn(
      {Key key,
      @required this.buttonAction,
      this.buttonName,
      this.passwordLabel,
      this.passwordHint,
      this.conformHint,
      @required this.finalError,
      this.nameError,
      this.passwordError,
      this.emailError,
      this.conformError})
      : super(key: key);

  @override
  _RegisterColumnState createState() => _RegisterColumnState();
}

class _RegisterColumnState extends State<RegisterColumn> {
  Function _buttonAction;
  String _buttonName;
  String _passwordLabel;
  String _passwordHint;
  String _conformHint;

  @override
  initState() {
    super.initState();

    _buttonAction = widget.buttonAction;
    _buttonName = widget.buttonName;
    _passwordLabel = widget.passwordLabel;
    _passwordHint = widget.passwordHint;
    _conformHint = widget.conformHint;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        padding: EdgeInsets.all(0),

        children: [
          CustomTextField(
            onChanged: (value) {
              RegisterColumn.name = value;
              print(value);
            },
            errorText: widget.nameError,
            suffixicon: Icons.person,
            inputType: TextInputType.text,
            hintText: "Enter your name",
            labelText: "Name",
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomTextField(
            onChanged: (value) {
              RegisterColumn.email = value;
            },
            onEditingComplete: () {
              setState(() {
                widget.emailError =
                    Validation.emailValidation(RegisterColumn.email);
              });
            },
            errorText: widget.emailError,
            suffixicon: Icons.email_rounded,
            inputType: TextInputType.emailAddress,
            hintText: "Enter your email",
            labelText: "Email",
          ),
          SizedBox(
            height: 24.0,
          ),
          CustomTextField(
            onChanged: (value) {
              RegisterColumn.password = value;
              setState(() {
                widget.passwordError =
                    Validation.checkPassword(RegisterColumn.password);
              });
            },
            password: true,
            suffixicon: Icons.security,
            errorText: widget.passwordError,
            hintText: _passwordHint,
            labelText: _passwordLabel,
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomTextField(
            suffixicon: Icons.security,
            errorText: widget.conformError,
            password: true,
            hintText: _conformHint,
            labelText: "Conform",
            onChanged: (value) {
              RegisterColumn.conform = value;

              setState(() {
                widget.conformError = Validation.checkConform(
                    RegisterColumn.password, RegisterColumn.conform);
              });
            },
          ),
          SizedBox(
            height: 24.0,
          ),
          ErrorContainer(
            errorMessage: widget.finalError,
          ),
          CustomButton(
            action: _buttonAction,
            label: _buttonName,
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
    );
  }
}
