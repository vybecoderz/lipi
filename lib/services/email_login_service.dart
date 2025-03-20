import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_tagalog/models/email_login_user_model.dart';

class EmailLoginService {
  EmailLoginService(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;
  EmailUserModel emailUserModel = EmailUserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  Stream<User> get authStateChanges => firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'Something went wrong.';
      }
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return 'Signed Up!';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password that you have provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Something went wrong.';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> signOut() async {
    try{
      await firebaseAuth.signOut();
      return 'Signed out!';
    } on FirebaseAuthException catch (e){
      return 'Something went wrong.';
    }
  }

  Future<void> addUserToDB(
      {String uid,
      String displayName,
      String email,
      DateTime timestamp}) async {
    emailUserModel = EmailUserModel(
        uid: uid, displayName: displayName, email: email, timestamp: timestamp);

    await userRef.doc(uid).set(emailUserModel.toMap(emailUserModel));
  }

  Future<EmailUserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();

    print(doc.data());

    return EmailUserModel.fromMap(doc.data());
  }
}
