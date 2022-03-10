import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kum_kum/Pages/detailed_profile.dart';
import 'package:kum_kum/constraint.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:nb_utils/nb_utils.dart';
import '../repository/user_repository.dart';
import 'package:kum_kum/models/ImageModel.dart' as imageModel;
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  userModel.User user = new userModel.User();
  List<userModel.User> _users = [];
  List<imageModel.Image> images1 = [];
  List<imageModel.Image> images2 = [];


  @override
  void initState() {
    super.initState();
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
       for(int i=0;i<_users.length;i++){
         if(respo.currentUser.value.userid == _users[i].userid){
           _users.removeAt(i);
         }
       }
     });
  }

  Future<List<userModel.User>> saveuser (int position) async {
    List<userModel.User> list = [];
    list.add(_users[position]);
    return list;
  }

 Future<void> setSavedUser(int position) async {

  }




  @override
  Widget build(BuildContext context) {
    matcuser();
    return Scaffold(
      appBar: AppBar(backgroundColor: whiteColor,
          title: Row(
            children: [
              Text('Kum',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23)),
              Text('Kum',style: TextStyle(color: Colors.black,fontSize: 23)),
              Expanded(child: SizedBox()),
              Text('Set Prefrences',style: TextStyle(color: pColor,fontSize: 17,fontWeight: FontWeight.bold))
            ],
          ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _users.length,
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
                          child: InkWell(
                            onTap: (){
                              setSavedUser(position);
                              toast('saved to bookmarks');
                            }, child: Image.asset("assets/save@2x.png",height: 15,)),
                        ),
                      ),
                    ),
                  ),

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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedProfilePage(selectedtab: 0,user: _users[position],)));
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
      ),

    );
  }
}
