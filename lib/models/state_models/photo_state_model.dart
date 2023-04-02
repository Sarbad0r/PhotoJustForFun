// ignore_for_file: non_constant_identifier_names

import 'package:photo_just_for_fun/api/utils/permanent_functions.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';

class PhotoStateModel {
  List<PhotoModel> photo_list = [];
  int page = 1;
  bool hasMore = false;

  bool paginating = false;

  void add_to_list(List<PhotoModel> list) {
    photo_list = list;
    page = PermanentFunctions.checkIsListHasMorePageInt(list, page);
    hasMore = PermanentFunctions.checkIsListHasMorePageBool(list);
  }

  void paginate_list(List<PhotoModel> list) {
    photo_list.addAll(list);
    page = PermanentFunctions.checkIsListHasMorePageInt(list, page);
    hasMore = PermanentFunctions.checkIsListHasMorePageBool(list);
  }

  void clear_list() {
    photo_list.clear();
    page = 1;
    hasMore = false;
  }
}
