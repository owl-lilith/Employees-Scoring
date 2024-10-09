import 'employee.dart';

class Disagreement {
  final String employee_name;
  final String employee_list;

  Disagreement({required this.employee_name, required this.employee_list});
}

List<Disagreement> disagreementList = getDisagreementList();

List<Disagreement> getDisagreementList() {
  List<Disagreement> list = [];

  for (Employee employee in employeesList) {
    if (employee.disagreement_over_customer!.isNotEmpty) {
      String disagreementOverCustomer = "";
      for (Employee element in employee.disagreement_over_customer!) {
        disagreementOverCustomer +=
            "${element.first_name} ${element.last_name}, ";
      }
      disagreementOverCustomer = disagreementOverCustomer.substring(
          0, disagreementOverCustomer.length - 2);
      list.add(Disagreement(
          employee_name: "${employee.first_name} ${employee.last_name}",
          employee_list: disagreementOverCustomer));
    }
  }
  return list;
}
