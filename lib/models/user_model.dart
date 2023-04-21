// ignore_for_file: non_constant_identifier_names

class UserModel {
  int? id;
  String? name;
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
      this.email,
      this.password,
      this.phone_number,
      this.google_id,
      this.img_url,
      this.created_at,
      this.updated_at});

  factory UserModel.from_json(Map<String, dynamic> json) => UserModel();
}
