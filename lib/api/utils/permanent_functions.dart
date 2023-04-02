import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PermanentFunctions {
  static int checkIsListHasMorePageInt(List<dynamic> list, int page) {
    if (list.length < 15) {
      page = 1;
    } else {
      page++;
    }
    return page;
  }

  static bool checkIsListHasMorePageBool(List<dynamic> list) {
    if (list.length < 15) {
      return false;
    } else {
      return true;
    }
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
}
