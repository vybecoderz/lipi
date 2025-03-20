import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_tagalog/screens/login_detail.dart';
import 'package:learn_tagalog/services/email_login_service.dart';
import 'package:learn_tagalog/widgets/custom_button.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';
import 'package:provider/provider.dart';


/// This is the register ui screen
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
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
                 // _showUsernameInput(),
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
      'Register',
      style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    );
  }

/*  _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _username = val,
        validator: (val) => val.length < 6 ? 'Username is too short.' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            hintText: 'Enter Valid Username',
            icon: Icon(
              Icons.face,
              color: Colors.grey,
            )),
      ),
    );
  }*/


  _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _email = val.trim(),
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
                  onTap: _submit,
                  child: CustomButton(
                    buttonText: 'Register',
                    margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                  ),
                ),
          FlatButton(
            child: Text(
              'Existing User? Login',
              style: TextStyle(color: Colors.blue.shade400),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
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
      _registerUser();
    } else {
      print('Form is Invalid');
    }
  }

  _registerUser() async {
    setState(() {
      _isSubmitting = true;
    });

    final logMessage = await context
        .read<EmailLoginService>()
        .signUp(email: _email, password: _password);

    logMessage == 'Signed Up'
        ? _showSuccessSnack(logMessage)
        : _showErrorSnack(logMessage);

    print(logMessage);

    if (logMessage == 'Signed Up') {
      createUserInFirestore();
    } else {
      setState(() {

        _isSubmitting = false;
      });
    }
  }


  _showSuccessSnack(String message) {
    final snackbar = SnackBar(
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
      content: Text(
        '$message',
        style: TextStyle(color: Colors.red),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  createUserInFirestore() async {
    context.read<EmailLoginService>().addUserToDB(
        uid: auth.currentUser.uid,
        displayName: auth.currentUser.displayName,
        email: auth.currentUser.email,
        timestamp: timestamp);
    _redirectUser();
  }

  _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
    });
  }
}
