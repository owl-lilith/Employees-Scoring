import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../presentation/screen/home_page_screen.dart';

import 'employees_screen.dart';
import 'leader_board_screen.dart';
import 'services_screen.dart';
import 'landing_screen.dart';

import '../../business/theme_bloc/theme_bloc.dart';
import '../../data/model/user.dart';
import '../widget/menu_drawer_tab.dart';
import '../../business/home_screen_bloc/navigate_screen_bloc.dart';
import '../../data/theme/theme.dart';

ZoomDrawerController zoomDrawerController = ZoomDrawerController();
final NavigateScreenBloc navigateScreenBloc = NavigateScreenBloc();
// final ThemeBloc themeBloc = ThemeBloc();
Widget currentScreen = const HomePageScreen();

Widget getScreen(CurrentScreen currentScreen) {
  switch (currentScreen) {
    case CurrentScreen.mainScreen:
      return const HomePageScreen();
    case CurrentScreen.services:
      return ChooseServicesScreen();
    case CurrentScreen.employees:
      return const EmployeePage();
    case CurrentScreen.leaderBoard:
      return const LeaderBoardPage();
  }
}

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        menuScreenWidth: MediaQuery.of(context).size.width,
        mainScreenScale: 0.1,
        controller: zoomDrawerController,
        showShadow: true,
        openCurve: Curves.easeInOut,
        mainScreenTapClose: true,
        moveMenuScreen: false,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: 230.0.spMin,
        // overlayBlend: BlendMode.overlay,
        mainScreen: const MainScreen(),
        menuScreen: const MenuScreen(),
        androidCloseOnBackTap: true,
        clipMainScreen: true,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigateScreenBloc, NavigateScreenState>(
        bloc: navigateScreenBloc,
        // listenWhen: (context, current) => current is NavigateScreenActionState,
        listener: (context, state) async {
          switch (state.runtimeType) {
            case ChangeCurrentScreenActionState:
              final clickedScreen = state as ChangeCurrentScreenActionState;
              setState(() {
                if (clickedScreen.currentScreen == CurrentScreen.services) {
                  navigateScreenBloc.add(GetServicesListActionEvent());
                }
                currentScreen = getScreen(clickedScreen.currentScreen);
              });
            case GetServicesListLoadingActionState:
              await Future.delayed(Duration.zero);
              currentScreen = Container(
                  child: const Center(child: CircularProgressIndicator.adaptive()));
              break;
            case GetServicesListSuccessfullyActionState:
              state as GetServicesListSuccessfullyActionState;
              setState(() {
                currentScreen = ChooseServicesScreen();
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              break;
            case GetServicesListErrorActionState:
              state as GetServicesListErrorActionState;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              break;
          }
        },
        builder: (newContext, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  onPressed: zoomDrawerController.open),
            ),
            body: BlocProvider.value(
              value: BlocProvider.of<ThemeBloc>(context),
              child: currentScreen,
            ),
          );
        });
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Alignment> firstAlignment;
  late Animation<Alignment> secondAlignment;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    firstAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
    ]).animate(animationController);

    secondAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
    ]).animate(animationController);

    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return AnimatedBuilder(
      animation: animationController,
      builder: (animationContext, widget) {
        return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkTheme ? kDrawerDarkModeBG : kDrawerLightModeBG,
                begin: firstAlignment.value,
                end: secondAlignment.value,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.asset(user.image_url!,
                                    height: 150, width: 150)),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            BlocConsumer<ThemeBloc, ThemeState>(
                              bloc: themeBloc,
                              listener: (context, state) {
                                if (state.runtimeType == ThemeState) {
                                  final themeState = state;
                                  setState(() {
                                    isDarkTheme = themeState.isDarkTheme;
                                  });
                                }
                              },
                              builder: (newContext, state) {
                                return Switch.adaptive(
                                    value: !isDarkTheme,
                                    thumbColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors.yellow.shade700;
                                      }
                                      return Colors.grey;
                                    }),
                                    thumbIcon:
                                        MaterialStateProperty.resolveWith<
                                            Icon?>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return const Icon(Icons.light_mode);
                                      }
                                      return const Icon(Icons.dark_mode);
                                    }),
                                    onChanged: (value) {
                                      themeBloc.add(ChangeThemeEvent(!value));
                                      // BlocProvider.of<ThemeBloc>(context)
                                      //     .add(ChangeThemeEvent(!value));
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Divider(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView(children: [
                          MenuDrawerTab(
                            tab_icon: Icons.home,
                            tab_name: "Home Page",
                            tab_action: () {
                              navigateScreenBloc.add(DrawerItemClickedEvent(
                                  CurrentScreen.mainScreen));
                              ZoomDrawer.of(context)?.close();
                            },
                          ),
                          MenuDrawerTab(
                            tab_icon: Icons.checklist_rtl_sharp,
                            tab_name: "Services",
                            tab_action: () {
                              navigateScreenBloc.add(DrawerItemClickedEvent(
                                  CurrentScreen.services));
                              ZoomDrawer.of(context)?.close();
                            },
                          ),
                          MenuDrawerTab(
                              tab_icon: Icons.supervisor_account,
                              tab_name: "Employees",
                              tab_action: () {
                                navigateScreenBloc.add(DrawerItemClickedEvent(
                                    CurrentScreen.employees));
                                ZoomDrawer.of(context)?.close();
                              }),
                          MenuDrawerTab(
                              tab_icon: Icons.leaderboard,
                              tab_name: "Leaderboard",
                              tab_action: () {
                                navigateScreenBloc.add(DrawerItemClickedEvent(
                                    CurrentScreen.leaderBoard));
                                ZoomDrawer.of(context)?.close();
                              }),
                        ]),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: isDarkTheme
                                    ? Colors.white
                                    : Colors.black))),
                        elevation: const MaterialStatePropertyAll(0.0),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.transparent)),
                    child: const Text(
                      "Log out",
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LandingScreen.routeName);
                    },
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0.0),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    child: const Text(
                      "back to landing page",
                    )),
              ],
            ));
      },
    );
  }
}
