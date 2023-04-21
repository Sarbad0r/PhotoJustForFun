//ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:photo_just_for_fun/api/api_connections.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'package:photo_just_for_fun/utils/permanent_functions.dart';

class RestApiPhoto {
  static Future<List<PhotoModel>> get_photos({int page = 1}) async {
    List<PhotoModel> photo_list = [];
    try {
      var res = await http.get(
          Uri.parse(
              "${ApiConnections.PHOTO_PIXELS_URL}/v1/curated?page=$page&per_page=15"),
          headers: ApiConnections.photo_pixel_headers());
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

  static Future<Map<String, dynamic>> check_liked_photos() async {
    Map<String, dynamic> data = {};
    try {
      var res = await http.get(
          Uri.parse("${ApiConnections.BACKEND_URL}/get-like-photos"),
          headers: await ApiConnections.backend_headers());
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        List<dynamic> list = json['photos'];
        for (var each in list) {
          data['${each['photo_id']}'] = '${each['photo_id']}';
        }
      }
    } catch (e) {
      print(e);
    }
    print('coming data $data');
    return data;
  }

  static Future<bool> like_photo(PhotoModel photoModel) async {
    bool success = false;
    try {
      var res = await http.post(
          Uri.parse("${ApiConnections.BACKEND_URL}/like-photo"),
          body: jsonEncode({"photo": photoModel.to_json_like()}),
          headers: await ApiConnections.backend_headers());
      print(res.body);
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        if (json['success'] == true) {
          success = true;
        } else {
          PermanentFunctions.showToast(message: json['message'], error: false);
        }
      }
    } catch (e) {
      print(e);
      PermanentFunctions.showToast(message: e.toString(), error: true);
    }
    return success;
  }

  static Future<bool> remove_like_photo(PhotoModel photoModel) async {
    bool success = false;
    try {
      var res = await http.post(
          Uri.parse("${ApiConnections.BACKEND_URL}/remove-like-photo"),
          body: jsonEncode({"photo": photoModel.to_json_like()}),
          headers: await ApiConnections.backend_headers());
      print(res.body);
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        if (json['success'] == true) {
          success = true;
        }
      }
    } catch (e) {
      print(e);
      PermanentFunctions.showToast(message: e.toString(), error: true);
    }
    return success;
  }
}
