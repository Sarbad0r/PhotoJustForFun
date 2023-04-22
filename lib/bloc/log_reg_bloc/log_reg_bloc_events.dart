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

class PickImageEvent extends LogRegBlocEvents {}

class SetNullImageBeforeGoingBeckEvent extends LogRegBlocEvents {
  BuildContext context;

  SetNullImageBeforeGoingBeckEvent({required this.context});
}

class SaveProfileUpdatedEvent extends LogRegBlocEvents {
  String name;
  String last_name;
  String prof;
  String company;
  BuildContext context;

  SaveProfileUpdatedEvent(
      {required this.name,
      required this.last_name,
      required this.prof,
      required this.company,
      required this.context});
}
