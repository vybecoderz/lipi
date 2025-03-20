import 'package:flutter/material.dart';
import 'package:learn_tagalog/models/lesson.dart';

class LessonContent extends Lesson{

  LessonContent({
    String tagalogWord,
    String engWord,
    String audio,
    IconData icon,
    Color color,
    Color backgroundColor,
    String type,
}): super (
    name: tagalogWord,
    icon: icon,
    color: color,
    backgroundColor: backgroundColor,
    audio: audio,
    engWord: engWord,
    type: type,
  );

}