import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kum_kum/Pages/bookmark.dart';
import 'package:kum_kum/Pages/home.dart';
import 'package:kum_kum/Pages/messages.dart';
import 'package:kum_kum/Pages/profile.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;

import '../constraint.dart';
import '../repository/user_repository.dart';

class HomeTabController extends StatefulWidget {
  @override
  _HomeTabControllerState createState() => _HomeTabControllerState();
}

class _HomeTabControllerState extends State<HomeTabController> {
  int selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookmarkPage(),
    MessagePage(selectedtab: 0),
    ProfilePage()
  ];



  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/ugroup.png"),
                color: selectedIndex == 0 ? pColor : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/save.png"),
                color: selectedIndex == 1 ? pColor : Colors.grey,
              ),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/messages-3.png"),
                color: selectedIndex == 2 ? pColor : Colors.grey,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/profile.png"),
                color: selectedIndex == 3 ? pColor : Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: sColor,
          onTap: _onItemTapped,
          elevation: 5),
      body: SafeArea(child: _widgetOptions.elementAt(selectedIndex)),
    );
  }
}
