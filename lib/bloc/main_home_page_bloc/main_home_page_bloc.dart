import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/api/api_photo/rest_api_photo.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_states.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:photo_just_for_fun/models/state_models/photo_state_model.dart';

class MainHomePageBloc extends Bloc<HomePageBlocEvents, HomePageBlocStates> {
  MainHomePageBloc() : super(HomePageInitialState(PhotoStateModel())) {
    //
    on<RefreshHomePageEvent>((event, emit) async {
      var getState = state.photoStateModel;
      getState.clear_list();
      emit(HomePageLoadingState.from_state(getState));
      await Future.delayed(const Duration(seconds: 1));
      List<PhotoModel> list = await RestApiPhoto.get_photos();
      Map<String, dynamic> liked_photos =
          await RestApiPhoto.check_liked_photos();
      for (var each in list) {
        if (liked_photos.containsKey("${each.id}")) {
          each.liked = true;
        }
      }
      getState.add_to_list(list);
      emit(HomePageInitialState.from_state(getState));
    });
    //
    on<PaginateHomePageEvent>((event, emit) async {
      var getState = state.photoStateModel;
      if (getState.paginating) return;
      getState.paginating = true;
      await RestApiPhoto.get_photos(page: getState.page).then((value) {
        getState.paginate_list(value);
      });
      getState.paginating = false;
      emit(HomePageInitialState.from_state(getState));
    });
    //
    on<CheckLikedPhotosEvent>((event, emit) {});
    //
    on<ClickLikeEvent>((event, emit) async {
      var getState = state.photoStateModel;
      await RestApiPhoto.like_photo(event.photoModel).then((value) {
        if (value) {
          //set photo liked true
          event.photoModel.liked = true;
          //and find photo from list and change this photo with new value
          getState.photo_list[getState.photo_list
                  .indexWhere((el) => el.id == event.photoModel.id)] =
              event.photoModel;
          emit(HomePageInitialState.from_state(getState));
        }
      });
    });
    //
    on<RemoveLikeEvent>((event, emit) async {
      var getState = state.photoStateModel;
      await RestApiPhoto.remove_like_photo(event.photoModel).then((value) {
        if (value) {
          //set photo liked false
          event.photoModel.liked = false;
          //and find photo from list and change this photo with new value
          getState.photo_list[getState.photo_list
                  .indexWhere((el) => el.id == event.photoModel.id)] =
              event.photoModel;
          emit(HomePageInitialState.from_state(getState));
        }
      });
    });
  }
}
