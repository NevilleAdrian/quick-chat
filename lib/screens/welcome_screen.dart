import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/flash_padding.dart';


class WelcomeScreen extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
//      upperBound: 60.0, cant be used with curved animation
    );

    //cant have an upperbound greater than 1
//   animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
     //there are other tweens available
      animation = ColorTween(begin: Color(0XFF37003c), end: Color(0XFFff2882)).animate(controller);
      controller.forward();
//    controller.reverse(from: 1.0);

    animation.addStatusListener((status) {

      if(status == AnimationStatus.completed ) {
      controller.reverse(from: 1.0);
      }
      else if ( status == AnimationStatus.dismissed){
      controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
//      print(animation.value);
    });
  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white.withOpacity(controller.value),
    backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo-2.png'),
//                       height: controller.value
//                      height: animation.value * 60,
                    height: 60.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                TypewriterAnimatedTextKit(
//                  '${controller.value.toInt()}%',
                  text: ['Quick Chat'],
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: Duration(milliseconds: 700)
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            FlashPadding(
              color: Color(0XFFFFC8DF),
              text: 'Log In',
              textcolor: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            FlashPadding(
              color: Color(0XFF83008f),
              text: 'Register',
              textcolor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}




