part of 'theme_bloc.dart';
// import "package:equatable/equatable.dart";

@immutable
class ThemeState {
   bool isDarkTheme;
     List<Object> get props => [isDarkTheme];
  ThemeState(this.isDarkTheme);
}

// abstract class ThemeActionState extends ThemeState {}

// final class ThemeInitial extends ThemeState {
//   bool isDarkTheme;
//   ThemeInitial(this.isDarkTheme);
// }

// class ChangeThemeActionState extends ThemeActionState {
//   final bool isDarkTheme;

//   ChangeThemeActionState({required this.isDarkTheme});
// }
