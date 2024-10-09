import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../presentation/widget/add_employee_service_widget.dart';

import '../../business/choose_services_bloc/choose_services_bloc.dart';
import '../../data/model/service.dart';
import '../widget/service_widget.dart';

class ChooseServicesScreen extends StatefulWidget {
  static const routeName = "/choose-services";
  String? _selectedFolderPath = path;

  bool isAddEmployee = false;
  bool isAddEmployeeImage = false;
  bool isAddEmployeePersonalInfo = false;
  bool isAddEmployeeJobInfo = false;

  ChooseServicesScreen({super.key});

  @override
  State<ChooseServicesScreen> createState() => _ChooseServicesScreenState();
}

class _ChooseServicesScreenState extends State<ChooseServicesScreen> {
  ChooseServicesBloc chooseServicesBloc = ChooseServicesBloc();
  @override
  Widget build(BuildContext context) {
    // Future<void> _pickFolder() async {
    //   chooseServicesBloc.add(BrowseFoldersActionEvent(_selectedFolderPath));
    //   String? selectedFolderPath = await FilePicker.platform.getDirectoryPath();

    //   if (selectedFolderPath != null) {
    //     setState(() {
    //       _selectedFolderPath = selectedFolderPath;
    //     });
    //   } else {
    //     // User canceled the picker
    //   }
    //   print(selectedFolderPath);
    // }

    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocConsumer<ChooseServicesBloc, ChooseServicesState>(
      bloc: chooseServicesBloc,
      listener: (context, state) async {
        switch (state.runtimeType) {
          case ReviewLoadingActionState:
            await Future.delayed(Duration.zero);
            // .then((_) async {
            //   getPersonDetection(widget._selectedFolderPath);
            // });
            break;
          case ReviewSuccessfullyActionState:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Successfully Reviewed")));
            break;
          case ReviewErrorActionState s:
            // state as BrowseErrorActionState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(s.message)));
            break;
          case BrowseLoadingActionState:
            await Future.delayed(Duration.zero).then((_) async {
              String? selectedFolderPath =
                  await FilePicker.platform.getDirectoryPath();
              if (selectedFolderPath != null) {
                setState(() {
                  widget._selectedFolderPath = selectedFolderPath;
                });
              } else {
                // chooseServicesBloc.add(error)
              }
            });
            break;
          case BrowseSuccessfullyActionState:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Successfully Browsed")));
            break;
          case BrowseErrorActionState s:
            // state as BrowseErrorActionState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(s.message)));
            break;
          default:
        }
      },
      builder: (context, state) {
        return ListView(
          children: [
            landscape
                ? Container(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.3,
                        right: MediaQuery.of(context).size.width * 0.3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [
                              Colors.cyanAccent.withOpacity(0.5),
                              Colors.blueAccent.withOpacity(0.5),
                              Colors.blue.shade700.withOpacity(0.5)
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextButton(
                            onPressed: () => setState(() {
                                  widget.isAddEmployee = !widget.isAddEmployee;
                                  widget.isAddEmployeeImage = true;
                                  widget.isAddEmployeePersonalInfo = true;
                                  widget.isAddEmployeeJobInfo = true;
                                }),
                            child: const Text("Add Employee",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)))))
                : Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text("Add Employee: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () => setState(() {
                                    widget.isAddEmployee = true;
                                    widget.isAddEmployeeImage =
                                        !widget.isAddEmployeeImage;
                                    widget.isAddEmployeePersonalInfo = false;
                                    widget.isAddEmployeeJobInfo = false;
                                  }),
                              child: const Text("Images")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () => setState(() {
                                    widget.isAddEmployee = true;
                                    widget.isAddEmployeeImage = false;
                                    widget.isAddEmployeePersonalInfo =
                                        !widget.isAddEmployeePersonalInfo;
                                    widget.isAddEmployeeJobInfo = false;
                                  }),
                              child: const Text("Personal Info")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () => setState(() {
                                    widget.isAddEmployee = true;
                                    widget.isAddEmployeeImage = false;
                                    widget.isAddEmployeePersonalInfo = false;
                                    widget.isAddEmployeeJobInfo =
                                        !widget.isAddEmployeeJobInfo;
                                  }),
                              child: const Text("Job Info")),
                        )
                      ],
                    ),
                  ),
            widget.isAddEmployee
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.isAddEmployeeImage
                          ? const AddEmployeeImagesServiceWidget()
                              .animate()
                              .fadeIn(
                                  duration: 1.seconds, curve: Curves.easeInOut)
                              .moveY(curve: Curves.fastEaseInToSlowEaseOut)
                          : Container(),
                      widget.isAddEmployeePersonalInfo
                          ? const AddEmployeePersonalInfoServiceWidget()
                              .animate()
                              .fadeIn(
                                  duration: 2.seconds, curve: Curves.easeInOut)
                              .moveY(curve: Curves.fastEaseInToSlowEaseOut)
                          : Container(),
                      widget.isAddEmployeeJobInfo
                          ? const AddEmployeeJobInfoServiceWidget()
                              .animate()
                              .fadeIn(
                                  duration: 3.seconds, curve: Curves.easeInOut)
                              .moveY(curve: Curves.fastEaseInToSlowEaseOut)
                          : Container()
                    ],
                  )
                : Container(),
            const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Browse Diractory Path",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            )),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: TextFormField(
                        controller: widget._selectedFolderPath != null
                            ? TextEditingController(
                                text: "${widget._selectedFolderPath}")
                            : TextEditingController(),
                        onSaved: (newValue) {},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            hintText: "enter path from your directory")),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (state.runtimeType == BrowseLoadingActionState)
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive())
                              : ElevatedButton(
                                  onPressed: () => chooseServicesBloc.add(
                                      BrowseFoldersActionEvent(
                                          widget._selectedFolderPath)),
                                  child: const Text("Browse")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (state.runtimeType == ReviewLoadingActionState)
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive())
                              : ElevatedButton(
                                  onPressed: () => chooseServicesBloc.add(
                                      ReviewPathActionEvent(
                                          widget._selectedFolderPath)),
                                  child: const Text("Review")),
                        ),
                      ],
                    )),
                if (landscape) const Expanded(flex: 5, child: SizedBox()),
              ],
            ),
            const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Adjust Services Points",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            )),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: landscape
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150.w,
                          mainAxisExtent: 180.h,
                          childAspectRatio: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: servicesList.length,
                        itemBuilder: (context, index) {
                          return ServiceWidget(servicesList[index]);
                        },
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        itemCount: servicesList.length,
                        itemBuilder: (context, index) {
                          return ServiceWidget(servicesList[index]);
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
