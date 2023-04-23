// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:photo_just_for_fun/models/user_model.dart';
import 'package:photo_just_for_fun/utils/shared_preferences.dart';

class LogRegStateModel {
//data which we will work with

  UserModel? userModel;

  //simple variables
  bool clickedLoginButton = false;
  bool hidePasswordText = true;
  File? image;
  bool updating = false;

  void save_user(Map<String, dynamic> data) async {
    userModel = UserModel.from_json(data['user']);
    userModel?.setNetworkImage();
    await SharedPref.saveStringPrefer(keyName: 'token', value: data['token']);
  }
}
