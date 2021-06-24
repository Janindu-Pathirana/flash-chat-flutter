import 'package:flash_chat/FireBaseProp.dart';
import 'package:flash_chat/MessageWidget.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireStoreMessage.snapshots(),
        builder: (context, snapShot) {
          Widget returnVal;

          // print("pass");

          if (snapShot.hasData) {
            // print("pass");
            List<Widget> widgetList = [];

            final messages = snapShot.data.docs;

            for (var m in messages) {
              // print(m.data()["text"]);
              final text = m.data()["text"];
              // print("hi");
              final sender = m.data()["sender"];

              if (text != null) {
                if (sender == FireBaseProp.userEmail) {
                  widgetList.add(
                    MessageWidget(
                      color: Color(0xFFB1F5F5),
                      text: text,
                      sender: "...Me...",
                      align: CrossAxisAlignment.end,
                    ),
                  );
                } else {
                  widgetList.add(
                    MessageWidget(
                      color: Color(0xFFA3C8F6),
                      text: text,
                      sender: sender,
                      align: CrossAxisAlignment.start,
                    ),
                  );
                }
              }
            }

            widgetList.add(
              SizedBox(
                height: 40,
              ),
            );

            returnVal = Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 15),
                reverse: true,
                children: widgetList,
              ),
            );
          } else {
            returnVal = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Cannot load data",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                SpinKitRing(
                  color: Colors.blue,
                  size: 60,
                ),

                /*CircularProgressIndicator(
                  value: 0.5,
                  color: Colors.blue,
                  backgroundColor: Colors.blueAccent,
                ),*/
              ],
            );
          }

          return returnVal;
        });
  }
}
