//ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';

abstract class LogRegBlocEvents {}

class LoginEvent extends LogRegBlocEvents {
  GlobalKey<FormState> formKey;
  String email;
  String password;
  BuildContext context;

  LoginEvent(
      {required this.formKey,
      required this.email,
      required this.password,
      required this.context});
}

class RegisterEvent extends LogRegBlocEvents {}

class CheckTokenEvent extends LogRegBlocEvents {}

class ShowPasswordEvent extends LogRegBlocEvents {}
