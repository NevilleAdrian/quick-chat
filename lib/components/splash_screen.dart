import 'dart:async';
import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/models/remember_me.dart';
import 'package:flash_chat/provider/auth_provider.dart';
import 'package:flash_chat/repository/hive_repository.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  HiveRepository _hiveRepository = HiveRepository();
  var _size = 0.0;
  var _dataReady = Completer();
  var _animationReady = Completer();
  RememberMe me;

  @override
  void initState() {
    _prepareAppState();
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation = ColorTween(begin: Color(0XFF37003c), end: Color(0XFFff2882)).animate(controller);
    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 2.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();

      }
    });
    controller.addListener(() {
      setState(() {});
    });
    initStateAsync();
  }

  void initStateAsync() async {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _size = 30.0;
      });
      print("animation ready");
      _animationReady.complete(true);
    });
  }

  _prepareAppState() async {
    await HiveRepository.openHives([kRemember]);

    RememberMe remember;
   // try {
   //   remember = _hiveRepository.get<RememberMe>(key: 'remember', name: kRemember);
   // } catch(ex) {
   //   print(ex);
   // }
      remember = _hiveRepository.get<RememberMe>(key: 'remember', name: kRemember);

    print('rememberme :$remember');
    if (remember == null || remember.rememberMeBool == false) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          WelcomeScreen.id, (Route<dynamic> route) => false);
    } else {
      Auth.authProvider(context).setRemember(remember);
      Navigator.of(context).pushNamedAndRemoveUntil(ChatScreen.id, (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  Container(
         color: animation.value,
         child: Center(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               SizedBox(height: 20),
               Hero(
                 tag: "main_logo",
                 child: Align(
                   child: Container(
                       child: Column(
                         children: [
                           Image.asset('images/logo-2.png', height: 130,),
                           SizedBox(height: 10.0,),
                           Text('Quick Chat', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),)

                         ],
                       )
                   ),
                 ),
               ),
               Container(
                 color: Colors.transparent,
                 height: 20,
               ),
               AnimatedContainer(
                 duration: Duration(milliseconds: 500),
                 height: _size,
                 width: _size,
                 child: CircularProgressIndicator(strokeWidth: 1),
               )
             ],
           ),
         ),
       ),
    );
  }
}
