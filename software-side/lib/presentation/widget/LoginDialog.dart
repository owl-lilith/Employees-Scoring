import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business/authentication/authentication_bloc.dart';
// import '../Controllers/LoginPageController.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  String email = "";
  String password = "";
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listener: (context, state) async {
        switch (state.runtimeType) {
          case LoginLoadingActionState:
            await Future.delayed(Duration.zero);
            break;
          case LoginSuccessfullyActionState:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Successfully Logged in")));
            Navigator.pushReplacementNamed(context, '/');
            break;
          case LoginErrorActionState:
            state as LoginErrorActionState;
            setState(() {
              errorMessage = state.message;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            break;
        }
      },
      builder: (context, state) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 20,
          // clipBehavior: Clip.hardEdge,
          child: Container(
            padding: EdgeInsets.all(20.w),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.5,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextField(
                    onChanged: (value) => setState(() {
                      email = value;
                    }),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    onChanged: (value) => setState(() {
                      password = value;
                    }),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  (state.runtimeType == LoginLoadingActionState)
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : InkWell(
                          onTap: () {
                            authenticationBloc.add(
                                LoginButtonPressedActionEvent(
                                    email: email, password: password));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.cyanAccent.withOpacity(0.5),
                                            Colors.blueAccent.withOpacity(0.5),
                                            Colors.blue.shade700
                                                .withOpacity(0.5)
                                          ],
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft)),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text("Log in",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ))
                              .animate()
                              .fadeIn(
                                  duration: NumDurationExtensions(2).seconds,
                                  curve: Curves.easeInOut)
                              .moveY(curve: Curves.fastEaseInToSlowEaseOut))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
