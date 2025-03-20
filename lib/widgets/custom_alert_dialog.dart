import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget{
  String title;
  String content;
  String button1Text;
  Function btn1Func;
  String button2Text;
  Function btn2Func;

  @override
  CustomAlertDialog({this.title, this.content, this.button1Text, this.btn1Func, this.button2Text, this.btn2Func});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text(title),
      content: Text(
          content),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              child: Text(button1Text),
              onPressed: btn1Func,
            ),
            FlatButton(
              child: Text(button2Text),
              onPressed: btn2Func,
            ),
          ],
        )
      ],
    );
  }


}