import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:photo_just_for_fun/pages/home_page/home_page.dart';

abstract class HomePageBlocEvents {}

class RefreshHomePageEvent extends HomePageBlocEvents {}

class PaginateHomePageEvent extends HomePageBlocEvents {}

class ClickLikeEvent extends HomePageBlocEvents {
  PhotoModel photoModel;

  ClickLikeEvent({required this.photoModel});
}

class RemoveLikeEvent extends HomePageBlocEvents {
  PhotoModel photoModel;

  RemoveLikeEvent({required this.photoModel});
}

class CheckLikedPhotosEvent extends HomePageBlocEvents {}
