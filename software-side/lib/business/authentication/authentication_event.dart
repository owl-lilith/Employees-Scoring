part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedActionEvent extends AuthenticationEvent {
  String email;
  String password;

  LoginButtonPressedActionEvent({required this.email, required this.password});
}

class LoginAPIErrorActionEvent extends AuthenticationEvent {
  String message;
  LoginAPIErrorActionEvent(this.message);
}
