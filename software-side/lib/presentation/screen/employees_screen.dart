import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business/employee/employees_bloc.dart';
import '../../data/model/employee.dart';
import '../../presentation/screen/employee_profile_screen.dart';
import '../../presentation/widget/employee_widget.dart';


class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  EmployeesBloc employeesBloc = EmployeesBloc();

  void displayEmployee(int index) {
    // Employee employee = getEmployee(employeesList[index].id);
    Employee employee = Employee(
        id: employeesList[index].id,
        first_name: employeesList[index].first_name,
        last_name: employeesList[index].last_name,
        primary_image_url: employeesList[index].primary_image_url,
        secondary_images_url: employeesList[index].secondary_images_url,
        totalPoints: employeesList[index].totalPoints,
        jobTitle: employeesList[index].jobTitle,
        phone_number: employeesList[index].phone_number,
        shift_starts: employeesList[index].shift_starts,
        shift_ends: employeesList[index].shift_ends,
        address: employeesList[index].address,
        info_description: employeesList[index].info_description,
        contract_begin: DateTime(2020, 9, 14),
        arrived_date: employeesList[index].arrived_date,
        clothes_changing_attempt: employeesList[index].clothes_changing_attempt,
        customer_count: employeesList[index].customer_count,
        not_working_event: employeesList[index].not_working_event,
        payment_attempt: employeesList[index].payment_attempt,
        pointsThisDay: employeesList[index].pointsThisDay,
        pointsThisMonth: employeesList[index].pointsThisMonth,
        disagreement_over_customer:
            employeesList[index].disagreement_over_customer);
    Navigator.of(context)
        .pushNamed(EmployeeProfileScreen.routeName, arguments: employee);
  }

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      bloc: employeesBloc,
      listener: (context, state) async {
        switch (state.runtimeType) {
          case EmployeesListLoadingActionState():
            await Future.delayed(Duration.zero);

            break;
          case EmployeesListSuccessfullyLoadedActionState():
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Successfully Reviewed")));
            break;
          case EmployeesListErrorActionState():
            state as EmployeesListErrorActionState;

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            break;
        }
      },
      builder: (context, state) {
        return RefreshIndicator.adaptive(
          backgroundColor: Colors.blue.withOpacity(0.5),
          onRefresh: () async {
            print("i am refreshing");

            employeesBloc.add(RefreshIndicatorScrolledActionEvent());
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: landscape
                ? GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 500,
                      mainAxisExtent: 300,
                      childAspectRatio: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: employeesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () => displayEmployee(index),
                          child: EmployeeWidget(employeesList[index]));
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: employeesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () => displayEmployee(index),
                          child: EmployeeWidget(employeesList[index]));
                    },
                  ),
          ),
        );
      },
    );
  }
}
