import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:learn_tagalog/animation/delayed_animation.dart';
import 'package:learn_tagalog/screens/bottom_nav_bar.dart';
import 'package:learn_tagalog/models/login_user_model.dart';
import 'package:learn_tagalog/screens/login_detail.dart';
import 'package:learn_tagalog/screens/register_detail.dart';
import 'package:learn_tagalog/services/google_login_service.dart';
import 'package:learn_tagalog/widgets/custom_button.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  LoginUserModel _userModel;

  LoginUserModel get loggedInUserModel => _userModel;

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleLoginService loginService =
        Provider.of<GoogleLoginService>(context, listen: false);

    final color = Colors.white;
    _scale = 1 - _controller.value;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ThemeColor(
          child: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  AvatarGlow(
                    endRadius: 90,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white24,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 2),
                    startDelay: Duration(seconds: 1),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/splash_800.png',
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    ),
                  ),
                  DelayedAnimation(
                    child: Text(
                      'Learn Tagalog',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: color),
                    ),
                    delay: delayedAmount + 1000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      'Learn Anywhere!',
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 30.0,
                          color: color),
                    ),
                    delay: delayedAmount + 2000,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DelayedAnimation(
                    child: Text(
                      'Your New Personal',
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      'Study Buddy',
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  DelayedAnimation(
                    child: GestureDetector(
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: CustomButton(
                            buttonText: 'Register',
                          ),
                        ),
                      ),
                    ),
                    delay: delayedAmount + 4000,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DelayedAnimation(
                    child: GestureDetector(
                      onTapUp: _onTapUp,
                      onTapDown: _onTapDown,
                      child: Transform.scale(
                        scale: _scale,
                        child: GestureDetector(
                          onTap: () async {
                            bool success =
                                await loginService.signInWithGoogle();

                            if (success != null) {
                              setState(
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Logged in!'),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavBar(),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: CustomButton(
                            buttonText: 'Sign in with Google',
                          ),
                        ),
                      ),
                    ),
                    delay: delayedAmount + 5000,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DelayedAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'I Already have An Account'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                    ),
                    delay: delayedAmount + 6000,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
