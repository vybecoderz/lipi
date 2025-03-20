import 'package:flutter/material.dart';
import 'package:learn_tagalog/helpers/utils.dart';
import 'package:learn_tagalog/models/topic.dart';
import 'package:learn_tagalog/screens/lesson_detail.dart';
import 'package:learn_tagalog/widgets/lesson_card.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';

class Topics extends StatelessWidget {
  List<Topic> topic = Utils.getMockedCategories();

  Topic selectedCategory;

  Topics({this.selectedCategory});

  double getDifficulty(int index, int ind){
    if(topic[index].lessons[ind].difficulty == 'Easy'){
      return 0.2;
    }else if(topic[index].lessons[ind].difficulty == 'Medium'){
      return 0.5;
    } else{
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemeColor(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Topics',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: topic.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  topic[index].name,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 170,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                              ),
                              shrinkWrap: true,
                              itemCount: topic[index].lessons.length,
                              itemBuilder: (BuildContext context, int ind) {
                                return LessonCard(
                                  lesson: topic[index].lessons[ind],
                                  difficulty: getDifficulty(index, ind),
                                  onCardClick: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext alertContext) {
                                        return AlertDialog(
                                          title: Text('Are you sure?'),
                                          content: Text(
                                              'Are you ready to take this lesson?'),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                FlatButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {

                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (alertContext) =>
                                                            LessonDetail(
                                                              lessons: topic[index]
                                                                  .lessons[ind],
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('No'),
                                                  onPressed: () {

                                                    Navigator.of(alertContext,
                                                        rootNavigator: true)
                                                        .pop();
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
