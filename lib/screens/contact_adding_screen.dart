import 'package:flash_chat/CustomButton.dart';
import 'package:flash_chat/CustomTextField.dart';
import 'package:flash_chat/ErrorContainer.dart';
import 'package:flash_chat/FireBaseProp.dart';
import 'package:flash_chat/FirebaseErrorHandle.dart';
import 'package:flash_chat/Validation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ContactAddingScreen extends StatefulWidget {
  static const String id = "ContactAddingScreen";

  @override
  _ContactAddingScreenState createState() => _ContactAddingScreenState();
}

class _ContactAddingScreenState extends State<ContactAddingScreen> {
  String _finalError = " ";
  String _email;
  String _emailError;

  String _name;

  bool asyncVal = false;

  void add() async {
    if (_name == null) {
      _name = "NoName";
    }

    try {
      setState(() {
        asyncVal = true;
      });
      var n = await FireBaseProp.auth.fetchSignInMethodsForEmail(_email);

      if (n.length == 0 || _email == FireBaseProp.userEmail) {
        setState(() {
          if (_email == FireBaseProp.userEmail) {
            _finalError = "This is your email Address";
          } else {
            _finalError = "This user didn't exist";
          }
          asyncVal = false;
        });
      } else {
        String id = _email + FireBaseProp.userEmail;

        FireBaseProp.fireStoreMessage
            .collection(FireBaseProp.userEmail)
            .add({"email": _email, "id": id, "name": _name});
        FireBaseProp.fireStoreMessage.collection(_email).add({
          "email": FireBaseProp.userEmail,
          "id": id,
        });

        FireBaseProp.fireStoreMessage.collection(id).add({"Id": id});

        Navigator.pop(context);
      }
      // print("pass");
    } catch (e) {
      setState(() {
        _finalError = FirebaseErrorHandle.AuthExceptionHandler(e.code);
        asyncVal = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: asyncVal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Enter your receiver's details.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.indigo[600]),
                ),
                Flexible(
                    child: SizedBox(
                  height: 24,
                )),
                CustomTextField(
                  onChanged: (value) {
                    _name = value;
                  },
                  suffixicon: Icons.person,
                  inputType: TextInputType.text,
                  labelText: "Name",
                  hintText: "Enter receiver's name",
                ),
                Flexible(
                    child: SizedBox(
                  height: 8,
                )),
                CustomTextField(
                  onChanged: (value) {
                    _email = value;
                    setState(() {
                      _emailError = Validation.emailValidation(_email);
                    });
                  },
                  suffixicon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  errorText: _emailError,
                  labelText: "Email",
                  hintText: "Enter receiver's email address",
                ),
                Flexible(
                  child: SizedBox(
                    height: 24.0,
                  ),
                ),
                ErrorContainer(
                  errorMessage: _finalError,
                ),
                Flexible(
                  child: SizedBox(
                    height: 24.0,
                  ),
                ),
                CustomButton(
                  action: () {
                    add();
                    print(_finalError);
                  },
                  label: "Add",
                  backgroundColor: Colors.lightBlueAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
