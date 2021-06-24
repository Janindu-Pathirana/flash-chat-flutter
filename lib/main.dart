import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/Chat_list_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/contact_adding_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/password_reset_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/resetConform_Screen.dart';
import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  return runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        cardColor: Color(0xFFB9E2F8),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PasswordReset.id: (context) => PasswordReset(),
        ResetConformScreen.id: (context) => ResetConformScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatListScreen.id: (context) => ChatListScreen(),
        ContactAddingScreen.id: (context) => ContactAddingScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
