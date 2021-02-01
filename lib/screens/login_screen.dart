import 'package:flash_chat/constants.dart';
import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/models/remember_me.dart';
import 'package:flash_chat/provider/auth_provider.dart';
import 'package:flash_chat/repository/hive_repository.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/flash_padding.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;

  HiveRepository _hiveRepository = HiveRepository();


  String email;
  String password;
  RememberMe me;


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
                onChanged: (value) {
                password = value;
              },
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kInputDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              FlashPadding(
                color: Color(0XFF37003c),
                text: 'Log In',
                textcolor: Colors.white,
                onPressed: () async {
                 setState(() {
                   showSpinner = true;
                 });
                  try {
                    final newuser =  await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(newuser != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(ChatScreen.id, (Route<dynamic> route) => false);
                      setState(() {
                        me  = Auth.authProvider(context).rememberMe(RememberMe.fromJson({"bool": true}));
                        print('me: $me');
                        _hiveRepository.add<RememberMe>(name: kRemember, key: 'remember', item: me);
                        showSpinner = false;
                      });
                    }

                  }
                  catch(e) {
                    _showFlush(context, e.message, Colors.red);
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
