import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../data/api/api.dart';

part 'navigate_screen_event.dart';
part 'navigate_screen_state.dart';

enum CurrentScreen {
  mainScreen,
  services,
  employees,
  leaderBoard,
}

class NavigateScreenBloc
    extends Bloc<NavigateScreenEvent, NavigateScreenState> {
  NavigateScreenBloc() : super(NavigateScreenInitial()) {
    on<DrawerItemClickedEvent>(drawerItemClickedEvent);
    on<GetServicesListActionEvent>(getServicesListActionEvent);
  }
  FutureOr<void> getServicesListActionEvent(GetServicesListActionEvent event,
      Emitter<NavigateScreenState> emit) async {
    try {
      emit(GetServicesListLoadingActionState());
      // await post path
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => getServicesList());
      emit(GetServicesListSuccessfullyActionState(
          "Successfully Services Loaded"));
    } catch (error) {
      print("error");
      print(error);
      if (error.toString().contains("not connected")) {
        emit(GetServicesListErrorActionState(
            "Check your internet connection and try again."));
      } else {
        emit(GetServicesListErrorActionState(error.toString()));
      }
      emit(GetServicesListSuccessfullyActionState("You are Offline now"));
    }
  }

  FutureOr<void> drawerItemClickedEvent(
      DrawerItemClickedEvent event, Emitter<NavigateScreenState> emit) {
    emit(ChangeCurrentScreenActionState(event.currentScreen));
  }
}
