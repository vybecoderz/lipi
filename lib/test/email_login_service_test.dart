import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_tagalog/services/email_login_service.dart';
import 'package:learn_tagalog/test/mock_firebase_initialize_app.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockEmailFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

void main() {
  setupFirebaseAuthMocks();
  final MockEmailFirebaseAuth mockEmailFirebaseAuth = MockEmailFirebaseAuth();

  setUp(() async {
    await Firebase.initializeApp();
  });
  tearDown(() {});

  test('emit occurs', () async {
    final EmailLoginService emailLoginService =
        EmailLoginService(mockEmailFirebaseAuth);
    //Tests for For future classes
    expectLater(emailLoginService.authStateChanges, emitsInOrder([_mockUser]));
  });

  test('Sign up', () async {
    final EmailLoginService emailLoginService =
        EmailLoginService(mockEmailFirebaseAuth);
    when(
      mockEmailFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test123@email.com', password: '123456'),
    ).thenAnswer((realInvocation) => null);

    expect(
        await emailLoginService.signUp(
            email: 'test123@email.com', password: '123456'),
        'Signed Up!');
  });

  group('Sign up exceptions', () {
    test('sign up email exeception', () async {
      final EmailLoginService emailLoginService =
          EmailLoginService(mockEmailFirebaseAuth);

      when(
        mockEmailFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test123@email.com', password: '123456'),
      ).thenAnswer((realInvocation) =>
          throw FirebaseAuthException(code: 'email-already-in-use'));

      expect(
          await emailLoginService.signUp(
              email: 'test123@email.com', password: '123456'),
          'The account already exists for that email.');
    });

    test('sign up password exeception', () async {
      final EmailLoginService emailLoginService =
          EmailLoginService(mockEmailFirebaseAuth);

      when(
        mockEmailFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test123@email.com', password: '123456'),
      ).thenAnswer((realInvocation) =>
          throw FirebaseAuthException(code: 'weak-password'));

      expect(
          await emailLoginService.signUp(
              email: 'test123@email.com', password: '123456'),
          'The password that you have provided is too weak.');
    });

    test('sign up exception', () async {
      final EmailLoginService emailLoginService =
          EmailLoginService(mockEmailFirebaseAuth);
      when(
        mockEmailFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test123@email.com', password: '123456'),
      ).thenAnswer((realInvocation) =>
          throw FirebaseAuthException(message: 'Something went wrong.'));

      expect(
          await emailLoginService.signUp(
              email: 'test123@email.com', password: '123456'),
          'Something went wrong.');
    });
  });

  test('Sign in', () async {
    final EmailLoginService emailLoginService =
        EmailLoginService(mockEmailFirebaseAuth);

    when(
      mockEmailFirebaseAuth.signInWithEmailAndPassword(
          email: 'test123@email.com', password: '123456'),
    ).thenAnswer((realInvocation) => null);

    expect(
        await emailLoginService.signIn(
            email: 'test123@email.com', password: '123456'),
        'Signed In');
  });

  group('Sign in exceptions', () {

    test('sign in email exception', () async {
      final EmailLoginService emailLoginService =
          EmailLoginService(mockEmailFirebaseAuth);

      when(
        mockEmailFirebaseAuth.signInWithEmailAndPassword(
            email: 'test123@email.com', password: '123456'),
      ).thenAnswer((realInvocation) =>
          throw FirebaseAuthException(code: 'user-not-found'));

      expect(
          await emailLoginService.signIn(
              email: 'test123@email.com', password: '123456'),
          'No user found for that email.');
    });

    test('sign in password exception', () async {
      final EmailLoginService emailLoginService =
          EmailLoginService(mockEmailFirebaseAuth);

      when(
        mockEmailFirebaseAuth.signInWithEmailAndPassword(
            email: 'test123@email.com', password: '123456'),
      ).thenAnswer((realInvocation) =>
          throw FirebaseAuthException(code: 'wrong-password'));

      expect(
          await emailLoginService.signIn(
              email: 'test123@email.com', password: '123456'),
          'Wrong password provided for that user.');
    });

    test('sign in exception', () async {
      final EmailLoginService emailLoginService =
          EmailLoginService(mockEmailFirebaseAuth);
      when(
        mockEmailFirebaseAuth.signInWithEmailAndPassword(
            email: 'test123@email.com', password: '123456'),
      ).thenAnswer((realInvocation) =>
          throw FirebaseAuthException(message: 'Something went wrong.'));

      expect(
          await emailLoginService.signIn(
              email: 'test123@email.com', password: '123456'),
          'Something went wrong.');
    });
  });

  test('Sign out', () async {
    final EmailLoginService emailLoginService =
    EmailLoginService(mockEmailFirebaseAuth);

    when(
      mockEmailFirebaseAuth.signOut(),
    ).thenAnswer((realInvocation) => null);

    expect(await emailLoginService.signOut(), 'Signed out!');

  });

  test('get user from DB', () async {
    final EmailLoginService emailLoginService =
    EmailLoginService(mockEmailFirebaseAuth);

    when(
      mockEmailFirebaseAuth.signOut(),
    ).thenAnswer((realInvocation) => null);

    expect(await emailLoginService.signOut(), 'Signed out!');

  });

}
