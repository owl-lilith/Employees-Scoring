import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/model/check_in.dart';
import '../../data/model/customer_alone.dart';
import '../../data/model/dissagreement.dart';
import '../../data/model/employee.dart';
import '../../data/model/purchase.dart';
import '../../presentation/widget/leaderBoard_headers_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final isTouched = true; // Set this to true to highlight a section

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var sortedEmployeeList =
        employeesList.sort((a, b) => a.totalPoints.compareTo(b.totalPoints));
    List<Employee> reversedEmployeeList = employeesList.reversed.toList();

    return Container(
        child: landscape
            ? Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text("Employees Check In Moment",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(flex: 1, child: CheckInWidget()),
                          Text("Employees Not Working While Customer Around",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(flex: 1, child: CustomerAloneWidget())
                        ],
                      )),
                  const Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text("Employees Disagreement over Customer",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(flex: 1, child: DisagreementWidget()),
                        Text("Purchases Attempts",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(flex: 1, child: PurchaseWidget()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: EmployeeOfToday(
                        reversedEmployeeList: reversedEmployeeList),
                  )
                ],
              )
            : SizedBox(
                height: height,
                width: width,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: EmployeeOfToday(
                          reversedEmployeeList: reversedEmployeeList),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Employees Check In Moment",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                        height: checkInList.length * height * 0.08,
                        width: width * 0.9,
                        child: const CheckInWidget()),
                    const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                            "Employees Not Working While Customer Around",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: disagreementList.length * height * 0.15,
                      width: width * 0.9,
                      child: const DisagreementWidget(),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Employees Disagreement over Customer",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: height * 0.4,
                      width: width * 0.9,
                      child: const PurchaseWidget(),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Purchases Attempts",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: customerAloneList.length * height * 0.15,
                      width: width * 0.9,
                      child: const CustomerAloneWidget(),
                    ),
                  ],
                ),
              ));
  }
}

class EmployeeOfToday extends StatelessWidget {
  const EmployeeOfToday({
    super.key,
    required this.reversedEmployeeList,
  });

  final List<Employee> reversedEmployeeList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Employee of The Day",
              style: TextStyle(fontWeight: FontWeight.bold)),
          LeaderBoardHeadersWidget(
            employee: reversedEmployeeList[0],
            color: Colors.blueAccent.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

class CustomerAloneWidget extends StatelessWidget {
  const CustomerAloneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.cyanAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.blue.shade700.withOpacity(0.5)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: customerAloneList.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(
                          customerAloneList[index].employee_list,
                        ),
                        subtitle:
                            Text(customerAloneList[index].time_moment),
                      ),
                    )))
        .animate()
        .fadeIn(duration: 4.seconds, curve: Curves.easeInOut)
        .moveY(curve: Curves.fastEaseInToSlowEaseOut);
  }
}

class PurchaseWidget extends StatelessWidget {
  const PurchaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: PieChart(
        PieChartData(
          sections: showingSections(),
          centerSpaceRadius: 40,
          sectionsSpace: 10,
          borderData: FlBorderData(show: false),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 3.seconds, curve: Curves.easeInOut)
        .moveY(curve: Curves.fastEaseInToSlowEaseOut);
  }

  List<PieChartSectionData> showingSections() {
    List<Color> colors = [
      Colors.cyan,
      Colors.blue,
      Colors.blueGrey,
      Colors.deepPurpleAccent,
      Colors.grey
    ];

    int totalPurchases = 0;
    for (var element in purchaseList) {
      totalPurchases += element.payment_attempt;
    }
  
    return List.generate(purchaseList.length, (i) {
      // final double fontSize = isTouched ? 25.0 : 12.0;
      return PieChartSectionData(
        color: colors[i % colors.length],
        value: purchaseList[i].payment_attempt / totalPurchases,
        title:
            "${purchaseList[i].employee_name} ${(purchaseList[i].payment_attempt / totalPurchases * 100).floor()}%",
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }
}

class DisagreementWidget extends StatelessWidget {
  const DisagreementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.cyanAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.blue.shade700.withOpacity(0.5)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: disagreementList.length,
              itemBuilder: (context, index) => Card(
                  child: ListTile(
                title: Text(
                  disagreementList[index].employee_name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(disagreementList[index].employee_list),
              )),
            ))
        .animate()
        .fadeIn(duration: 2.seconds, curve: Curves.easeInOut)
        .moveY(curve: Curves.fastEaseInToSlowEaseOut);
  }
}

class CheckInWidget extends StatelessWidget {
  const CheckInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.cyanAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.blue.shade700.withOpacity(0.5)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: checkInList.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(
                          checkInList[index].employee_name,
                        ),
                        trailing: Text(checkInList[index].arrived_time),
                      ),
                    )))
        .animate()
        .fadeIn(duration: 1.seconds, curve: Curves.easeInOut)
        .moveY(curve: Curves.fastEaseInToSlowEaseOut);
  }
}
