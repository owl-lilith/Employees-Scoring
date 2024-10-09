import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../data/model/service.dart';
import '../../data/api/api.dart';
// import 'package:equatable/equatable.dart';

part 'choose_services_event.dart';
part 'choose_services_state.dart';

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

class ChooseServicesBloc
    extends Bloc<ChooseServicesEvent, ChooseServicesState> {
  ChooseServicesBloc() : super(ChooseServicesInitial()) {
    on<BrowseFoldersActionEvent>(browseFoldersActionEvent);
    on<ReviewPathActionEvent>(reviewPathActionEvent);
    on<AddEmployeeImagesActionEvent>(addEmployeeImagesActionEvent);
  }

  FutureOr<void> browseFoldersActionEvent(
      BrowseFoldersActionEvent event, Emitter<ChooseServicesState> emit) async {
    try {
      emit(BrowseLoadingActionState());
      // awit post path
      await Future.delayed(const Duration(seconds: 1));
      emit(BrowseSuccessfullyActionState());
      await Future.delayed(const Duration(seconds: 1)).then((value) {
        print(event.selectedFolderPath!);
        editServicesList(
            path: event.selectedFolderPath!,
            check_in_points: servicesList[0].points,
            time_spent_with_costumer_points: servicesList[1].points,
            payment_points: servicesList[2].points,
            changing_room_points: servicesList[3].points,
            disagreement_points: servicesList[4].points);
      });
    } catch (error) {
      emit(BrowseErrorActionState(error.toString()));
    }
  }

  FutureOr<void> reviewPathActionEvent(
      ReviewPathActionEvent event, Emitter<ChooseServicesState> emit) async {
    try {
      emit(ReviewLoadingActionState());
      // awit post path
      await Future.delayed(const Duration(seconds: 1));

      emit(ReviewSuccessfullyActionState());
    } catch (error) {
      emit(ReviewErrorActionState(error.toString()));
    }
  }

  FutureOr<void> addEmployeeImagesActionEvent(
      AddEmployeeImagesActionEvent event,
      Emitter<ChooseServicesState> emit) async {
    try {
      print("loading");
      emit(AddEmployeeImageLoadingActionState());

      await Future.delayed(const Duration(seconds: 1)).then((value) {});
      if (event.firstName != null) firstName = event.firstName;
      if (event.lastName != null) lastName = event.lastName;
      if (event.email != null) email = event.email;
      if (event.phoneNumber != null) phoneNumber = event.phoneNumber;
      if (event.address != null) address = event.address;
      if (event.birthday != null) birthday = event.birthday;
      if (event.position != null) position = event.position;
      if (event.department != null) department = event.department;
      if (event.salary != null) salary = event.salary;
      if (event.contractDate != null) contractDate = event.contractDate;
      if (event.primaryImage != null) primaryImage = event.primaryImage;
      if (event.secondaryImagesList != null) {
        secondaryImagesList = event.secondaryImagesList;
      }
      print("firstName: $firstName");
      print("lastName: $lastName");
      print("email: $email");
      print("phoneNumber: $phoneNumber");
      print("address: $address");
      print("birthday: $birthday");
      print("position: $position");
      print("department: $department");
      print("salary: $salary");
      print("contractDate: $contractDate");
      print("primaryImage: $primaryImage");
      print("secondaryImagesList: $secondaryImagesList");
      if (firstName != null &&
          lastName != null &&
          email != null &&
          phoneNumber != null &&
          address != null &&
          birthday != null &&
          position != null &&
          department != null &&
          salary != null &&
          contractDate != null &&
          primaryImage != null &&
          secondaryImagesList != null) {
        print("submit");
        emit(AddEmployeeImageLoadingActionState());
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          addEmployee(
              firstName!,
              lastName!,
              email!,
              phoneNumber!,
              address!,
              birthday!,
              position!,
              department!,
              salary!,
              contractDate!,
              primaryImage!,
              secondaryImagesList!);
        });
        emit(AddEmployeeImageSuccessfullyActionState(
            "Successfully Employee Information Uploaded"));
      } else {
        emit(AddEmployeeImageSuccessfullyActionState(
            "Continue Filling The Rest of Information"));
      }
    } catch (error) {
      emit(AddEmployeeImageErrorActionState(error.toString()));
    }
  }
}
