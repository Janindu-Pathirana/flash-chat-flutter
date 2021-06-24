import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/FireBaseProp.dart';
import 'package:flash_chat/MessageStream.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

enum menu { LogOut, ChangeEmail }

var fireStoreMessage;

class ChatScreen extends StatefulWidget {
  static const String id = "chat";

  static String chatId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fieldText = TextEditingController();

  String _message;

  @override
  void initState() {
    fireStoreMessage = FirebaseFirestore.instance.collection(ChatScreen.chatId);

    FireBaseProp.getCurrentUser();

    super.initState();
  }

  void sendMessage() async {
    if (_message != null) {
      try {
        await fireStoreMessage.add({
          "text": _message,
          "sender": FireBaseProp.userEmail,
        });
      } catch (e) {
        print(e);
      }

      setState(() {
        _message = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _fieldText,
                        onChanged: (value) {
                          _message = value;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _fieldText.clear();
                        sendMessage();
                        print(FireBaseProp.userEmail);
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
