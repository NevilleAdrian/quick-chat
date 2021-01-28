import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/flash_padding.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool showSpinner = false;

  void _showFlush(BuildContext context, String message, Color color) {
    Flushbar(
      backgroundColor: color,
      message: message,
      duration: Duration(seconds: 7),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo-2.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                  onChanged: (value) {
                  password = value;
                },
                  obscureText: true,
                decoration: kInputDecoration.copyWith(hintText: 'Enter your password')
              ),
              SizedBox(
                height: 24.0,
              ),
              FlashPadding(
                color: Color(0XFF37003c),
                text: 'Register',
                textcolor: Colors.white,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newuser =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newuser != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          ChatScreen.id, (Route<dynamic> route) => false);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
                  catch(e) {
                    _showFlush(context, 'Login details are invalid', Colors.red);
                    setState(() {
                      showSpinner = false;
                    });
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
