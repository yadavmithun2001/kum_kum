import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kum_kum/Pages/home.dart';
import 'package:kum_kum/Pages/hometabcontroller.dart';
import 'package:kum_kum/Pages/login.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ValueNotifier<userModel.User> currentUser = new ValueNotifier(userModel.User());

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    respo.getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    if (prefs.containsKey('current_user')) {
      currentUser.value = userModel.User.fromJson(
          await json.decode(prefs.get('current_user').toString()));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeTabController()));
      currentUser.value.active = true;
    } else {
      closeSplashScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/kum kum without background.png", height: 120),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Kum", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
                  Text("Kum", style: TextStyle(fontSize: 25))
                ],
              ),
            ],
          )
      ),
    );
  }


  void closeSplashScreen() async {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }
}
