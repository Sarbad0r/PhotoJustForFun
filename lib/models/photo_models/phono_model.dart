// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model_src.dart';

class PhotoModel {
  int? id;
  int? width;
  int? height;
  String? avg_color;
  String? url;
  String? photographer;
  String? photographer_url;
  PhotoSrc? photoSrc;
  bool? liked;
  String? alt;

  PhotoModel(
      {this.id,
      this.width,
      this.height,
      this.avg_color,
      this.url,
      this.photographer,
      this.photographer_url,
      this.photoSrc,
      this.liked,
      this.alt});
}
