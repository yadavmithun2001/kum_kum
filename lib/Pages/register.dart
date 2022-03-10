import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kum_kum/Pages/home.dart';
import 'package:kum_kum/Pages/login.dart';
import 'package:kum_kum/Pages/register_details.dart';
import 'package:kum_kum/models/user_model.dart' as model;
import 'package:kum_kum/network/api.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/translations/local_keys.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constraint.dart';
import 'hometabcontroller.dart';


class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  model.User user = new model.User();
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
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          user.devicetoken = '4ewef';
                          user.devicetype = 'ANDRIOD';
                          respo.register(user.email.toString(), user.password.String(),user.name.toString(), user.devicetoken.toString(), user.devicetype.toString()).whenComplete(() =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))
                          );

                        }
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
                    Expanded(child: SizedBox()),
                    Center(
                      child: Text(
                        "Register Now",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Image.asset("assets/kum kum without background.png",height: 100)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kum",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                    Text("Kum",style: TextStyle(fontSize: 25))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text("My Email address is ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => user.email = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your email address",
                          hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),
                        validator: (value) => value!.isEmpty
                            ? LocaleKeys.field_required.trim()
                            : !value.contains('@') || !value.contains('.')
                            ? LocaleKeys.invalid_email.trim()
                            : null,
                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 25),
                      Text("My Name is ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        onChanged: (value) => user.name = value,
                        validator: (value) => value!.length < 3
                            ? 'name should be atleast 3 letters'
                            : null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your profile name",

                          hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                        ),

                      ),
                      SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                      SizedBox(height: 25),
                      Text("Set my password as ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      TextFormField(
                        style: TextStyle(fontSize: 18,color: pColor),
                        obscureText: true,
                        onChanged: (value) => user.password = value,
                        validator: (value) => value!.length < 6
                            ? LocaleKeys.password_validation.trim()
                            : null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Set your Password",
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

