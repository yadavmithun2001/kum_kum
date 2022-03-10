import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kum_kum/Pages/profilepictures.dart';
import 'package:kum_kum/repository/user_repository.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../constraint.dart';
import '../translations/local_keys.dart';
import 'hometabcontroller.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:kum_kum/repository/fetchdatarepository.dart' as fetch;
import 'package:kum_kum/models/height_model.dart' as heightmodel;

class RegisterDetails extends StatefulWidget {
  const RegisterDetails({Key? key}) : super(key: key);

  @override
  State<RegisterDetails> createState() => _RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  userModel.User user = new userModel.User();

  List<String> list = ['Male','Female'];
  List<heightmodel.Height> _listheight = [];
  String? selectedheight;

  String? ex1;
  String? gender;
  String? height;

  void initState() {
    super.initState();
    fetch.height().then((value){
      setState(() {
        _listheight.addAll(value);
      });
    });
    getData();
  }

  Future<void> getData() async {
    respo.getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      currentUser.value = userModel.User.fromJson(await json.decode(prefs.get('current_user').toString()));
      currentUser.value.active = true;
    } else {
    }
  }




  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                        user.devicetoken = 'doiewo';
                        user.devicetype = 'ANDROID';
                        respo.userupdate(currentUser.value.userid.toString(),user.mobile.toString(), user.devicetoken.toString(), user.devicetype.toString(), gender.toString(), user.height.toString(), user.dob.toString(), user.caste.toString(), user.short_address.toString(), user.qualification.toString(), user.occupation.toString()).whenComplete(() => 
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePictures()))
                        );

                      },
                      child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 18),)),
                ],
              ),
            )),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/back.png")
                    ),
                    Text(
                      "Tell us about you",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Hi, My Phone Number is ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style : TextStyle(fontSize: 18,color: pColor),
                        onChanged : (value) => user.mobile = value,
                        keyboardType: TextInputType.number,
                        decoration : InputDecoration(
                          border : InputBorder.none,
                          hintText : respo.currentUser.value.mobile,
                          hintStyle : TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),

                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 15),
                      Text("I am ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.sex = value,
                        onTap:() {
                          hideKeyboard(context);
                          SelectDialog.showModal<String>(
                              context,
                              label: "Select Gender",
                              titleStyle: TextStyle(color: pColor),
                              showSearchBox: false,
                              backgroundColor: Colors.white,
                              selectedValue: ex1,
                              items: List.generate(2, (index) => list[index]),
                              onChange: (String selected) {
                                setState(() {
                                  if(selected =='Male'){
                                    gender = '1';
                                    ex1 = selected;
                                  }else{
                                    gender = '2';
                                    ex1 = selected;
                                  }
                                });
                              },
                            );
                          },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ex1 == null ? 'select You gender' : ex1,
                          hintStyle: TextStyle(fontSize: 18,color: ex1 == null ? Colors.grey.shade400 : pColor),
                        ),

                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 15),
                      Text("My height is ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        onTap: (){
                          SelectDialog.showModal<String>(
                            context,
                            label: "Select Height",
                            titleStyle: TextStyle(color: pColor),
                            showSearchBox: false,
                            backgroundColor: Colors.white,
                            selectedValue: selectedheight,
                            items: List.generate(_listheight.length, (index) => _listheight[index].height.toString()),
                            onChange: (selected) {
                              setState(() {
                                selectedheight = selected;
                              });
                            },
                          );
                        },
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.height = value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: selectedheight == null ? "select your height " : selectedheight,
                          hintStyle: TextStyle(fontSize: 18 , color: selectedheight == null ? Colors.grey.shade400 : pColor),
                        ),
                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 15),
                      Text("I born on ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextField(
                        onTap: () async {
                          var date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2021));
                          toast(date.toString()+"h");
                        },
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.dob = value,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter you date of birth ",
                          hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),
                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 15),

                      Text("I am living at ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.short_address = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter you short address ",
                          hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),
                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 20),
                      Text('Professional info',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text("Education",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.qualification = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter you education details ",
                          hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),
                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 15),
                      Text("I am working as",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.occupation = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter you profession ",
                          hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),
                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
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
