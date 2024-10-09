import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business/theme_bloc/theme_bloc.dart';
import '../../presentation/widget/LoginDialog.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "/landing-page";

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isSignUp = false;
  String email = "";
  String password = "";
  var formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode getStartedFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocConsumer<ThemeBloc, ThemeState>(
        bloc: themeBloc,
        listener: (context, state) {
          if (state.runtimeType == ThemeState) {
            final themeState = state;
            setState(() {
              isDarkTheme = themeState.isDarkTheme;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  "assets/images/logo_1.png",
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return const LoginDialog();
                          },
                        ),
                    child: const Text("Log in")),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: const Text("English")),
                    const Text(
                      "|",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(onPressed: () {}, child: const Text("العربية"))
                  ],
                ),
                Switch.adaptive(
                    value: !isDarkTheme,
                    thumbColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.yellow.shade700;
                      }
                      return Colors.grey;
                    }),
                    thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Icon(Icons.light_mode);
                      }
                      return const Icon(Icons.dark_mode);
                    }),
                    onChanged: (value) =>
                        themeBloc.add(ChangeThemeEvent(!value)))
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.cyanAccent.withOpacity(0.6),
                const Color.fromARGB(75, 64, 195, 255),
                Colors.transparent,
                Colors.blue.shade700.withOpacity(0.6),
              ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: landscape
                                ? MediaQuery.of(context).size.width * 0.4
                                : MediaQuery.of(context).size.width * 0.8,
                            child: const FittedBox(
                              child: Text(
                                "Build brighter future for you business with SCORE help\nKEEP YOUR EYES ON NEW POSSIPILITIES\nTRUST THE PROCESS",
                                style: TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                          if (isSignUp)
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.height * 0.3,
                              child: Form(
                                key: formKey,
                                autovalidateMode: AutovalidateMode.always,
                                onChanged: () {
                                  setState(() {
                                    Form.of(primaryFocus!.context!).save();
                                  });
                                },
                                child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          maxLines: 1,
                                          decoration: const InputDecoration(
                                              label: Text(
                                            "Enter your email",
                                            style: TextStyle(fontSize: 14),
                                          )),
                                          onSaved: (value) => email = value!,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "this field is required";
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context).requestFocus(
                                                passwordFocusNode);
                                          },
                                        ),
                                      )
                                          .animate()
                                          .fadeIn(
                                              duration: 2.seconds,
                                              curve: Curves.easeInOut)
                                          .moveY(
                                              curve: Curves
                                                  .fastEaseInToSlowEaseOut),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          maxLines: 1,
                                          decoration: const InputDecoration(
                                              label: Text(
                                            "Enter your password",
                                            style: TextStyle(fontSize: 14),
                                          )),
                                          onSaved: (value) => password = value!,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "this field is required";
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context).requestFocus(
                                                getStartedFocusNode);
                                          },
                                          focusNode: passwordFocusNode,
                                        ),
                                      )
                                          .animate(
                                              delay: const Duration(seconds: 1))
                                          .fadeIn(
                                              duration: 2.seconds,
                                              curve: Curves.easeInOut)
                                          .moveY(
                                              curve: Curves
                                                  .fastEaseInToSlowEaseOut),
                                    ])),
                              ),
                            ),
                          InkWell(
                              focusNode: getStartedFocusNode,
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/');
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.cyanAccent
                                                    .withOpacity(0.5),
                                                Colors.blueAccent
                                                    .withOpacity(0.5),
                                                Colors.blue.shade700
                                                    .withOpacity(0.5)
                                              ],
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topLeft)),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text("Get Started",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600)),
                                      ))
                                  .animate()
                                  .fadeIn(
                                      duration: 2.seconds,
                                      curve: Curves.easeInOut)
                                  .moveY(curve: Curves.fastEaseInToSlowEaseOut))
                        ],
                      )),
                  if (landscape)
                    Image.asset(
                            "assets/images/landing_screen_middle_vector_2.png")
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true))
                        .moveY(duration: 2.seconds, curve: Curves.easeInOut)
                ],
              ),
            ),
          );
        });
  }
}
