import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLessonIcon extends StatelessWidget {
  Function onTap;
  Function onDoubleTap;
  IconData icon;
  Color iconColor;
  double iconSize;
  double glowRadius;
CustomLessonIcon({this.onTap, this.onDoubleTap, this.icon, this.iconColor, this.iconSize, this.glowRadius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        child: AvatarGlow(
          endRadius: glowRadius,
          duration: Duration(seconds: 2),
          glowColor: Colors.white24,
          repeat: true,
          repeatPauseDuration: Duration(seconds: 2),
          startDelay: Duration(seconds: 1),
          child: Material(
            //elevation: 4.0,
            shape: CircleBorder(),
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
