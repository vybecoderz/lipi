import 'package:flutter/material.dart';
import 'package:learn_tagalog/models/topic.dart';

class Lesson extends Topic {

  List<Lesson> lessonContent;
  List<Lesson> lessonQuestions;
  String engWord;
  String audio;
  String type;


  Lesson({
    String name,
    IconData icon,
    Color color,
    Color backgroundColor,
    String difficulty,
    this.lessonContent,
    this.audio,
    this.engWord,
    this.lessonQuestions,
    this.type,

}): super (
    name: name,
    icon: icon,
    color: color,
    backgroundColor: backgroundColor,
    difficulty: difficulty,
  );



}