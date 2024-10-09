part of 'theme_bloc.dart';
// import "package:equatable/equatable.dart";

@immutable
sealed class ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  final bool isDarkTheme;
  List<Object> get props => [];
  ChangeThemeEvent(this.isDarkTheme);
}
