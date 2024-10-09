import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

bool isDarkTheme = true;

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDarkTheme)) {
    on<ChangeThemeEvent>(switchThemeClickedEvent);
  }

  FutureOr<void> switchThemeClickedEvent(
      ChangeThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState(event.isDarkTheme));
  }
}
