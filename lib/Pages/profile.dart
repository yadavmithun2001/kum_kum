import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kum_kum/Pages/aboutus.dart';
import 'package:kum_kum/Pages/contactus.dart';
import 'package:kum_kum/Pages/login.dart';
import 'package:kum_kum/Pages/myprofile.dart';
import 'package:kum_kum/Pages/termsandconditions.dart';
import 'package:kum_kum/constraint.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/repository/user_repository.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getdata();
    }

  Future<void> getdata() async {
    respo.getCurrentUser();
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    //prefs.clear();
    if (prefs.containsKey('current_user')) {
      respo.currentUser.value = userModel.User.fromJson(await json.decode(prefs.get('current_user').toString()));
      respo.currentUser.value.active = true;
     }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text("Account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23)),
                      Expanded(child: SizedBox()),
                      InkWell(
                        onTap: (){
                          respo.logout();
                          Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                          child: Text("Logout",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.grey))),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Row(
                    children: [
                      ClipRRect(
                        child: Image.network(respo.currentUser.value.avatar,height: 120,width: 100,fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hey",style: TextStyle(fontSize: 20)),
                          Text(respo.currentUser.value.name.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage(selectedtab: 0)));
                            },
                              child: Text("View profile",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.grey))),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: pColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('You\'re Subscribed',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                            Text("Premium Plan",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.grey.shade400)),

                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          children: [
                            Image.asset("assets/back-1@2x.png",color: Colors.white,height: 20),
                            SizedBox(height: 20)
                          ],
                        )

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ContactUsPage()
                      ));
                    },
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            Text("Let us know about your feedback & queries",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey.shade400)),

                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          children: [
                            Image.asset("assets/back-1@2x.png",color: Colors.black,height: 20),
                            SizedBox(height: 20)
                          ],
                        )

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15,15),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AboutusPage()
                      ));
                    },
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            Text("know who we are & how we started.",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey.shade400)),

                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          children: [
                            Image.asset("assets/back-1@2x.png",color: Colors.black,height: 20),
                            SizedBox(height: 20)
                          ],
                        )

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TermsandConditionPage()
                      ));
                    },
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Terms & Conditions',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            Text("Read Company's terms & conditions",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey.shade400)),

                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          children: [
                            Image.asset("assets/back-1@2x.png",color: Colors.black,height: 20),
                            SizedBox(height: 20)
                          ],
                        )

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rate us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          Text("Show your love by rate us on playstore.",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey.shade400)),

                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Column(
                        children: [
                          Image.asset("assets/back-1@2x.png",color: Colors.black,height: 20),
                          SizedBox(height: 20)
                        ],
                      )

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
