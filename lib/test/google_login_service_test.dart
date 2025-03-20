import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_tagalog/models/login_user_model.dart';
import 'package:learn_tagalog/services/google_login_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

final LoginUserModel loginUserModel = LoginUserModel();
class FirebaseAuthMock extends Mock implements FirebaseAuth{}

class MockGoogleSignIn extends Mock implements GoogleSignIn{

}



void main (){
  final MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();

  setUp((){});

 tearDown((){});

 test('sign test', () async{
   final GoogleLoginService googleLoginService = GoogleLoginService();


   when( mockGoogleSignIn.signIn()).thenAnswer((realInvocation) => null);

   expect(await googleLoginService.signInWithGoogle(), true);
 });

}