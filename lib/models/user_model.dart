// ignore_for_file: non_constant_identifier_names

import 'package:photo_just_for_fun/api/api_connections.dart';
import 'package:photo_just_for_fun/utils/permanent_functions.dart';

class UserModel {
  int? id;
  String? name;
  String? last_name;
  String? job_name;
  String? company_name;
  String? email;
  String? password;
  String? phone_number;
  String? google_id;
  String? img_url;
  String? created_at;
  String? updated_at;

  UserModel(
      {this.id,
      this.name,
      this.last_name,
      this.job_name,
      this.company_name,
      this.email,
      this.password,
      this.phone_number,
      this.google_id,
      this.img_url,
      this.created_at,
      this.updated_at});

  factory UserModel.from_json(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      last_name: json['last_name'],
      job_name: json['job_name'],
      company_name: json['company_name'],
      email: json['email'],
      password: json['password'],
      phone_number: json['phone_number'],
      google_id: json['google_id'],
      img_url: json['img_url'],
      created_at: json['created_at'],
      updated_at: json['updated_at']);

  String? getName() {
    if (name == null && last_name == null) return '';
    return "${name ?? ''} ${last_name ?? ''}";
  }

  void setNetworkImage() async {
    String currentDatetime =
        PermanentFunctions.cutAllSpaceFromText(DateTime.now().toString());
    img_url =
        "${ApiConnections.BACKEND_URL}/get/user/image/$id?v=$currentDatetime";
  }
}
