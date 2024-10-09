part of 'choose_services_bloc.dart';

// sealed class ChooseServicesState extends Equatable {
sealed class ChooseServicesState {
  const ChooseServicesState();

  @override
  List<Object> get props => [];
}

final class ChooseServicesInitial extends ChooseServicesState {
  String selectedFolderPath = "Anonyms";
}

class BrowseLoadingActionState extends ChooseServicesState {}

class BrowseSuccessfullyActionState extends ChooseServicesState {}

class BrowseErrorActionState extends ChooseServicesState {
  String message;
  BrowseErrorActionState(this.message);
}

class ReviewLoadingActionState extends ChooseServicesState {}

class ReviewSuccessfullyActionState extends ChooseServicesState {}

class ReviewErrorActionState extends ChooseServicesState {
  String message;
  ReviewErrorActionState(this.message);
}

class AddEmployeeImageLoadingActionState extends ChooseServicesState {}

class AddEmployeeImageSuccessfullyActionState extends ChooseServicesState {
   String message;
  AddEmployeeImageSuccessfullyActionState(this.message);
}

class AddEmployeeImageErrorActionState extends ChooseServicesState {
  String message;
  AddEmployeeImageErrorActionState(this.message);
}
