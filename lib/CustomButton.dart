import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function action;
  final Color backgroundColor;

  CustomButton(
      {@required this.action, @required this.label, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: action,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
