import 'package:flash_chat/FireBaseProp.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/contact_adding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

var firebaseMessage;

class ChatListScreen extends StatefulWidget {
  static const String id = "ChatListScreen";

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String _name = " ";

  void getData() {
    print("pass getData");
    FireBaseProp.getCurrentUser();
    // FireBaseProp.getName();
    _name = FireBaseProp.userName;

    firebaseMessage =
        FireBaseProp.fireStoreMessage.collection(FireBaseProp.userEmail);
  }

  @override
  initState() {
    getData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("pass getData $_name");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(_name),
        actions: <Widget>[
          PupoUpMenu(),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ContactAddingScreen.id);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListStream(),
        ],
      ),
    );
  }
}

class PupoUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.menu),
      iconSize: 30,
      color: Color(0xFF25B7FA),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: menu.ChangeEmail,
          child: Text("Settings"),
        ),
        const PopupMenuItem(
          value: menu.LogOut,
          child: Text(
            "Log out",
          ),
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case menu.LogOut:
            try {
              await FireBaseProp.auth.signOut();
              Navigator.pop(context);
            } catch (e) {
              print(e);
            }

            break;
          case menu.ChangeEmail:
            print("hi");
            break;
        }
      },
    );
  }
}

class ListStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firebaseMessage.snapshots(),
        builder: (context, snapShot) {
          Widget returnVal;

          print("pass");

          if (snapShot.hasData) {
            // print("pass");
            List<Widget> widgetList = [];

            final messages = snapShot.data.docs;

            for (var m in messages) {
              // print(m.data()["email"]);
              final email = m.data()["email"];
              final id = m.data()["id"];

              String name;

              if (m.data()["name"] == null) {
                name = email;
              } else {
                name = m.data()["name"];
              }

              // print(id);

              if (email != null) {
                widgetList.add(GestureDetector(
                  onTap: () {
                    ChatScreen.chatId = id;

                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Material(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "$name",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ));
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
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                SpinKitRing(
                  color: Colors.blue,
                  size: 60,
                ),
              ],
            );
          }

          return returnVal;
        });
  }
}
