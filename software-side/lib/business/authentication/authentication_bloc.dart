import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/api/api.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginButtonPressedActionEvent>(loginButtonPressedActionEvent);
    on<LoginAPIErrorActionEvent>(loginAPIErrorActionEvent);
  }
  FutureOr<void> loginButtonPressedActionEvent(
      LoginButtonPressedActionEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      // var response;
      emit(LoginLoadingActionState());
      // awit post path
      await Future.delayed(const Duration(seconds: 1)).then((value) {
        logIn(event.email, event.password);
      });

      emit(LoginSuccessfullyActionState());
    } catch (error) {
      print("error in bloc");
      print(error);
      emit(LoginErrorActionState(error.toString()));
    }
  }

  FutureOr<void> loginAPIErrorActionEvent(
      LoginAPIErrorActionEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginErrorActionState(event.message));
  }
}
