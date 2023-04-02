import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/api/api_photo/rest_api_photo.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_states.dart';
import 'package:photo_just_for_fun/models/state_models/photo_state_model.dart';

class MainHomePageBloc extends Bloc<HomePageBlocEvents, HomePageBlocStates> {
  MainHomePageBloc() : super(HomePageInitialState(PhotoStateModel())) {
    //
    on<RefreshHomePageEvent>((event, emit) async {
      var getState = state.photoStateModel;
      getState.clear_list();
      emit(HomePageLoadingState.from_state(getState));
      await Future.delayed(const Duration(seconds: 1));
      await RestApiPhoto.get_photos().then((value) {
        getState.add_to_list(value);
      });
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
  }
}
