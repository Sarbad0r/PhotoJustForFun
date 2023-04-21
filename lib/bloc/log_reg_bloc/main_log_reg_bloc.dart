import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/api/api_log_reg/rest_api_log_and_reg.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/models/state_models/log_reg_state_model.dart';
import 'package:photo_just_for_fun/models/user_model.dart';
import 'package:photo_just_for_fun/utils/shared_preferences.dart';

class MainLogRegBloc extends Bloc<LogRegBlocEvents, LogRegBlocStates> {
  MainLogRegBloc() : super(LogRegBlocNotRegisteredState(LogRegStateModel())) {
    //
    //events here
    on<LoginEvent>((event, emit) async {
      if (!event.formKey.currentState!.validate()) {
        return;
      }
      var getState = state.logRegStateModel;
      if (getState.clickedLoginButton) return;
      getState.clickedLoginButton = true;
      emit(LogRegBlocNotRegisteredState(getState));
      Map<String, dynamic> data = {
        'email': event.email,
        'password': event.password
      };
      await RestApiLogAndRegistration.login(data, event.context)
          .then((value) async {
        if (value['success'] == true) {
          getState.clickedLoginButton = false;
          getState.save_user(value);
          emit(LogRegBlocRegisteredState(getState));
        } else {
          getState.clickedLoginButton = false;
          emit(LogRegBlocNotRegisteredState(getState));
        }
      });
    });
    //registration event

    //check the token event here

    on<CheckTokenEvent>((event, emit) async {
      var getState = state.logRegStateModel;
      await RestApiLogAndRegistration.check_token(
              await SharedPref.getStringPrefer('token'))
          .then((value) {
        if (value['success'] == true) {
          getState.userModel = UserModel.from_json(value['user']);
          emit(LogRegBlocRegisteredState(getState));
        } else {
          emit(LogRegBlocNotRegisteredState(getState));
        }
      });
    });

    //show password event
    on<ShowPasswordEvent>((event, emit) {
      var getState = state.logRegStateModel;
      getState.hidePasswordText = !getState.hidePasswordText;
      emit(LogRegBlocNotRegisteredState(getState));
    });
  }
}
