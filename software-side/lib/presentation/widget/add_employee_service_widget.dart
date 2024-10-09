import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business/choose_services_bloc/choose_services_bloc.dart';
import '../../data/model/employee.dart';

Employee? employee;
ChooseServicesBloc chooseServicesBloc = ChooseServicesBloc();

class AddEmployeeImagesServiceWidget extends StatefulWidget {
  const AddEmployeeImagesServiceWidget({super.key});

  @override
  State<AddEmployeeImagesServiceWidget> createState() =>
      _AddEmployeeImagesServiceWidgetState();
}

class _AddEmployeeImagesServiceWidgetState
    extends State<AddEmployeeImagesServiceWidget> {
  var formKey = GlobalKey<FormState>();
  File? primaryImage;
  List<File>? secondaryImagesList;
  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: landscape
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.cyanAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.blue.shade700.withOpacity(0.5)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: Form(
              key: formKey,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: landscape
                        ? MediaQuery.of(context).size.width * 0.3
                        : MediaQuery.of(context).size.width * 0.8,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );

                        if (result != null &&
                            result.files.single.path != null) {
                          setState(() {
                            primaryImage = File(result.files.single.path!);
                          });
                        }
                      },
                      child: Card(
                        // padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: primaryImage == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.blue.withOpacity(0.5),
                                    size: 60,
                                  ))
                              : Image.file(
                                  primaryImage!,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: true,
                        );

                        if (result != null) {
                          setState(() {
                            secondaryImagesList = result.paths
                                .map((path) => File(path!))
                                .toList();
                          });
                        }
                      },
                      child: const Text("add secondary images")),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 125,
                          mainAxisExtent: 75,
                          childAspectRatio: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: secondaryImagesList == null
                            ? 0
                            : secondaryImagesList!.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            secondaryImagesList![index],
                            fit: BoxFit.cover,
                          );
                        },
                      ))
                ],
              ),
            )),
        BlocConsumer<ChooseServicesBloc, ChooseServicesState>(
          bloc: chooseServicesBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return InkWell(
                onTap: () {
                  formKey.currentState!.save();
                  if (primaryImage != null && secondaryImagesList != null) {
                    chooseServicesBloc.add(AddEmployeeImagesActionEvent(
                        primaryImage: primaryImage!,
                        secondaryImagesList: secondaryImagesList!));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "you have to pick the primary image with at least one secondary image")));
                  }
                },
                borderRadius: BorderRadius.circular(15),
                child: state.runtimeType == AddEmployeeImageLoadingActionState
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : const Card(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.check),
                        ),
                        // color: Colors.blue.withOpacity(0.5),
                      ));
          },
        ),
      ],
    );
  }
}

class AddEmployeePersonalInfoServiceWidget extends StatefulWidget {
  const AddEmployeePersonalInfoServiceWidget({super.key});

  @override
  State<AddEmployeePersonalInfoServiceWidget> createState() =>
      _AddEmployeePersonalInfoServiceWidgetState();
}

class _AddEmployeePersonalInfoServiceWidgetState
    extends State<AddEmployeePersonalInfoServiceWidget> {
  var formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String address = "";
  DateTime? birthday;
  Widget TextFormFieldWidget(
      {required label,
      int maxline = 1,
      required void Function(String?) onSaved,
      FocusNode? node,
      void Function(String)? submit}) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        maxLines: maxline,
        decoration: InputDecoration(
            label: Text(
          label,
        )),
        onSaved: onSaved,
        validator: (value) {
          if (value!.isEmpty) return "this field required";
          return null;
        },
        textInputAction: TextInputAction.done,
        focusNode: node,
        onFieldSubmitted: submit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusNode lastNameField = FocusNode();
    FocusNode emailField = FocusNode();
    FocusNode phoneNumberField = FocusNode();
    FocusNode addressField = FocusNode();
    FocusNode birthdayField = FocusNode();
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: landscape
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.cyanAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.blue.shade700.withOpacity(0.5)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: Form(
              key: formKey,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextFormFieldWidget(
                      label: "First Name",
                      onSaved: (value) => firstName = value!,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(lastNameField);
                      }),
                  TextFormFieldWidget(
                      label: "Last Name",
                      onSaved: (value) => lastName = value!,
                      node: lastNameField,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(emailField);
                      }),
                  TextFormFieldWidget(
                      label: "Email",
                      onSaved: (value) => email = value!,
                      node: emailField,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(phoneNumberField);
                      }),
                  TextFormFieldWidget(
                      label: "Phone Number",
                      onSaved: (value) => phoneNumber = value!,
                      node: phoneNumberField,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(addressField);
                      }),
                  TextFormFieldWidget(
                      label: "address",
                      onSaved: (value) => address = value!,
                      node: addressField,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(birthdayField);
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(birthday == null
                                ? "Pick a Date"
                                : "${birthday!.year}-${birthday!.month}-${birthday!.day}")),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                focusNode: birthdayField,
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1924),
                                          lastDate:
                                              DateTime(DateTime.now().year),
                                          initialDatePickerMode:
                                              DatePickerMode.year)
                                      .then((value) => setState(() {
                                            birthday = value;
                                          }));
                                },
                                child: const Text("Birth Date")))
                      ],
                    ),
                  )
                ],
              ),
            )),
        BlocConsumer<ChooseServicesBloc, ChooseServicesState>(
            bloc: chooseServicesBloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return InkWell(
                  onTap: () {
                    formKey.currentState!.validate();
                    formKey.currentState!.save();
                    if (firstName != "" &&
                        lastName != "" &&
                        address != "" &&
                        email != "" &&
                        phoneNumber != "" &&
                        birthday != null) {
                      chooseServicesBloc.add(AddEmployeeImagesActionEvent(
                          firstName: firstName,
                          lastName: lastName,
                          address: address,
                          email: email,
                          phoneNumber: phoneNumber,
                          birthday: birthday));
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: state.runtimeType == AddEmployeeImageLoadingActionState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : const Card(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.check),
                          ),
                        ));
            }),
      ],
    );
  }
}

