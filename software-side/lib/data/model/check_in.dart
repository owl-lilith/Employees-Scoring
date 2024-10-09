import 'employee.dart';

class CheckIn {
  final String employee_name;
  final String arrived_time;

  CheckIn({required this.employee_name, required this.arrived_time});
}

List<CheckIn> checkInList = getCheckInList();

List<CheckIn> getCheckInList() {
  List<CheckIn> list = [];
  for (Employee employee in employeesList) {
    list.add(CheckIn(
        employee_name: "${employee.first_name} ${employee.last_name}",
        arrived_time: employee.arrived_date!));
  }
  return list;
}
