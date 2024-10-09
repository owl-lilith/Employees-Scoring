part of 'employees_bloc.dart';

sealed class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

final class EmployeesInitial extends EmployeesState {}

class EmployeesListLoadingActionState extends EmployeesState {}

class EmployeesListSuccessfullyLoadedActionState extends EmployeesState {}

class EmployeesListErrorActionState extends EmployeesState {
  String message;
  EmployeesListErrorActionState(this.message);
}