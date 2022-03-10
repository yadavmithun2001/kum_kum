import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:kum_kum/Pages/aboutus.dart';
import 'package:kum_kum/Pages/contactus.dart';
import 'package:kum_kum/Pages/login.dart';
import 'package:kum_kum/Pages/register_details.dart';
import 'package:kum_kum/Pages/termsandconditions.dart';
import 'package:kum_kum/constraint.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/repository/user_repository.dart';
import 'package:kum_kum/models/ImageModel.dart' as imageModel;
import 'package:nb_utils/nb_utils.dart';

class MyProfilePage extends StatefulWidget {
  final int selectedtab;
  const MyProfilePage({Key? key, required this.selectedtab}) : super(key: key);
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int tab = 0;
  int position = 0;
  List<imageModel.Image> _images = [];
  List<userModel.User> _users = [];
  userModel.User _currentuser = new userModel.User();

  @override
  void initState() {
    super.initState();
    tab = widget.selectedtab;
    respo.getallusers().then((value){
      setState(() {
        _users.addAll(value);
      });
    });
    getdata();
  }

  Future<void> getdata() async {
    respo.getCurrentUser();
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    //prefs.clear();
    if (prefs.containsKey('current_user')) {
      currentUser.value = userModel.User.fromJson(await json.decode(prefs.get('current_user').toString()));
      currentUser.value.active = true;
    }
  }



  Future<void> matcuser() async {
    setState(() {
      for(int i = 0;i <_users.length;i++){
        if(respo.currentUser.value.userid == _users[i].userid){
          position = i;
        }
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    matcuser();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
            decoration: BoxDecoration(
                color: pColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterDetails()));
                      },
                      child: Text('Edit Profile',style: TextStyle(color: Colors.white,fontSize: 18),)),
                ],
              ),
            )),
        elevation: 0,
      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/back.png")
                      ),
                      SizedBox(width: 10),
                      Center(
                        child: Text(
                          "My Profile",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ),
                Center(
                    child: ImageSlideshow(
                      height: 330,
                      children: [
                        Image.network(respo.currentUser.value.avatar.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                        Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+_users[position].img1.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                        Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+_users[position].img2.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                        Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+_users[position].img3.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                      ],
                    )
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  tab = 0;
                                });
                                },
                                child: Text("Account",style: TextStyle(color: tab == 0 ? pColor : Colors.black,fontSize: 20,fontWeight: FontWeight.bold))
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 2.5,
                              decoration: BoxDecoration(
                                color: tab == 0 ? pColor : Colors.black
                              ),
                              child: Text('                 '),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap:(){
                                  setState(() {
                                    tab = 1 ;
                                  });
                                },
                                child: Text("Professional",style: TextStyle(color: tab == 1 ? pColor : Colors.black,fontSize: 20,fontWeight: FontWeight.bold))
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 2.5,
                              decoration: BoxDecoration(
                                  color: tab == 1 ? pColor : Colors.black
                              ),
                              child: Text('                           '),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                tab == 0 ?
                    Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(25),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Name',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),
                             Text('Contact',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),
                             Text('Gender',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),
                             Text('Height',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),
                             Text('Birthdate',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),
                             Text('Caste',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),
                             Text('City',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                             SizedBox(height: 15),

                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0, 25, 25, 25),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(currentUser.value.name == 'null' ? 'No Data Found' : currentUser.value.name ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                             Text(currentUser.value.mobile == 'null' ? 'No Data Found' : currentUser.value.mobile,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                             Text(respo.currentUser.value.sex.toString() == 'null' ? 'No Data Found' : currentUser.value.sex,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                             Text(respo.currentUser.value.height == 'null' ? 'No Data Found' : currentUser.value.height ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                             Text(respo.currentUser.value.dob == 'null' ? 'No Data Found' : currentUser.value.dob,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                             Text(respo.currentUser.value.caste == 'null' ? 'No Data Found' : respo.currentUser.value.caste,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                             Text(respo.currentUser.value.short_address == 'null' ? 'No Data Found' : respo.currentUser.value.short_address,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                             SizedBox(height: 15),
                           ],
                         ),
                       )
                     ],
                    ):Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Qualification',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                          SizedBox(height: 15),
                          Text('Ouccupation',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 25, 25, 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentUser.value.qualification == 'null' ? 'No Data Found' : respo.currentUser.value.qualification,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          SizedBox(height: 15),
                          Text(currentUser.value.occupation == 'null' ? 'No Data Found' : respo.currentUser.value.occupation,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                )

                

              ],
            ),
          ),
        ),
      ),
    );
  }
}
