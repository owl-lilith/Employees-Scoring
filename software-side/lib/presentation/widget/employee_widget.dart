import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/employee.dart';

class EmployeeWidget extends StatelessWidget {
  Employee employee;
  EmployeeWidget(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 230,
      padding: EdgeInsets.all(10.w),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(employee.primary_image_url,
                          height: 100, width: 100)),
                  Expanded(
                    // height: 100,
                    child: ListTile(
                      title:
                          Text("${employee.first_name} ${employee.last_name}"),
                      subtitle: Text("${employee.jobTitle}"),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      leading: const Icon(Icons.work_history),
                      title: Text(
                          "${employee.shift_starts} - ${employee.shift_ends}"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(employee.phone_number),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
