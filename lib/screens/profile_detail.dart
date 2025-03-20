import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_tagalog/screens/account_page.dart';
import 'package:learn_tagalog/screens/header_page.dart';
import 'package:learn_tagalog/services/email_login_service.dart';
import 'package:learn_tagalog/widgets/custom_alert_dialog.dart';
import 'package:learn_tagalog/widgets/icon_widget.dart';
import 'package:learn_tagalog/models/login_user_model.dart';
import 'package:learn_tagalog/screens/reminder_detail.dart';
import 'package:learn_tagalog/screens/welcome_detail.dart';
import 'package:learn_tagalog/services/google_login_service.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final bool showProfilePic = true;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    email = auth.currentUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemeColor(
        child: SafeArea(
          child: ListView(
            children: [
              SettingsGroup(
                title: '',
                children: <Widget>[
                  HeaderPage(
                    showProfilePic: widget.showProfilePic,
                  ),
                ],
              ),
              SettingsGroup(
                title: 'General',
                children: <Widget>[
                  AccountPage(),
                  buildReminder(context),
                  buildLogout(context),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SettingsGroup(
                title: 'FEEDBACK',
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  buildReportBug(context),
                  buildSendFeedback(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReminder(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Reminders',
      subtitle: 'Set reminders',
      leading: IconWidget(
        icon: FontAwesomeIcons.bell,
        color: Colors.amber,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Reminder(),
          ),
        );
      },
    );
  }

  Widget buildLogout(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Logout',
      subtitle: '',
      leading: IconWidget(
        icon: Icons.logout,
        color: Colors.blueAccent,
      ),
      onTap: () {
        setState(() {
          alertDialog(context);
        });
      },
    );
  }

  Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
        title: 'Report Bug',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.bug_report,
          color: Colors.cyan[800],
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clicked Report Bug'),
          ),
        ),
      );

  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
        title: 'Send Feedback',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.thumb_up,
          color: Colors.purple,
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clicked Send Feedback'),
          ),
        ),
      );

  alertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext alertContext) {
          return CustomAlertDialog(
            title: 'Logout',
            content: 'Are you sure want to Logout?',
            button1Text: 'Yes',
            btn1Func: () {
              final GoogleLoginService loginService =
                  Provider.of<GoogleLoginService>(context, listen: false);

              LoginUserModel userModel = loginService.loggedInUserModel;

              if (userModel != null || email != null) {
                Settings.clearCache();
                loginService.singOut();
                context.read<EmailLoginService>().signOut();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User Logged Out!'),
                  ),
                );

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                    (route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No user Logged in '),
                  ),
                );
              }
            },
            button2Text: 'No',
            btn2Func: () {
              Navigator.of(alertContext, rootNavigator: true).pop();
            },
          );
        });
  }
}
