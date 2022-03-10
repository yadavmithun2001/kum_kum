import 'package:flutter/material.dart';
import 'package:kum_kum/Pages/profile.dart';

import '../constraint.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

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
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text('Submit Now',style: TextStyle(color: Colors.white,fontSize: 18),)),
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
                        "",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("We\'re Happy to",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28)),
                    Text("hear from you !!",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 10),
                Text("Let us know about your feedback & queries",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey.shade400)),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: pColor,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: InkWell(
                                  onTap: (){
                                    
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset("assets/call@2x.png",height: 30),
                                      SizedBox(width: 10),
                                      Center(
                                          child: Text("Call us",style: TextStyle(color: pColor,fontSize: 16),)
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
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30,10, 30, 10),
                            child: InkWell(
                              onTap: (){

                              },
                              child: Row(
                                children: [
                                  Image.asset("assets/mail@2x.png",height: 30,color: Colors.white),
                                  SizedBox(width: 10),
                                  Center(
                                      child: Text("Mail us",style: TextStyle(color: Colors.white,fontSize: 16),)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset("assets/mail@2x.png",color: pColor,height: 30),
                    SizedBox(width: 15),
                    Text("Send your message",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)
                  ],
                ),
                SizedBox(height: 50),
                Text("My Email address is ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                TextFormField(
                  style: TextStyle(fontSize: 18,color: pColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your email address",
                    hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                SizedBox(height: 25),
                Text("My Concern is ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                TextFormField(
                  style: TextStyle(fontSize: 18,color: pColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter you feedback or query",
                    hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade400),)),
                






              ],
            ),
          ),
        ),
      ),
    );
  }
}
