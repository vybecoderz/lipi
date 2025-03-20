import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_tagalog/models/login_user_model.dart';

class GoogleLoginService {
  GoogleLoginService() {
    Firebase.initializeApp();
  }

  LoginUserModel _userModel;

  LoginUserModel get loggedInUserModel => _userModel;

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return false;
    }

    // obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCreds =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCreds != null) {
      _userModel = LoginUserModel(
        displayName: userCreds.user.displayName,
        photoUrl: userCreds.user.photoURL,
        email: userCreds.user.email,
        uid: userCreds.user.uid,
      );
    }
    return true;
  }

  void singOut() async {
    await GoogleSignIn().signOut();
    _userModel = null;
  }
}
