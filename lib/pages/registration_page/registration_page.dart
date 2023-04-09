import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/pages/registration_page/screens/registered_screen.dart';
import 'package:photo_just_for_fun/pages/registration_page/screens/registration_screen.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, state) {
      if (state is LogRegBlocNotRegisteredState) {
        return const RegistrationScreen();
      }else{
        return const RegisteredScreen();
      }
    });
  }
}
