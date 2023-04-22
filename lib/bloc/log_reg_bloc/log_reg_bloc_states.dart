// ignore_for_file: non_constant_identifier_names

import 'package:photo_just_for_fun/models/state_models/log_reg_state_model.dart';

abstract class LogRegBlocStates {
  LogRegStateModel logRegStateModel;

  LogRegBlocStates({required this.logRegStateModel});
}

class LogRegBlocNotRegisteredState extends LogRegBlocStates {
  LogRegBlocNotRegisteredState(LogRegStateModel logRegStateModel)
      : super(logRegStateModel: logRegStateModel);

  factory LogRegBlocNotRegisteredState.from_state(
      LogRegStateModel logRegStateModel) {
    return LogRegBlocNotRegisteredState(logRegStateModel);
  }
}

class LogRegBlocLoadingState extends LogRegBlocStates {
  LogRegBlocLoadingState(LogRegStateModel logRegStateModel)
      : super(logRegStateModel: logRegStateModel);

  factory LogRegBlocLoadingState.from_state(LogRegStateModel logRegStateModel) {
    return LogRegBlocLoadingState(logRegStateModel);
  }
}

class LogRegBlocRegisteredState extends LogRegBlocStates {
  LogRegBlocRegisteredState(LogRegStateModel logRegStateModel)
      : super(logRegStateModel: logRegStateModel);

  factory LogRegBlocRegisteredState.from_state(
      LogRegStateModel logRegStateModel) {
    return LogRegBlocRegisteredState(logRegStateModel);
  }
}
