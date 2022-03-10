import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kum_kum/config/config.dart';
import 'package:kum_kum/network/api.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/models/user_model.dart' as userModel;
import 'package:kum_kum/helper/dialog.dart' as hello;
import 'package:kum_kum/models/ImageModel.dart' as imageModel;

ValueNotifier<userModel.User> currentUser = new ValueNotifier(userModel.User());

Future<userModel.User> login(String email,String password,String device_token,String device_type) async {
  final String url = MyConfig.appApiUrl+API.login;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      'email':email,'password':password,'device_token':device_token,'device_type':device_type,
    }
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    toast('login successful');
    currentUser.value = userModel.User.fromJson(json.decode(response.body)['data']);
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}


  Future<userModel.User> register(String email,String password,String name,String device_token,String device_type) async {
    String url = MyConfig.appApiUrl+API.register;
    final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      encoding: Encoding.getByName('utf-8'),
      body: {
          'email':email,'password':password,'name':name,'device_token':device_token,'device_type':device_type,
      },
    );
    if(response.statusCode == 200){
      toast('Registration Successful');
      setCurrentUser(response.body);
      currentUser.value = userModel.User.fromJson(json.decode(response.body)["data"]);
    }else{
      toast('something went wrong');
    }
    return currentUser.value;
  }

Future<userModel.User> userupdate(String userid,String mobile,String device_token,String device_type,String gender,String height,String dob,String caste,String short_address,String qualification,String occupation) async {
  String url = MyConfig.appApiUrl+API.userInfo;
  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
    body: {
      'user_id':userid,'mobile':mobile,'device_token':device_token,'device_type':device_type,
      'gender':gender,'weight':height,'dob':dob,'complexion':caste,'current_address':short_address,'qualification':qualification,'work_place':occupation
    },
  );
  if(response.statusCode == 200){
    toast('User Updated Successfully');
    setCurrentUser(response.body);
    currentUser.value = userModel.User.fromJson(json.decode(response.body)["data"]);
  }else{
    toast('something went wrong');
  }
  return currentUser.value;
}


  void setCurrentUser(jsonString) async {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
    }
  }



Future<userModel.User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('current_user')) {
    currentUser.value = userModel.User.fromJson(json.decode(await prefs.get('current_user').toString()));
    currentUser.value.active = true;
  } else {
    currentUser.value.active = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<void> logout() async {
  currentUser.value = new userModel.User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

Future<List<userModel.User>> getallusers() async{
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/userlist';
  var response = await http.get(Uri.parse(url));
  List<userModel.User> users = [];
  if(response.statusCode == 200){
    var list = json.decode(response.body)['data'];
    for(var value in list){
      users.add(userModel.User.fromJson(value));
    }
  }
  return users;
}

Future<void> uploadprofilepic(File image) async {
  String url = MyConfig.appApiUrl+API.setprofilepic;
  var request = new http.MultipartRequest("POST",Uri.parse(url));
  request.fields['user_id'] = currentUser.value.userid;
  request.files.add(await http.MultipartFile.fromPath(
    'user_avtar',image.path,
  )
  );
  request.send().then((response) {
    if (response.statusCode == 200){
      toast('Profile Picture updated');
    }
  });
}

Future<void> uploadimg1(File image) async {
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/imageIn1';
  var request = new http.MultipartRequest("POST",Uri.parse(url));
  request.fields['user_id'] = currentUser.value.userid;
  request.files.add(await http.MultipartFile.fromPath(
    'image',image.path,
  )
  );
  request.send().then((response) {
    if (response.statusCode == 200){
      toast('Picture updated');
    }
  });
}
Future<void> uploadimg2(File image) async {
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/imageIn2';
  var request = new http.MultipartRequest("POST",Uri.parse(url));
  request.fields['user_id'] = currentUser.value.userid;
  request.files.add(await http.MultipartFile.fromPath(
    'image',image.path,
  )
  );
  request.send().then((response) {
    if (response.statusCode == 200){
      toast('Picture updated');
    }
  });
}
Future<void> uploadimg3(File image) async {
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/imageIn3';
  var request = new http.MultipartRequest("POST",Uri.parse(url));
  request.fields['user_id'] = currentUser.value.userid;
  request.files.add(await http.MultipartFile.fromPath(
    'image',image.path,
  )
  );
  request.send().then((response) {
    if (response.statusCode == 200){
      toast('Picture updated');
    }
  });
}

Future<void> uploadsliderpics(File image) async {
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/imageIn';
  var request = new http.MultipartRequest("POST",Uri.parse(url));
  request.fields['user_id'] = currentUser.value.userid;
  request.files.add(await http.MultipartFile.fromPath(
    'user_imgs',image.path,
  )
  );
  request.send().then((response) {
    if (response.statusCode == 200){
      toast('Slider Picture updated');
    }
  });
}


Future<List<imageModel.Image>> getallGalary(String user_id) async{
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/getGallary';
  final client = new http.Client();
  List<imageModel.Image> imgs = [];
  final response = await client.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        'user_id' : user_id
      }
  );
  if(response.statusCode == 200){
    var list = json.decode(response.body)['data'];
    for(var value in list){
      imgs.add(imageModel.Image.fromJson(value));
    }
  }
  return imgs;
}





