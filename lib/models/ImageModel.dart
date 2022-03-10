import 'dart:convert';

class ImageModel {
  ImageModel({
    this.data,
  });

  Image? data;

  factory ImageModel.fromRawJson(String str) => ImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    data: Image.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Image {
  Image({
    this.id,
    this.image
  });

  dynamic id;
  dynamic image;



  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["media_id"],
    image : json['image'],

  );

  Map<String, dynamic> toJson() => {
    "media_id": id,
    "image" : image,

  };
}
