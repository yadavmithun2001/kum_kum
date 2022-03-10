
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kum_kum/Pages/hometabcontroller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;
import 'package:kum_kum/helper/dialog.dart' as dilaog ;
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../config/config.dart';
import '../constraint.dart';
import '../network/api.dart';
import '../repository/user_repository.dart';

class ProfilePictures extends StatefulWidget {
  const ProfilePictures({Key? key}) : super(key: key);

  @override
  State<ProfilePictures> createState() => _ProfilePicturesState();
}

class _ProfilePicturesState extends State<ProfilePictures> {

  File? _image1;
  File? _image2;
  File? _image3;
  File? _image4;
  final ImagePicker _picker = ImagePicker();
  Future get1stImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image1 = File(pickedFile!.path);
    });
  }
  Future get2stImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image2 = File(pickedFile!.path);
    });
  }
  Future get3stImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image3 = File(pickedFile!.path);
    });
  }
  Future get4stImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image4 = File(pickedFile!.path);
    });
  }

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
      currentUser.value = userModel.User.fromJson(await json.decode(prefs.get('current_user').toString()));
      currentUser.value.active = true;
    }
  }





  showLoaderDialog(BuildContext context,String title){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text(title)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<void> uploadsliderpics(File image) async {
    String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/imageIn';
    var request = new http.MultipartRequest("POST",Uri.parse(url));
    request.fields['user_id'] = currentUser.value.userid;
    request.files.add(await http.MultipartFile.fromPath(
      'image',image.path,
    )
    );
    request.send().then((response) {
      if(response.statusCode == 200){
        toast('Images Uploaded');
      }
    });
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
                      onTap: () async {
                        if(_image1 == null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTabController()));
                        }else if(_image2 == null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTabController()));
                        }else if(_image3 == null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTabController()));
                        }else if(_image4 == null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTabController()));
                        }else{
                          respo.uploadprofilepic(_image1!);
                          respo.uploadimg1(_image2!);
                          respo.uploadimg2(_image3!);
                          respo.uploadimg3(_image4!);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTabController()));
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
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        "Add profile pictures",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text('as per the servey 79.50% of people select profile based on picture you set as profile picture.',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text('so upload your best profile picture',style: TextStyle(fontSize: 16)),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        get1stImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(00),
                                child: _image1 == null ? Image.asset("assets/camera@3x.png",height: 120,width: 120) : Image.file(File(_image1!.path),height: 120,width: 120,fit: BoxFit.cover,),
                              )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        get2stImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(00),
                                child: _image2 == null ? Image.asset("assets/camera@3x.png",height: 120,width: 120) : Image.file(File(_image2!.path),height: 120,width: 120,fit: BoxFit.cover,),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        get3stImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(00),
                                child: _image3 == null ? Image.asset("assets/camera@3x.png",height: 120,width: 120) : Image.file(File(_image3!.path),height: 120,width: 120,fit: BoxFit.cover,),
                              )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        get4stImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(00),
                                child: _image4 == null ? Image.asset("assets/camera@3x.png",height: 120,width: 120) : Image.file(File(_image4!.path),height: 120,width: 120,fit: BoxFit.cover,),
                              )),
                        ),
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


