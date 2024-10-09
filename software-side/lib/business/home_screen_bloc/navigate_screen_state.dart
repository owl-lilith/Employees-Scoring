part of 'navigate_screen_bloc.dart';

@immutable
sealed class NavigateScreenState {}

abstract class NavigateScreenActionState extends NavigateScreenState {}

final class NavigateScreenInitial extends NavigateScreenState {
  CurrentScreen currentScreen = CurrentScreen.mainScreen;
}

class ChangeCurrentScreenActionState extends NavigateScreenActionState {
  final CurrentScreen currentScreen;

  ChangeCurrentScreenActionState(this.currentScreen);
}

class GetServicesListLoadingActionState extends NavigateScreenActionState {}

class GetServicesListSuccessfullyActionState
    extends NavigateScreenActionState {
      String message;
  GetServicesListSuccessfullyActionState(this.message);
    }

class GetServicesListErrorActionState extends NavigateScreenActionState {
  String message;
  GetServicesListErrorActionState(this.message);
}
