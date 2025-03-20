import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  EdgeInsets margin;

  CustomButton({this.buttonText, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 270,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E419B),
          ),
        ),
      ),
    );
  }
}