class AddEmployeeJobInfoServiceWidget extends StatefulWidget {
  const AddEmployeeJobInfoServiceWidget({super.key});

  @override
  State<AddEmployeeJobInfoServiceWidget> createState() =>
      _AddEmployeeJobInfoServiceWidgetState();
}

class _AddEmployeeJobInfoServiceWidgetState
    extends State<AddEmployeeJobInfoServiceWidget> {
  var formKey = GlobalKey<FormState>();
  String position = "";
  String department = "";
  String salary = "";
  DateTime? contractDate;
  Widget TextFormFieldWidget(
      {required label,
      int maxline = 1,
      required void Function(String?) onSaved,
      FocusNode? node,
      void Function(String)? submit}) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        maxLines: maxline,
        decoration: InputDecoration(
            label: Text(
          label,
        )),
        onSaved: onSaved,
        validator: (value) {
          if (value!.isEmpty) return "this field required";
          return null;
        },
        textInputAction: TextInputAction.done,
        focusNode: node,
        onFieldSubmitted: submit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusNode departmentField = FocusNode();
    FocusNode salaryField = FocusNode();
    FocusNode contractDateField = FocusNode();
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: landscape
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.cyanAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.blue.shade700.withOpacity(0.5)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: Form(
              key: formKey,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextFormFieldWidget(
                      label: "Position",
                      onSaved: (value) => setState(() {
                            position = value!;
                          }),
                      submit: (value) {
                        FocusScope.of(context).requestFocus(departmentField);
                      }),
                  TextFormFieldWidget(
                      label: "Department",
                      onSaved: (value) => department = value!,
                      node: departmentField,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(salaryField);
                      }),
                  TextFormFieldWidget(
                      label: "Salary",
                      onSaved: (value) => salary = value!,
                      node: salaryField,
                      submit: (value) {
                        FocusScope.of(context).requestFocus(contractDateField);
                      }),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(contractDate == null
                                  ? "Pick a Date"
                                  : "${contractDate!.year}-${contractDate!.month}-${contractDate!.day}")),
                          Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  focusNode: contractDateField,
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1924),
                                            lastDate:
                                                DateTime(DateTime.now().year),
                                            initialDatePickerMode:
                                                DatePickerMode.year)
                                        .then((value) => setState(() {
                                              contractDate = value;
                                            }));
                                  },
                                  child: const Text(
                                    "Contract Date",
                                    textAlign: TextAlign.center,
                                  )))
                        ],
                      )),
                ],
              ),
            )),
        BlocConsumer<ChooseServicesBloc, ChooseServicesState>(
            bloc: chooseServicesBloc,
            listener: (context, state) {
              switch (state.runtimeType) {
                case AddEmployeeImageSuccessfullyActionState:
                  state as AddEmployeeImageSuccessfullyActionState;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                case AddEmployeeImageErrorActionState:
                  state as AddEmployeeImageErrorActionState;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return InkWell(
                  onTap: () {
                    formKey.currentState!.validate();
                    formKey.currentState!.save();
                    if (position != "" ||
                        department != "" ||
                        salary != "" ||
                        contractDate != null) {
                      chooseServicesBloc.add(AddEmployeeImagesActionEvent(
                          position: position,
                          department: department,
                          salary: salary,
                          contractDate: contractDate));
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: state.runtimeType == AddEmployeeImageLoadingActionState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : const Card(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.check),
                          ),
                        ));
            }),
      ],
    );
  }
}
