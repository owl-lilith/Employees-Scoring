part of 'choose_services_bloc.dart';

// sealed class ChooseServicesEvent extends Equatable {
sealed class ChooseServicesEvent {
  const ChooseServicesEvent();

  @override
  List<Object> get props => [];
}

class BrowseFoldersActionEvent extends ChooseServicesEvent {
  String? selectedFolderPath;
  BrowseFoldersActionEvent(this.selectedFolderPath);
}


class ReviewPathActionEvent extends ChooseServicesEvent {
  String? selectedFolderPath;
  ReviewPathActionEvent(this.selectedFolderPath);
}

class JobInfoActionEvent extends ChooseServicesEvent {
  String position;
  String department;
  String salary;
  DateTime contractDate;
  JobInfoActionEvent({
    required this.position,
    required this.department,
    required this.salary,
    required this.contractDate,
  });
}

class PersonalInfoActionEvent extends ChooseServicesEvent {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  DateTime birthday;
  PersonalInfoActionEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.birthday,
  });
}

class AddEmployeeImagesActionEvent extends ChooseServicesEvent {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? address;
  DateTime? birthday;
  String? position;
  String? department;
  String? salary;
  DateTime? contractDate;
  File? primaryImage;
  List<File>? secondaryImagesList;
  AddEmployeeImagesActionEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.position,
    this.department,
    this.salary,
    this.contractDate,
    this.primaryImage,
    this.secondaryImagesList,
  });
}
