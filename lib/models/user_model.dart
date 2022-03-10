import 'dart:convert';

class UserModel {
  UserModel({
    this.data,
  });

  User? data;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.userid,
    this.name,
    this.niceName,
    this.dob,
    this.sex,
    this.description,
    this.active,
    this.email,
    this.mobile,
    this.memberSince,
    this.avatar,
    this.devicetoken,
    this.devicetype,
    this.password,
    this.height,
    this.short_address,
    this.qualification,
    this.monthlyincome,
    this.occupation,
    this.caste,
    this.img1,
    this.img2,
    this.img3
  });

  int? id;
  dynamic userid;
  dynamic name;
  dynamic niceName;
  dynamic dob;
  dynamic sex;
  dynamic description;
  bool? active;
  dynamic email;
  dynamic mobile;
  dynamic memberSince;
  dynamic avatar;
  dynamic devicetoken;
  dynamic devicetype;
  dynamic password;
  dynamic height;
  dynamic short_address;
  dynamic qualification;
  dynamic occupation;
  dynamic monthlyincome;
  dynamic caste;
  dynamic img1;
  dynamic img2;
  dynamic img3;


  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userid : json['user_id'],
    name: json["name"],
    niceName: json["nice_name"],
    dob: json["dob"],
    sex: json["gender"],
    description: json["description"],
    caste: json["complexion"],
    active: json["active"],
    email: json["email"],
    mobile: json['mobile'],
    memberSince: json["member_since"],
    avatar: json["user_avtar"],
    devicetoken: json["device_token"],
    devicetype: json["device_type"],
    password: json["password"],
    height: json['weight'],
    qualification: json['qualification'],
    occupation: json['work_place'],
    short_address: json['current_address'],
    monthlyincome: json['income'],
    img1: json['img1'],
    img2: json['img2'],
    img3: json['img3']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id" : id,
    "name": name,
    "nice_name": niceName,
    "dob": dob,
    "gender": sex,
    "description": description,
    "complexion":caste,
    "active": active,
    "email": email,
    "mobile":mobile,
    "member_since": memberSince,
    "user_avtar": avatar,
    "device_token": devicetoken,
    "device_type":devicetype,
    "password":password,
    "weight":height,
    "qualification":qualification,
    "work_place":occupation,
    "current_address":short_address,
    "income":monthlyincome,
    "img1":img1,
    "img2":img2,
    "img3":img3
  };


}
