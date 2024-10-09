part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class LoginLoadingActionState extends AuthenticationState {}

class LoginSuccessfullyActionState extends AuthenticationState {}

class LoginErrorActionState extends AuthenticationState {
  String message;
  LoginErrorActionState(this.message);
}