import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kum_kum/models/height_model.dart' as heightmodel;
import '../config/config.dart';
import '../network/api.dart';
import 'package:http/http.dart' as http;
import 'package:kum_kum/models/height_model.dart' as heightModel;

Future<List<heightmodel.Height>> height() async {
  String url = 'https://beautyandessentials.shop/Matrimonixadmin/api/getHeight';
  var response = await http.get(Uri.parse(url));
  List<heightmodel.Height> heights = [];
  if(response.statusCode == 200){
    var list = json.decode(response.body)['data'];
    for(var value in list){
      heights.add(heightmodel.Height.fromJson(value));
    }
  }
  return heights;
}