import 'package:flutter/material.dart';
import 'package:learn_tagalog/helpers/utils.dart';
import 'package:learn_tagalog/models/topic.dart';
import 'package:learn_tagalog/utilities/collection_logic.dart';
import 'package:learn_tagalog/widgets/custom_lesson_icon.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';

class Collection extends StatefulWidget {
  final List<Topic> collectionContent = Utils.getMockedCategories();

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  CollectionLogic collectionLogic;

  @override
  void initState() {
    super.initState();
    collectionLogic = CollectionLogic();
    collectionLogic.collectionContent.addAll(widget.collectionContent);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ThemeColor(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'Collection Library',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: collectionLogic.getNumberTopic(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.0, top: 15.0),
                                child: Text(
                                  collectionLogic.getTopic(index),
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: ListView.builder(

                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: collectionLogic.getNumberLessons(index),
                              itemBuilder: (BuildContext context, int ind) {

                                return Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.0,
                                                bottom: 5.0,
                                                top: 5.0),
                                            child: Text(
                                              collectionLogic.getLesson(index, ind),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20.0,
                                                  color: Colors.yellow),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:collectionLogic.getNumOfLessonContent(index, ind),
                                          itemBuilder: (BuildContext context,
                                              int contentIndex) {
                                            return Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: CustomLessonIcon(
                                                      icon: collectionLogic.getIcon(index, ind, contentIndex),
                                                      iconColor:
                                                          collectionLogic.getIconColor(index, ind, contentIndex),
                                                      iconSize: 35.0,
                                                      glowRadius: 25.0,
                                                      onTap: () {
                                                        collectionLogic.playAudio(
                                                            collectionLogic.getAudio(index, ind, contentIndex));
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                     collectionLogic.getTagalogText(index, ind, contentIndex),
                                                      style: TextStyle(
                                                          fontSize: 18.0),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      collectionLogic.getEnglishText(index, ind, contentIndex),
                                                      style: TextStyle(
                                                          fontSize: 18.0),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
