//ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/pages/registration_page/screens/edit_profile_screen.dart';
import 'package:photo_just_for_fun/widgets/profile_circle_image.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';
import 'package:easy_localization/easy_localization.dart' as loc;

class RegisteredScreen extends StatelessWidget {
  const RegisteredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, state) {
      var current_state = state.logRegStateModel;
      return Scaffold(
          body: SafeArea(
              child: Column(children: [
        SizedBox(
            height: 270,
            width: double.infinity,
            child: Stack(children: [
              Container(height: 140, color: Colors.amber),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 90,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ProfileCircleImage(),
                        TextWidget(
                            text: current_state.userModel?.getName() ?? '',
                            fontWeight: FontWeight.bold,
                            size: 18),
                        const SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                            userModel:
                                                current_state.userModel))),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, right: 15, left: 15),
                                    decoration: BoxDecoration(
                                        color: HexColor('#fff6dc'),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.edit,
                                              size: 15, color: Colors.amber),
                                          SizedBox(width: 10),
                                          TextWidget(
                                              text: "Edit Profile",
                                              size: 13,
                                              letterSpace: 1.1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber)
                                        ])),
                              )
                            ])
                      ])),
              Positioned(
                  top: 15,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipOval(
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.grey[200]!.withOpacity(0.6),
                                    child:
                                        const Icon(Icons.settings, size: 20))),
                            ClipOval(
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.grey[200]!.withOpacity(0.6),
                                    child:
                                        const Icon(Icons.more_vert, size: 20)))
                          ])))
            ])),
        const Divider(),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        TextWidget(
                            text: "${loc.tr("do_your_first_project")}!",
                            size: 15,
                            fontWeight: FontWeight.bold),
                        const SizedBox(height: 10),
                        TextWidget(
                            textAlign: TextAlign.center,
                            text:
                                "get_reviews_views_and_ratings_public_projects_can_be_deselected_as_popular_by_curators"
                                    .tr())
                      ])
                    ]))),
        SizedBox(
            width: 50,
            height: 50,
            child: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () => [],
                child: const Icon(Icons.add))),
        const SizedBox(height: 15)
      ])));
    });
  }
}
