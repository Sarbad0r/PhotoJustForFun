import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/pages/home_page/home_page.dart';
import 'package:photo_just_for_fun/pages/persistant_navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:photo_just_for_fun/utils/firebase_notify.dart';
import 'package:photo_just_for_fun/utils/shared_preferences.dart';

// Future<void> initializeDefault() async {
//   Firebase app = await Firebase.initializeApp(
//     options: DefaultFire,
//   );
//   print('Initialized default app $app');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Firebase.initializeApp();
    await FirebaseNotification.requestPermission();
    await FirebaseNotification.getToken();
  }


  runApp(MultiBlocProvider(
      providers: [
        //photo main bloc
        BlocProvider(create: (context) => MainHomePageBloc()),
        //login and registration bloc
        BlocProvider(create: (context) => MainLogRegBloc())
      ],
      child: const GetMaterialApp(
          debugShowCheckedModeBanner: false, home: PersistentNavBar())));
}
//xbzGzuMrIvb5WTcVeeQvBx2BNE04zfS4NhFJXsFQv7InLOAMEmHSueBR
