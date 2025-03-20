import 'package:flutter/material.dart';

class ThemeColor extends StatelessWidget{

  Widget child;
  EdgeInsets padding;

  ThemeColor({this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFCE2029),
            Color(0xFF1E419B),
          ],
        ),
      ),
      child: child,
    );
  }


}