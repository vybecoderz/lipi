import 'package:flutter/material.dart';
import 'package:learn_tagalog/models/topic.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonCard extends StatelessWidget {
  Function onCardClick;
  Topic lesson;
  double difficulty;

  LessonCard({this.lesson, this.onCardClick, this.difficulty});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onCardClick();
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: this.lesson.color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Icon(
                this.lesson.icon,
                size: 40.0,
                color: this.lesson.backgroundColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              this.lesson.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 60,
                  child: LinearPercentIndicator(
                    lineHeight: 5.0,
                    backgroundColor: Colors.grey.shade300,
                    progressColor: Colors.amber,
                    percent: difficulty,
                  ),
                ),
                Text(
                  this.lesson.difficulty,
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
