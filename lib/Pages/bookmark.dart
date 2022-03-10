import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../repository/user_repository.dart';
import 'detailed_profile.dart';
import 'home.dart' as home;
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'home.dart' as home;

import '../constraint.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<userModel.User> _users = [];

  @override
  void initState() {
    super.initState();
    getSavedUser();
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
  Future<void> getSavedUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: whiteColor,
        title: Row(
          children: [
            Text('Bookmarks',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23)),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,position){
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(_users[position].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Expanded(child: SizedBox()),
                      Text(_users[position].dob == 'null' ? 'No data' : _users[position].dob  +" | "+ _users[position].height +" "),

                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedProfilePage(selectedtab: 0,user: _users[position])));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_users[position].mobile == 'null' ? 'No data found' : _users[position].mobile,maxLines:1,style: TextStyle(color: Colors.grey,fontSize: 18)),
                              Text(_users[position].short_address == 'null' ? 'No data found' : _users[position].short_address,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 18)),
                              Text(_users[position].qualification == 'null' ? 'No data found' : _users[position].qualification,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 18)),
                              Text(_users[position].occupation == 'null' ? 'No data found' : _users[position].occupation,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network('https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/'+_users[position].avatar,height: 120,width: 120,fit: BoxFit.cover,)),
                              SizedBox(width: 20),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network('https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/'+_users[position].img1.toString(),height: 120,width: 120,fit: BoxFit.cover,)),
                              SizedBox(width: 20),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network('https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/'+_users[position].img2.toString(),height: 120,width: 120,fit: BoxFit.cover,)),
                              SizedBox(width: 20),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network('https://beautyandessentials.shop/Matrimonixadmin/assets/images/user/'+_users[position].img3.toString(),height: 120,width: 120,fit: BoxFit.cover,)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: pColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedProfilePage(selectedtab: 0,user: _users[position])));
                                    },
                                    child: Row(
                                      children: [
                                        Center(
                                            child: Text("More info",style: TextStyle(color: pColor,fontSize: 16),)
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: pColor,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10,5, 10, 5),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Row(
                                  children: [
                                    Center(
                                        child: Text("Connect Request",style: TextStyle(color: Colors.white,fontSize: 16),)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
      )

    );
  }
}
