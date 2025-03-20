import 'package:flutter/cupertino.dart';

import 'lesson.dart';

class Question extends Lesson {
  String question;
  String answer;
  String option;
  String option1;
  String option2;
  String option3;

  Question({
    String question,
    this.answer,
    this.option,
    this.option1,
    this.option2,
    this.option3,
    bool questionCheck,
  }) : super(
          name: question,
        );


  static Question of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: Question);
  }
}
