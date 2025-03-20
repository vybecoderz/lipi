import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_tagalog/screens/bottom_nav_bar.dart';
import 'package:learn_tagalog/screens/register_detail.dart';
import 'package:learn_tagalog/screens/welcome_detail.dart';
import 'package:learn_tagalog/services/email_login_service.dart';
import 'package:learn_tagalog/widgets/custom_button.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  String _email, _password;
  bool _isSubmitting;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ThemeColor(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _showTitle(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showTitle() {
    return Text(
      'Login',
      style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    );
  }

  _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _email = val,
        validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter Valid Email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _password = val,
        validator: (val) => val.length < 6 ? 'Password Is Too Short' : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child:
              Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            ),
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter Valid Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

  _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          )
              : GestureDetector(
            onTap:
              _submit
            ,
            child: CustomButton(
              buttonText: 'Login',
              margin: EdgeInsets.only(left: 80, right: 80, top: 20),
            ),
          ),
          GestureDetector(
            onTap:(){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                      (route) => false);
            }
            ,
            child: CustomButton(
              buttonText: 'Cancel',
              margin: EdgeInsets.only(left: 80, right: 80, top: 20),
            ),
          ),
         FlatButton(
           child: Text('New User? Register', style: TextStyle(color: Colors.blue.shade400),),
           onPressed: () {
             Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(builder: (context) => RegisterPage()),
                 (route) => false);
           },
         )
        ],
      ),
    );
  }

  _submit() {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      //print('Email $_email, Password $_password');
      _LoginUser();
    } else {
      print('Form is Invalid');
    }
  }

  _LoginUser() async {
    setState(() {
      _isSubmitting = true;
    });

    final logMessage = await context
        .read<EmailLoginService>()
        .signIn(email: _email, password: _password);

    logMessage == 'Signed In'
        ? _showSuccessSnack(logMessage)
        : _showErrorSnack(logMessage);

    //print('I am logMessage $logMessage');

    if (logMessage == 'Signed In') {
      _redirectUser();
      return;
    } else {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  _showSuccessSnack(String message) async {
    final snackbar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        '$message',
        style: TextStyle(color: Colors.green),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  _showErrorSnack(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        '$message',
        style: TextStyle(color: Colors.red),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
    setState(() {
      _isSubmitting = false;
    });
  }

 _redirectUser() {
   Future.delayed(Duration(seconds: 2), () {
     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(builder: (context) => BottomNavBar()),
         (Route<dynamic> route) => false);
   });
 }
}