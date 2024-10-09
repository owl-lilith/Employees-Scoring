import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/api/api.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc() : super(EmployeesInitial()) {
    on<RefreshIndicatorScrolledActionEvent>(
        refreshIndicatorScrolledActionEvent);
  }

  FutureOr<void> refreshIndicatorScrolledActionEvent(
      RefreshIndicatorScrolledActionEvent event,
      Emitter<EmployeesState> emit) async {
    try {
      emit(EmployeesListLoadingActionState());
      // await post path
      await Future.delayed(const Duration(seconds: 1)).then((value) {
        getEmployeesList();
      });
      emit(EmployeesListSuccessfullyLoadedActionState());
    } catch (error) {
      print("error");
      print(error);
      emit(EmployeesListErrorActionState(error.toString()));
    }
  }
}
