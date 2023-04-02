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
  int? photographer_id;
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
      this.photographer_id,
      this.photoSrc,
      this.liked,
      this.alt});

  factory PhotoModel.from_json(Map<String, dynamic> json) {
    return PhotoModel(
        id: json['id'],
        width: json['width'],
        height: json['height'],
        url: json['url'],
        photographer: json['photographer'],
        photographer_url: json['photographer_url'],
        photographer_id: json['photographer_id'],
        avg_color: json['avg_color'],
        photoSrc: PhotoSrc.from_json(json['src']),
        liked: json['liked'],
        alt: json['alt']);
  }
}
