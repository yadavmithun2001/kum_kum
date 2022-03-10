import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kum_kum/Pages/chatdetails.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../constraint.dart';
import '../network/api.dart';
import '../repository/user_repository.dart';
import 'detailed_profile.dart';


class MessagePage extends StatefulWidget {
  final int selectedtab;
  const MessagePage({Key? key, required this.selectedtab}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  int tab = 0;
  List<userModel.User> _users = [];
  List<userModel.User> _accepted_users = [];
  List<userModel.User> _pending_users = [];

  String messages = '';
  bool error = false;



  @override
  void initState() {
    super.initState();
    tab = widget.selectedtab;
    getallusers().then((value){
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

  Future<List<userModel.User>> getallusers() async{
    String url = MyConfig.appApiUrl + API.getvisitor;
    List<userModel.User> list1 = [];
    final client = new http.Client();
    final response = await client.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'user_id':respo.currentUser.value.userid
        }
    );

    if(response.statusCode == 200){
      if(json.decode(response.body)['status'] == 1){
        var list = json.decode(response.body)['data'];
        for(var value in list){
          list1.add(userModel.User.fromJson(value));
        }
      }else{
        messages = 'You don have any request';
      }
    }
    return list1;
  }

  Future<void> addaccepted(position) async{
    _accepted_users.add(_users[position]);
  }
  Future<void> pendingaccepted(position) async{
    _pending_users.add(_users[position]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(backgroundColor: whiteColor,
        toolbarHeight: 110,
        title: Column(
          children: [
            Row(
              children: [
                Text('Chats',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23)),
                Expanded(child: SizedBox()),
                Image.asset('assets/search@2x.png',height: 20)
              ],
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        tab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Text('Accepted',style: TextStyle(color: tab == 0 ? pColor : Colors.black,fontSize: 17)),
                        SizedBox(height: 5),
                        Container(
                          height: 2.5,
                          decoration: BoxDecoration(
                              color: tab == 0 ? pColor : Colors.black
                          ),
                          child: Text('             '),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: (){
                      setState(() {
                        tab = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Text('New Requests',style: TextStyle(color: tab == 1 ? pColor : Colors.black,fontSize: 17)),
                        SizedBox(height: 5),
                        Container(
                          height: 2.5,
                          decoration: BoxDecoration(
                              color: tab == 1 ? pColor : Colors.black
                          ),
                          child: Text('             '),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: (){
                      setState(() {
                        tab = 2;
                      });
                    },
                    child: Column(
                      children: [
                        Text('Pending Requests',style: TextStyle(color: tab == 2 ? pColor : Colors.black,fontSize: 17)),
                        SizedBox(height: 5),
                        Container(
                          height: 2.5,
                          decoration: BoxDecoration(
                              color: tab == 2 ? pColor : Colors.black
                          ),
                          child: Text('             '),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: showwidget()

    );


  }
  showwidget(){
    if(tab == 0){
      return ListView.builder(
          itemCount: _accepted_users.length,
          itemBuilder: (context,position){
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  color: whiteColor,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: Image.network(_accepted_users[position].avatar,height: 70,width: 70,fit: BoxFit.cover)) ,
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_accepted_users[position].name,style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold)),
                          Text('messge',style: TextStyle(color: Colors.grey,fontSize: 16)),
                          Text(DateTime.now().toString(),style: TextStyle(color: Colors.grey,fontSize: 12))
                        ],
                      )

                    ],
                  ),
                ),
              )
            );
          }
      );
    }else if(tab == 1){
      return ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context,position){
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Container(
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(5),
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
                                        toast('add to pending');
                                        pendingaccepted(position);
                                      }, child: Image.asset("assets/close@2x.png",height: 15,color: pColor,)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5)

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
                                      child: Image.network(_users[position].avatar,height: 120,width: 120,fit: BoxFit.cover,)),
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
                                      toast('request accepted');
                                      addaccepted(position);
                                    },
                                    child: Row(
                                      children: [
                                        Center(
                                            child: Text("Accept Request",style: TextStyle(color: Colors.white,fontSize: 16),)
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
                ),
              ),
            );
          }
      );
    }else {
      return ListView.builder(
          itemCount: _pending_users.length,
          itemBuilder: (context,position){
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: Container(
                color: whiteColor,
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
                                    child: Image.network(_users[position].avatar,height: 120,width: 120,fit: BoxFit.cover,)),
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
                                          child: Text("Accept Request",style: TextStyle(color: Colors.white,fontSize: 16),)
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
              ),
            );
          }
      );
    }
  }
}
