import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  String buttonTxt;
  Function onTap;
  Color txtColor;

  QuizButton({this.buttonTxt, this.onTap, this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(253, 202, 49, 1.0),
                style: BorderStyle.solid,
                width: 3.0,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    this.buttonTxt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: this.txtColor,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
