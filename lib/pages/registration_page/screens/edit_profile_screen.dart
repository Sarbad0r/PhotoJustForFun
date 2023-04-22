//ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/models/user_model.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';
import 'package:photo_just_for_fun/widgets/text_field_widget.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel? userModel;

  const EditProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController name_controller = TextEditingController(text: '');
  TextEditingController last_name_controller = TextEditingController(text: '');
  TextEditingController job_name_controller = TextEditingController(text: '');
  TextEditingController company_name_controller =
      TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name_controller.text = widget.userModel?.name ?? '';
    last_name_controller.text = widget.userModel?.last_name ?? '';
    job_name_controller.text = widget.userModel?.job_name ?? '';
    company_name_controller.text = widget.userModel?.company_name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, state) {
      var current_state = state.logRegStateModel;
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.8,
              title: TextWidget(
                  text: "change_profile".tr(), size: 16, color: Colors.black),
              leading: IconButton(
                  onPressed: () => context
                      .read<MainLogRegBloc>()
                      .add(SetNullImageBeforeGoingBeckEvent(context: context)),
                  icon: const Icon(Icons.arrow_back,
                      size: 20, color: Colors.black)),
              actions: [
                TextButton(
                    onPressed: () => context.read<MainLogRegBloc>().add(
                        SaveProfileUpdatedEvent(
                            name: name_controller.text.trim(),
                            last_name: last_name_controller.text.trim(),
                            prof: job_name_controller.text.trim(),
                            company: company_name_controller.text.trim(),
                            context: context)),
                    child: TextWidget(
                      text: "save".tr(),
                      color: Colors.amber.withOpacity(0.8),
                    ))
              ]),
          body: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(children: [
                const SizedBox(height: 10),
                Row(children: [
                  GestureDetector(
                      onTap: () =>
                          context.read<MainLogRegBloc>().add(PickImageEvent()),
                      child: Stack(children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[300]!, width: 1)),
                            child: current_state.image != null
                                ? Image.file(current_state.image!,
                                    width: 100, height: 100, fit: BoxFit.cover)
                                : ImageLoaderWidget(
                                    width: 100,
                                    height: 100,
                                    url: current_state.userModel?.img_url ?? '',
                                    errorPictureUrl:
                                        "assets/images/placeholder-image.png")),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                                color: Colors.grey[400]!.withOpacity(0.5),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.edit, size: 13)))
                      ])),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(children: [
                      TextFieldWidget(
                          controller: name_controller,
                          textInputType: TextInputType.text,
                          hintOrLableText: "name".tr(),
                          hasPaddingAtStart: false,
                          hintTextColor: Colors.grey),
                      TextFieldWidget(
                          controller: last_name_controller,
                          textInputType: TextInputType.text,
                          hintOrLableText: "last_name".tr(),
                          hasPaddingAtStart: false,
                          hintTextColor: Colors.grey),
                    ]),
                  )
                ]),
                TextFieldWidget(
                    controller: job_name_controller,
                    textInputType: TextInputType.text,
                    hintOrLableText: "profession_and_job".tr(),
                    hasPaddingAtStart: false,
                    hintTextColor: Colors.grey),
                TextFieldWidget(
                    controller: company_name_controller,
                    textInputType: TextInputType.text,
                    hintOrLableText: "company".tr(),
                    hasPaddingAtStart: false,
                    hintTextColor: Colors.grey)
              ])));
    });
  }
}
