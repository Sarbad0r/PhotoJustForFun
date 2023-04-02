//ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:photo_just_for_fun/api/api_connections.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:http/http.dart' as http;

class RestApiPhoto {
  static Future<List<PhotoModel>> get_photos({int page = 1}) async {
    List<PhotoModel> photo_list = [];
    try {
      var res = await http.get(
          Uri.parse("https://api.pexels.com/v1/curated?page=$page&per_page=15"),
          headers: await ApiConnections.headers());
      debugPrint("photos : ${res.body}");
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        List<dynamic> list = json['photos'];
        photo_list = list.map((e) => PhotoModel.from_json(e)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return photo_list;
  }
}
