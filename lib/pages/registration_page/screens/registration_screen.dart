// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/utils/permanent_functions.dart';
import 'package:photo_just_for_fun/widgets/text_field_without_paddings.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController email_controller = TextEditingController(text: '');
  TextEditingController password_controller = TextEditingController(text: '');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, state) {
      var current_state = state.logRegStateModel;
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      TextWidget(
                          text: "Welcome to PhotoJustForFun app",
                          size:
                              PermanentFunctions.returnHeightLookingScreenSize(
                                  context, 30),
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold),
                      Padding(
                          padding: const EdgeInsets.only(right: 70, top: 5),
                          child: TextWidget(
                            text:
                                "An exciting place for the whole family to fun",
                            size: PermanentFunctions
                                .returnHeightLookingScreenSize(context, 16),
                            textAlign: TextAlign.left,
                            color: Colors.grey.shade600,
                          )),
                      SizedBox(
                          height:
                              PermanentFunctions.returnHeightLookingScreenSize(
                                  context, 90)),
                      Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.grey[200]!,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFieldWithoutPaddings(
                              hintText: "E-mail",
                              textSize: 16,
                              hintTextSize: 16,
                              prefixIcon: const Icon(CupertinoIcons.mail_solid,
                                  size: 18, color: Colors.black),
                              controller: email_controller,
                              getTextFormField: true,
                              validator: (v) =>
                                  PermanentFunctions.validateEmail(v!))),
                      const SizedBox(height: 10),
                      Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.grey[200]!,
                              borderRadius: BorderRadius.circular(5)),
                          child: Stack(
                            children: [
                              TextFieldWithoutPaddings(
                                  getTextFormField: true,
                                  validator: (v) {
                                    return PermanentFunctions.checkPasswords(v);
                                  },
                                  textSize: 16,
                                  hintText: "Password",
                                  showInputText: current_state.hidePasswordText,
                                  hintTextSize: 16,
                                  prefixIcon: const Icon(
                                      CupertinoIcons.lock_fill,
                                      size: 18,
                                      color: Colors.black),
                                  controller: password_controller),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () => context
                                        .read<MainLogRegBloc>()
                                        .add(ShowPasswordEvent()),
                                    icon: Icon(Icons.remove_red_eye,
                                        color: current_state.hidePasswordText
                                            ? Colors.grey[400]!
                                            : Colors.amber)),
                              )
                            ],
                          )),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                debugPrint(
                                    "email controller ${email_controller.text} - ${email_controller.text.isEmpty}");
                                context.read<MainLogRegBloc>().add(LoginEvent(
                                    formKey: formKey,
                                    email: email_controller.text
                                        .trimLeft()
                                        .trimRight(),
                                    password: password_controller.text
                                        .trimLeft()
                                        .trimRight(),
                                    context: context));
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  decoration: BoxDecoration(
                                      color: current_state.clickedLoginButton
                                          ? Colors.amber
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: TextWidget(
                                          text: "Sign In",
                                          size: PermanentFunctions
                                              .returnHeightLookingScreenSize(
                                                  context, 18),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          if (current_state.clickedLoginButton)
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 15),
                                  SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                          color: Colors.amber, strokeWidth: 2))
                                ])
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          padding: EdgeInsets.all(
                              PermanentFunctions.returnHeightLookingScreenSize(
                                  context, 13)),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                TextWidget(
                                    text: "Sign Up",
                                    size: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ])),
                      const SizedBox(height: 15),
                    ]),
              )));
    });
  }
}
