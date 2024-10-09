import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'presentation/screen/employee_profile_screen.dart';
import 'business/home_screen_bloc/navigate_screen_bloc.dart';
import 'business/theme_bloc/theme_bloc.dart';
import 'presentation/screen/landing_screen.dart';
import 'presentation/screen/templet_start_point.dart';
import 'data/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeBloc _themeBloc = ThemeBloc();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigateScreenBloc>(
            create: (BuildContext context) => NavigateScreenBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (BuildContext context) => ThemeBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          bloc: _themeBloc,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeData(state.isDarkTheme),
              routes: {
                '/': (context) => BlocProvider.value(
                      value: _themeBloc,
                      child: const HomeScreen(),
                    ),
                '/landing-page': (context) => BlocProvider.value(
                      value: _themeBloc,
                      child: const LandingScreen(),
                    ),
                '/employee-profile': (context) => BlocProvider.value(
                    value: _themeBloc, child: const EmployeeProfileScreen())
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.close();
    super.dispose();
  }
}


//  MenuDrawerTab(
//                               tab_icon: Icons.photo_camera_outlined,
//                               tab_name: "Check attendence",
//                               tab_action: () {}),
//                           MenuDrawerTab(
//                               tab_icon: Icons.video_camera_front_outlined,
//                               tab_name: "Security Cameras",
//                               tab_action: () {}),
//                           MenuDrawerTab(
//                               tab_icon: Icons.supervisor_account,
//                               tab_name: "Employees",
//                               tab_action: () {}),
//                           MenuDrawerTab(
//                               tab_icon: Icons.leaderboard_outlined,
//                               tab_name: "Leaderboard",
//                               tab_action: () {}),
//                           MenuDrawerTab(
//                               tab_icon: Icons.settings_accessibility_outlined,
//                               tab_name: "Point System",
//                               tab_action: () {}),
//                           MenuDrawerTab(
//                               tab_icon: Icons.admin_panel_settings_outlined,
//                               tab_name: "Admin account",
//                               tab_action: () {}),
//                           MenuDrawerTab(
//                               tab_icon: Icons.analytics_outlined,
//                               tab_name: "Analytics",
//                               tab_action: () {}),