import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final String sender;

  final Color color;
  final CrossAxisAlignment align;

  MessageWidget({Key key, this.text, this.color, this.align, this.sender});

  double topRight;
  double topLeft;

  void radius() {
    print("hi");
    if (align == CrossAxisAlignment.start) {
      topRight = 30;
      topLeft = 0;
    } else {
      topRight = 0;
      topLeft = 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    radius();

    return Padding(
      padding: EdgeInsets.only(left: 15, top: 8, right: 15),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Material(
            elevation: .5,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight)),
            color: color,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
