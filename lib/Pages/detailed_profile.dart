import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:kum_kum/config/config.dart';
import 'package:kum_kum/constraint.dart';
import 'package:kum_kum/network/api.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:http/http.dart' as http;

import '../repository/user_repository.dart';

class DetailedProfilePage extends StatefulWidget {
  final userModel.User user;
  final int selectedtab;
  const DetailedProfilePage({Key? key, required this.selectedtab, required this.user}) : super(key: key);

  @override
  State<DetailedProfilePage> createState() => _DetailedProfilePageState();
}

class _DetailedProfilePageState extends State<DetailedProfilePage> {
  int tab = 0;
  @override
  void initState() {
    super.initState();
    tab = widget.selectedtab;
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

  Future<void> connectrequest() async{
    String url = MyConfig.appApiUrl + API.addvisitor;
    final client = new http.Client();
    final response = await client.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'visitor_id':widget.user.userid,
          'user_id':respo.currentUser.value.userid
        }
    );
    if (response.statusCode == 200) {
      if(json.decode(response.body)['status'] == 1 ){
        toast('Request Sent successfully');
        Navigator.pop(context);
      }
    }
  }





  @override
  Widget build(BuildContext context) {
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
                        connectrequest();
                      },
                      child: Text('Connect Request',style: TextStyle(color: Colors.white,fontSize: 18),)),
                ],
              ),
            )),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Stack(
                children: [
                  Center(
                      child: ImageSlideshow(
                        height: 350,
                       children: [
                         Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+widget.user.avatar.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                         Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+widget.user.img1.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                         Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+widget.user.img2.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                         Image.network("https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/"+widget.user.img3.toString(),width:MediaQuery.of(context).size.width,height: 400,fit: BoxFit.cover,),
                       ],
                      )
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.user.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: whiteColor),),
                                Text(widget.user.dob == 'null' ? 'No Data ' : widget.user.dob +" | " +widget.user.height,style: TextStyle(fontSize: 18,color: whiteColor),),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width*0.4),
                            Container(
                              decoration: BoxDecoration(
                                  color: pColor,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Image.asset("assets/save@2x.png",height: 15,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),),
                  )
                ],
              ),
            ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap:(){
                              setState(() {
                                tab = 0;
                              });
                            },
                            child: Text("Perosnal Info",style: TextStyle(color: tab == 0 ? pColor : Colors.black,fontSize: 20,fontWeight: FontWeight.bold))
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 2.5,
                          decoration: BoxDecoration(
                              color: tab == 0 ? pColor : Colors.black
                          ),
                          child: Text('              '),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap:(){
                              setState(() {
                                tab = 1 ;
                              });
                            },
                            child: Text("Professional info",style: TextStyle(color: tab == 1 ? pColor : Colors.black,fontSize: 20,fontWeight: FontWeight.bold))
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 2.5,
                          decoration: BoxDecoration(
                              color: tab == 1 ? pColor : Colors.black
                          ),
                          child: Text('                  '),
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
                      Text('Gender',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                      SizedBox(height: 15),
                      Text('Caste',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                      SizedBox(height: 15),
                      Text('Contact',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
                      SizedBox(height: 15),
                      Text('Address',style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 25, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.sex == 'null' ? 'No Data Found' : widget.user.sex.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text(widget.user.caste == 'null' ? 'No Data Found' : widget.user.caste,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text(widget.user.mobile == 'null' ? 'No Data Found' : widget.user.mobile,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text(widget.user.short_address == 'null' ? 'No Data Found' : widget.user.short_address,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
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
                      Text(widget.user.qualification == 'null' ? 'No Data Found' : widget.user.qualification,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text(widget.user.occupation == 'null' ? 'No Data Found' : widget.user.occupation,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
