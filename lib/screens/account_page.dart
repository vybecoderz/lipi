import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:learn_tagalog/widgets/icon_widget.dart';

class AccountPage extends StatelessWidget {

  static const keyPassword = 'key-password';
  
  
  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
      title: 'Account Settings',
    subtitle: 'Privacy, Security, Language',
    leading: IconWidget(icon: Icons.person, color: Colors.green,),
    child: SettingsScreen(
        title: 'Account Settings',
        children: <Widget>[
          buildPassword(),
          buildPrivacy(context),
          buildSecurity(context),
          buildAccountInfo(context),
        ]),
  );

  Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
    title: 'Privacy',
    subtitle: '',
    leading: IconWidget(icon: Icons.lock, color: Colors.blue,),
    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Clicked Privacy'),
      ),
    ),
  );

  Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
    title: 'Security',
    subtitle: '',
    leading: IconWidget(icon: Icons.security, color: Colors.red,),
    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Clicked Security'),
      ),
    ),
  );

  Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
    title: 'Account Info',
    subtitle: '',
    leading: IconWidget(icon: Icons.text_snippet, color: Colors.purple,),
    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Clicked Account Info'),
      ),
    ),
  );
  
  Widget buildPassword() => TextInputSettingsTile(
      title: 'Password',
      settingKey: keyPassword,
      obscureText: true,
      enabled: true,
      validator: (password) => password != null && password.length >= 6 ? null : 'Enter 6 characters',);
}