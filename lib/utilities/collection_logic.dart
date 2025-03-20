import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learn_tagalog/models/lesson.dart';
import 'package:learn_tagalog/models/topic.dart';

class CollectionLogic {
  AudioPlayer player = AudioPlayer();

  List<Topic> collectionContent = [];

  String getTagalogText(
      int collectionNumber, int lessonNumber, int lessonIndex) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];
    return lessonContents.lessonContent[lessonIndex].name;
  }

  String getEnglishText(
      int collectionNumber, int lessonNumber, int lessonIndex) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];

    return lessonContents.lessonContent[lessonIndex].engWord;
  }

  String getAudio(int collectionNumber, int lessonNumber, int lessonIndex) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];

    return lessonContents.lessonContent[lessonIndex].audio;
  }

  IconData getIcon(int collectionNumber, int lessonNumber, int lessonIndex) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];
    return lessonContents.lessonContent[lessonIndex].icon;
  }

  Color getIconColor(int collectionNumber, int lessonNumber, int lessonIndex) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];
    return lessonContents.lessonContent[lessonIndex].color;
  }

  String getTopic(int topicIndex) {
    return collectionContent[topicIndex].name;
  }

  int getNumberTopic() {
    return collectionContent.length;
  }

  int getNumberLessons(int collectionNumber) {
    return collectionContent[collectionNumber].lessons.length;
  }

  String getLesson(int collectionNumber, int lessonNumber) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];
    return lessonContents.name;
  }

  int getNumOfLessonContent(
      int collectionNumber, int lessonNumber,) {
    Lesson lessonContents =
        collectionContent[collectionNumber].lessons[lessonNumber];
    return lessonContents.lessonContent.length;
  }

  playAudio(String audioFile) async {
    await player.setAsset(audioFile);
    await player.setSpeed(1);
    player.play();
  }

  playHalfSpeed(String audioFile) async {
    await player.setAsset(audioFile);
    await player.setSpeed(1);
    player.play();
  }
}
