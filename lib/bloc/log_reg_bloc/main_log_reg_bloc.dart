import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/models/state_models/log_reg_state_model.dart';

class MainLogRegBloc extends Bloc<LogRegBlocEvents, LogRegBlocStates> {
  MainLogRegBloc() : super(LogRegBlocNotRegisteredState(LogRegStateModel())){
    //
    //events here
  }
}
