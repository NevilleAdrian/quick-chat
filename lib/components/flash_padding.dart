import 'package:flutter/material.dart';

class FlashPadding extends StatelessWidget {
  const FlashPadding({ this.color, this.text, this.onPressed, this.textcolor }) ;

  final Color color;
  final String text;
  final Color textcolor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
              text,
          style: TextStyle(
              color: textcolor
          ),
          ),
        ),
      ),
    );
  }
}