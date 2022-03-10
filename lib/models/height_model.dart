import 'dart:convert';

class HeightModel {
  HeightModel({
    this.data,
  });

  Height? data;

  factory HeightModel.fromRawJson(String str) => HeightModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HeightModel.fromJson(Map<String, dynamic> json) => HeightModel(
    data: Height.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Height {
  Height({
    this.id,
    this.height
  });

  dynamic id;
  dynamic height;



  factory Height.fromRawJson(String str) => Height.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Height.fromJson(Map<String, dynamic> json) => Height(
      id: json["id"],
      height : json['height'],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "height" : height,

  };
}
