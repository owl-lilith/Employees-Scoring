part of 'navigate_screen_bloc.dart';

@immutable
sealed class NavigateScreenEvent {}

class GetServicesListActionEvent extends NavigateScreenEvent {}

class DrawerItemClickedEvent extends NavigateScreenEvent {
  final CurrentScreen currentScreen;

  DrawerItemClickedEvent(this.currentScreen);
}
