import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String errorMessage;

  const ErrorContainer({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
