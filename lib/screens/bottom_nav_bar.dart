import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_tagalog/screens/collection_detail.dart';
import 'package:learn_tagalog/screens/profile_detail.dart';
import 'package:learn_tagalog/screens/topics_detail.dart';
import '../models/lesson.dart';


class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  Lesson content;
  int _selectedIndex = 0;
  int index = 0;

  final _pageOptions = [
    Topics(),
    Collection(),
    ProfilePage(),
  ];

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.home,
      size: 40,
    ),
    Icon(
      FontAwesomeIcons.book,
      size: 30,
    ),
    Icon(
      Icons.person_rounded,
      size: 40,
    )
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFCE2029),
        selectedItemColor: Color.fromRGBO(253, 202, 49, 1.0),
        items: [
          BottomNavigationBarItem(
            icon: _pages.elementAt(0),
            label: 'Topics',
          ),
          BottomNavigationBarItem(
            icon: _pages.elementAt(1),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: _pages.elementAt(2),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
