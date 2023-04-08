import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/pages/home_page/home_page.dart';
import 'package:photo_just_for_fun/pages/persistant_navbar.dart';
import 'package:firebase_core/firebase_core.dart';

// Future<void> initializeDefault() async {
//   Firebase app = await Firebase.initializeApp(
//     options: DefaultFire,
//   );
//   print('Initialized default app $app');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
      providers: [
        //photo main bloc
        BlocProvider(create: (context) => MainHomePageBloc()),
        //login and registration bloc
        BlocProvider(create: (context) => MainLogRegBloc())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: PersistentNavBar())));
}
//xbzGzuMrIvb5WTcVeeQvBx2BNE04zfS4NhFJXsFQv7InLOAMEmHSueBR
