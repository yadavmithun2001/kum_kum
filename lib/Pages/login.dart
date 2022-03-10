import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kum_kum/Pages/register.dart';
import 'package:kum_kum/Pages/register_details.dart';
import 'package:kum_kum/translations/local_keys.dart';
import 'package:kum_kum/models/user_model.dart' as model;
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:nb_utils/nb_utils.dart';

import '../constraint.dart';
import 'hometabcontroller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  model.User user = new model.User();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<model.User> currentUser = new ValueNotifier(model.User());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "Sign in to",
                      style: TextStyle(fontSize: 20),
                    ),
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
                  TextFormField(
                    style: TextStyle(fontSize: 18,color: pColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your email address",
                      hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => user.email = value,
                    validator: (value) => value!.isEmpty
                        ? LocaleKeys.field_required.trim()
                        : !value.contains('@') || !value.contains('.')
                        ? LocaleKeys.invalid_email.trim()
                        : null,
                  ),
                  SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                  SizedBox(height: 25),
                  Text("Shssss my password is",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(fontSize: 18,color: pColor),
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) => user.password = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your password",
                            hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                          ),
                          validator: (value) => value!.length < 6
                              ? LocaleKeys.password_validation.trim()
                              : null,
                        ),
                      ),
                      Text("Forgot?",style: TextStyle(color: pColor,fontSize: 17,fontWeight: FontWeight.w700))
                    ],
                  ),
                  SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: pColor,
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                user.devicetoken = 'fesdf';
                                user.devicetype = 'ANDROID';
                                hideKeyboard(context);
                                respo.login(user.email.toString(), user.password.toString(), user.devicetoken.toString(),user.devicetype.toString()).whenComplete(() =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterDetails()))
                                );
                              }
                            },
                            child: Center(
                                child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 16),)
                            ),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Center(child: Text("Oh ! Not Registered yet?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: pColor,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => RegistrationPage()
                                  ));
                                },
                                child: Center(
                                    child: Text("Register Now",style: TextStyle(color: pColor,fontSize: 16),)
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
