import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseProp {
  static final auth = FirebaseAuth.instance;
  static final fireStoreMessage = FirebaseFirestore.instance;
  static User loggedInUser;
  static String _userEmail;
  static String _userName;

  static String get userEmail => _userEmail;

  static String get userName => _userName;

  /*static getName() {
    _userName = loggedInUser.displayName;
  }*/

  static void getCurrentUser() {
    try {
      final user = FireBaseProp.auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        _userEmail = user.email;
        _userName = user.displayName;
        print(user.email);
        print(_userName);
      }
    } catch (e) {
      print(e);
    }
  }
}
