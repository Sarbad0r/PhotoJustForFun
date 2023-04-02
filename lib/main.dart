import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/pages/home_page/home_page.dart';
import 'package:photo_just_for_fun/pages/persistant_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
      providers: [
        //photo main bloc
        BlocProvider(create: (context) => MainHomePageBloc())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: PersistentNavBar())));
}
//xbzGzuMrIvb5WTcVeeQvBx2BNE04zfS4NhFJXsFQv7InLOAMEmHSueBR
