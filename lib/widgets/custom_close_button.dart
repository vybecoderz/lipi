import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCloseButton extends StatelessWidget{
  Function onTap;

  CustomCloseButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Icon(
            FontAwesomeIcons.times,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

}