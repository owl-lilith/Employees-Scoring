import '../../data/model/employee.dart';

class Purchase {
  final String employee_name;
  final int payment_attempt;

  Purchase({required this.employee_name, required this.payment_attempt});
}

List<Purchase> purchaseList = getPurchaseList();

List<Purchase> getPurchaseList() {
  List<Purchase> list = [];
  for (Employee employee in employeesList) {
    list.add(Purchase(
        employee_name: "${employee.first_name} ${employee.last_name}",
        payment_attempt: employee.payment_attempt!));
  }
  return list;
}
