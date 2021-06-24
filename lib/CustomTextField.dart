import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function onChanged;
  final Function onEditingComplete;

  final TextInputType inputType;
  final bool password;
  final IconData suffixicon;

  final String errorText;

  CustomTextField(
      {@required this.onChanged,
      this.errorText,
      this.password = false,
      this.suffixicon,
      this.inputType,
      this.hintText,
      this.labelText,
      this.onEditingComplete});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String hintText;
  String labelText;
  Function onChanged;
  Function onEditingComplete;

  TextInputType inputType;
  bool password;
  IconData suffixicon;

  bool security = false;
  IconData icon = Icons.security;

  @override
  void initState() {
    super.initState();

    hintText = widget.hintText;
    labelText = widget.labelText;
    onChanged = widget.onChanged;
    inputType = widget.inputType;
    password = widget.password;
    suffixicon = widget.suffixicon;
    onEditingComplete = widget.onEditingComplete;

    checkSecurity();
  }

  void checkSecurity() {
    password ? security = true : security = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget geticon() {
      if (password) {
        // print("password is $password");
        // print("Security is $security");

        return IconButton(
            onPressed: () {
              setState(() {
                !security
                    ? {icon = Icons.security, security = true}
                    : {icon = Icons.remove_red_eye_outlined, security = false};
              });
            },
            icon: Icon(icon));
      } else
        return Icon(suffixicon);
    }

    return TextField(
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      style: kTextFeildInputColor,
      keyboardType: inputType,
      obscureText: security,
      decoration: InputDecoration(
        suffixIcon: geticon(),
        hintText: hintText,
        hintStyle: kTextFeildHintStyle,
        labelText: labelText,
        labelStyle: kTextFeildLabalStyle,
        errorText: widget.errorText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
