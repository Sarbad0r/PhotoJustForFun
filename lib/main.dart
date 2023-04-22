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
import 'package:easy_localization/easy_localization.dart';

// Future<void> initializeDefault() async {
//   Firebase app = await Firebase.initializeApp(
//     options: DefaultFire,
//   );
//   print('Initialized default app $app');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await EasyLocalization.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Firebase.initializeApp();
    await FirebaseNotification.requestPermission();
    await FirebaseNotification.getToken();
  }

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru')],
      path: 'assets/language',
      child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          //photo main bloc
          BlocProvider(create: (context) => MainHomePageBloc()),
          //login and registration bloc
          BlocProvider(create: (context) => MainLogRegBloc())
        ],
        child: GetMaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            home: const PersistentNavBar()));
  }
}

//xbzGzuMrIvb5WTcVeeQvBx2BNE04zfS4NhFJXsFQv7InLOAMEmHSueBR
