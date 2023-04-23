// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:easy_localization/easy_localization.dart' as loc;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class PermanentFunctions {
  static int checkIsListHasMorePageInt(List<dynamic> list, int page) {
    if (list.length < 15) {
      page = 1;
    } else {
      page++;
    }
    return page;
  }

  static double returnHeightLookingScreenSize(BuildContext context, int size) {
    double screenSize = MediaQuery.of(context).size.height;
    return (screenSize * size) / 855;
  }

  static bool checkIsListHasMorePageBool(List<dynamic> list) {
    if (list.length < 15) {
      return false;
    } else {
      return true;
    }
  }

  static void showToast({required String message, required bool error}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        textColor: error ? Colors.white : Colors.black,
        backgroundColor: error ? Colors.pink : Colors.amber,
        fontSize: 15);
  }

  static Color appBarTransitionColor(ScrollController scrollController) {
    if (scrollController.offset >= 20 && scrollController.offset < 25) {
      return HexColor("#91918e").withOpacity(0.5);
    } else if (scrollController.offset >= 25 && scrollController.offset < 30) {
      return HexColor("#9d9d9a").withOpacity(0.5);
    } else if (scrollController.offset >= 30 && scrollController.offset < 35) {
      return HexColor("#a8a8a6").withOpacity(0.5);
    } else if (scrollController.offset >= 35 && scrollController.offset < 40) {
      return HexColor("#b4b4b2").withOpacity(0.5);
    } else if (scrollController.offset >= 40 && scrollController.offset < 45) {
      return HexColor("#c0c0bf").withOpacity(0.5);
    } else if (scrollController.offset >= 45 && scrollController.offset < 50) {
      return HexColor("#cdcdcb").withOpacity(0.5);
    } else if (scrollController.offset >= 50 && scrollController.offset < 55) {
      return HexColor("#d9d9d8").withOpacity(0.5);
    } else if (scrollController.offset >= 55 && scrollController.offset < 60) {
      return HexColor("#e6e6e5").withOpacity(0.5);
    } else if (scrollController.offset >= 60 && scrollController.offset < 65) {
      return HexColor("##f2f2f2");
    } else if (scrollController.offset > 65) {
      return Colors.white;
    }
    return Colors.transparent;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null) return null;
    if (!regex.hasMatch(value ?? '')) return "Email error";
    return null;
  }

  static String? checkPasswords(String? password) {
    String? res;
    if (password == null || password.isEmpty) {
      res = "Password is Empty";
    }
    if ((password ?? '').length < 8) {
      res = "Password length must not be less than 8";
    }
    return res;
  }

  static void snack_bar(String title, String message, bool error) {
    if (error) {
      Get.snackbar(title, message,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2));
    } else {
      Get.snackbar(title, message,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2));
    }
  }

  static Future<File?> pickImage() async {
    File? imageFile;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return null;
      final path = File(image.path);

      imageFile = await testCompressAndGetFile(path, path.toString());
    } catch (e) {
      PermanentFunctions.snack_bar(
          loc.tr("image_error"), loc.tr("choose_another_one"), true);
    }
    return imageFile;
  }

  static Future<File>? testCompressAndGetFile(
      File file, String targetPath) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, outPath,
        minHeight: 1024, minWidth: 1024, quality: 20);
    //print(file.lengthSync());
    //print(result?.lengthSync());
    return result!;
  }

  static String cutAllSpaceFromText(String text) {
    String temp = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i] == ' ') continue;
      temp += text[i];
    }
    return temp;
  }

}
