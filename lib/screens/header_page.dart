import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_tagalog/widgets/icon_widget.dart';
import 'package:learn_tagalog/models/login_user_model.dart';
import 'package:learn_tagalog/services/google_login_service.dart';
import 'package:provider/provider.dart';

class HeaderPage extends StatefulWidget {
  static const keyDarkMode = 'key-dark-mode';
  bool showProfilePic;

  HeaderPage({this.showProfilePic});

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildHeader(),
          const SizedBox(
            height: 32,
          ),
          buildUser(context),
          buildDarkMode(),
        ],
      );

  Widget buildDarkMode() => SwitchSettingsTile(
        settingKey: HeaderPage.keyDarkMode,
        leading: IconWidget(
          icon: Icons.data_usage_rounded,
          color: Color(0xFF642ef3),
        ),
        title: 'Dark Mode',
        onChange: (_) {},
      );

  Widget buildUser(BuildContext context) {
    final GoogleLoginService loginService =
        Provider.of<GoogleLoginService>(context, listen: false);

    LoginUserModel googleUserModel = loginService.loggedInUserModel;

    String imgPath = googleUserModel != null ? googleUserModel.photoUrl : '';
    String userName =
        googleUserModel != null ? googleUserModel.displayName : '';
    String userEmail = googleUserModel != null ? googleUserModel.email : '';

    bool showUserMapBadge = userName.isNotEmpty && userEmail.isNotEmpty;

    if (showUserMapBadge) {
      return SimpleSettingsTile(
        title: userEmail,
        subtitle: 'Signed using Google',
        leading: ClipOval(
          child: Image.network(imgPath),
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clicked User Profile'),
          ),
        ),
      );
    } else if (auth.currentUser != null) {
      return SimpleSettingsTile(
        title: auth.currentUser.email,
        subtitle: 'Signed in using E-mail',
        leading: ClipOval(
          child: IconWidget(
            icon: FontAwesomeIcons.user,
            color: Colors.purple,
          ),
        ),
      );
    } else {
      return SimpleSettingsTile(
        title: 'User Email',
        subtitle: 'Sign-in method',
        leading: ClipOval(
          child: IconWidget(
            icon: FontAwesomeIcons.user,
            color: Colors.purpleAccent,
          ),
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Clicked'),
          ),
        ),
      );
    }
  }

  Widget buildHeader() => Center(
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget buildUserDetails(BuildContext context) => SimpleSettingsTile(
        title: 'User Details',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.book,
          color: Colors.blue,
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clicked User Details'),
          ),
        ),
      );
}
