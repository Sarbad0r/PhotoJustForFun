// ignore_for_file: non_constant_identifier_names

import 'package:photo_just_for_fun/models/state_models/photo_state_model.dart';

abstract class HomePageBlocStates {
  PhotoStateModel photoStateModel;

  HomePageBlocStates({required this.photoStateModel});
}

class HomePageInitialState extends HomePageBlocStates {
  HomePageInitialState(PhotoStateModel photoStateModel)
      : super(photoStateModel: photoStateModel);

  factory HomePageInitialState.from_state(PhotoStateModel photoStateModel) {
    return HomePageInitialState(photoStateModel);
  }
}

class HomePageLoadingState extends HomePageBlocStates {
  HomePageLoadingState(PhotoStateModel photoStateModel)
      : super(photoStateModel: photoStateModel);

  factory HomePageLoadingState.from_state(PhotoStateModel photoStateModel) {
    return HomePageLoadingState(photoStateModel);
  }
}
