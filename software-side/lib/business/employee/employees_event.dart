part of 'employees_bloc.dart';

sealed class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

class RefreshIndicatorScrolledActionEvent extends EmployeesEvent {}
