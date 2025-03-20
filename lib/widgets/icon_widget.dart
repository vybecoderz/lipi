import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {

  const IconWidget({key, @required this.icon, this.color}) : super(key: key);

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Icon(icon, color: Colors.white,),
  );

}