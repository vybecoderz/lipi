import 'package:cloud_firestore/cloud_firestore.dart';

class EmailUserModel{
  String email;
  String uid;
  String displayName;
  DateTime timestamp;

  EmailUserModel({this.email, this.uid, this.displayName, this.timestamp});

  Map toMap(EmailUserModel emailUser) {

    var data = Map<String, dynamic>();

    data['uid'] = emailUser.uid;
    data['email'] = emailUser.email;
    data['displayName'] = emailUser.displayName;
    data['timestamp'] = emailUser.timestamp;

    return data;
  }

  EmailUserModel.fromMap(Map<String, dynamic> mapData){
    this.uid = mapData['uid'];
    this.displayName = mapData['displayName'];
    this.email = mapData['email'];
  }

 factory EmailUserModel.fromDocument(DocumentSnapshot doc) {
   return EmailUserModel(
       uid: doc['uid'], email: doc['email'], displayName: doc['displayName']);
 }
}