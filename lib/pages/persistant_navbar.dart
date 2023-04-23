import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/pages/home_page/home_page.dart';
import 'package:photo_just_for_fun/pages/registration_page/registration_page.dart';
import 'package:photo_just_for_fun/utils/shared_preferences.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';
import 'package:easy_localization/easy_localization.dart' as loc;

class PersistentNavBar extends StatefulWidget {
  const PersistentNavBar({Key? key}) : super(key: key);

  @override
  State<PersistentNavBar> createState() => _PersistentNavBarState();
}

class _PersistentNavBarState extends State<PersistentNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    context.read<MainHomePageBloc>().add(RefreshHomePageEvent());
    context.read<MainLogRegBloc>().add(CheckTokenEvent());
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(persistentNavController: _controller),
      Container(),
      Container(),
      const RegistrationPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home, color: Colors.black),
        inactiveIcon: const Icon(CupertinoIcons.home),
        activeColorSecondary: Colors.black,
        title: loc.tr("home"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search, color: Colors.black),
        inactiveIcon: const Icon(CupertinoIcons.search),
        activeColorSecondary: Colors.black,
        title: loc.tr("search"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart, color: Colors.black),
        inactiveIcon: const Icon(CupertinoIcons.heart),
        activeColorSecondary: Colors.black,
        title: loc.tr("likes"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
            builder: (context, state) {
          if (state is LogRegBlocLoadingState) {
            return const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.amber, strokeWidth: 2));
          } else if (state is LogRegBlocNotRegisteredState) {
            return const Icon(CupertinoIcons.person_add, color: Colors.black);
          } else {
            return ClipOval(
              child: SizedBox(
                width: 25,
                child: ImageLoaderWidget(
                    url: state.logRegStateModel.userModel?.img_url ?? '',
                    errorPictureUrl: '',
                    errorWidget:
                        const Icon(CupertinoIcons.person, color: Colors.black),
                    boxFit: BoxFit.cover),
              ),
            );
          }
        }),
        title: loc.tr("profile"),
        inactiveIcon: BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
            builder: (context, state) {
          if (state is LogRegBlocLoadingState) {
            return const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.amber, strokeWidth: 2));
          } else if (state is LogRegBlocNotRegisteredState) {
            return const Icon(CupertinoIcons.person_add);
          } else {
            return ClipOval(
              child: SizedBox(
                width: 25,
                child: ImageLoaderWidget(
                    url: state.logRegStateModel.userModel?.img_url ?? '',
                    errorPictureUrl: '',
                    errorWidget: const Icon(CupertinoIcons.person),
                    boxFit: BoxFit.cover),
              ),
            );
          }
        }),
        activeColorSecondary: Colors.black,
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
