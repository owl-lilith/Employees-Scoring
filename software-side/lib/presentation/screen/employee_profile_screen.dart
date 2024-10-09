// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/model/employee.dart';

class EmployeeProfileScreen extends StatelessWidget {
  static String routeName = "/employee-profile";

  const EmployeeProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var employee = ModalRoute.of(context)!.settings.arguments as Employee;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          alignment: Alignment.center,
          height: height * 0.9,
          width: width * 0.9,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                Colors.cyanAccent.withOpacity(0.5),
                Colors.blueAccent.withOpacity(0.5),
                Colors.blue.shade700.withOpacity(0.5)
              ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        ),
        Container(
            padding: EdgeInsets.only(
              bottom: height * 0.05,
              top: height * 0.05,
              right: width * 0.07,
              left: width * 0.07,
            ),
            child: landscape
                ? Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: BasicInfo(employee: employee, width: width)),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: ProgressInfo(employee: employee)),
                            Expanded(
                                flex: 3,
                                child: RedFlageInfo(
                                    height: height, employee: employee)),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: height * 0.9,
                    width: width,
                    child: ListView(
                      children: [
                        BasicInfo(employee: employee, width: width),
                        ProgressInfo(employee: employee),
                        RedFlageInfo(height: height, employee: employee)
                      ],
                    ),
                  ))
      ]),
    );
  }
}

class RedFlageInfo extends StatelessWidget {
  const RedFlageInfo({
    super.key,
    required this.height,
    required this.employee,
  });

  final double height;
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      children: [
        Divider(),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: landscape ? height * 0.4 : height,
            // employee.disagreement_over_customer!.isEmpty
            //     ? height * 0.3
            //     : landscape
            //         ? height * 0.4
            //         : height *
            //             0.3 *
            //             employee.disagreement_over_customer!.length,
            child: landscape
                ? Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: DisagreementListViewWidget(
                              employee: employee, landscape: landscape)),
                      Expanded(
                        flex: 1,
                        child: NotWorkingEventGridViewWidget(
                            employee: employee, landscape: landscape),
                      ),
                    ],
                  )
                : Column(children: [
                    Expanded(
                        flex: employee.disagreement_over_customer != null
                            ? employee.disagreement_over_customer!.length * 2
                            : 1,
                        child: DisagreementListViewWidget(
                            employee: employee, landscape: landscape)),
                    Expanded(
                      flex: 2,
                      child: NotWorkingEventGridViewWidget(
                          employee: employee, landscape: landscape),
                    ),
                  ])),
      ],
    );
  }
}

class NotWorkingEventGridViewWidget extends StatelessWidget {
  const NotWorkingEventGridViewWidget({
    super.key,
    required this.employee,
    required this.landscape,
  });

  final Employee employee;
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text(
              employee.not_working_event!.isEmpty
                  ? "Kept Active All Day Long"
                  : "Not Working While There is Customer Around, at:",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 10,
          child: GridView.builder(
              physics:
                  landscape ? ScrollPhysics() : NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(5),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                mainAxisExtent: 50,
                childAspectRatio: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: employee.not_working_event!.length,
              itemBuilder: (context, index) {
                String time = employee.not_working_event![index];
                return Card(
                  elevation: 5,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(time)),
                ).animate().scale(
                    duration: Duration(seconds: index + 2),
                    begin: Offset(1.3, 1.3),
                    curve: Curves.fastEaseInToSlowEaseOut);
              }),
        ),
      ],
    );
  }
}

class DisagreementListViewWidget extends StatelessWidget {
  const DisagreementListViewWidget({
    super.key,
    required this.employee,
    required this.landscape,
  });

  final Employee employee;
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text(
              employee.disagreement_over_customer!.isEmpty
                  ? "Didn't Disagree With Other Employees"
                  : "Disagreement Over Customer, with:",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 10,
          child: ListView.builder(
              physics:
                  landscape ? ScrollPhysics() : NeverScrollableScrollPhysics(),
              itemCount: employee.disagreement_over_customer!.length,
              itemBuilder: (context, index) {
                Employee emp = employee.disagreement_over_customer![index];
                return DisagreementEmployee(emp: emp);
              }),
        ),
      ],
    );
  }
}

class DisagreementEmployee extends StatelessWidget {
  Employee emp;
  DisagreementEmployee({
    required this.emp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset(emp.primary_image_url,
                            height: 50, width: 50)),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListTile(
                      title: FittedBox(
                        child: Text("${emp.first_name} ${emp.last_name}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      subtitle: Text("${emp.jobTitle}"),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      leading: Icon(Icons.work_history),
                      title: FittedBox(
                          child:
                              Text("${emp.shift_starts} - ${emp.shift_ends}")),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: FittedBox(child: Text(emp.phone_number)),
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

class ProgressInfo extends StatelessWidget {
  const ProgressInfo({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: landscape
            ? SizedBox(
                height: 300,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("${employee.info_description}"),
                    ),
                    Divider(),
                    Row(
                      children: [
                        CustomerCount(employee: employee),
                        Score(employee: employee),
                      ],
                    )
                  ],
                ),
              )
            : SizedBox(
                height: 350,
                width: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("${employee.info_description}"),
                    ),
                    Divider(),
                    CustomerCount(employee: employee),
                    Score(employee: employee),
                  ],
                ),
              ),
      ),
    );
  }
}

class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 100,
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text("sc",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Image.asset(
                        "assets/images/logo_1.png",
                        width: 35,
                      ),
                      Text("re",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      height: 40,
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
                      child: Text("${employee.totalPoints}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ).animate().scale(
                    duration: Duration(seconds: 2),
                    begin: Offset(1.5, 1.5),
                    curve: Curves.fastEaseInToSlowEaseOut)
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "this day: ${employee.pointsThisDay}\nthis month: ${employee.pointsThisMonth}"),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerCount extends StatelessWidget {
  const CustomerCount({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 100,
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "customer count",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      height: 40,
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
                      child: Text("${employee.customer_count}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ).animate().scale(
                    duration: Duration(seconds: 1),
                    begin: Offset(1.5, 1.5),
                    curve: Curves.fastEaseInToSlowEaseOut)
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "clothes changing attempt: ${employee.clothes_changing_attempt}\npayment attempt: ${employee.payment_attempt}"),
            ),
          ),
        ),
      ),
    );
  }
}

class BasicInfo extends StatelessWidget {
  const BasicInfo({
    super.key,
    required this.employee,
    required this.width,
  });

  final Employee employee;
  final double width;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Card(
      child: Container(
        height: height * 0.85,
        width: width * 0.5,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: landscape ? 300 : 300,
                height: 400,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      employee.primary_image_url,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${employee.first_name} ${employee.last_name}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text(
                      "${employee.jobTitle}",
                      maxLines: 2,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      "${employee.address}",
                      maxLines: 1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      employee.phone_number,
                      maxLines: 1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.av_timer),
                    title: Text(
                      "${employee.shift_starts} - ${employee.shift_ends}",
                      maxLines: 1,
                    ),
                  ),
                  Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.cyanAccent.withOpacity(0.5),
                                    Colors.blueAccent.withOpacity(0.5),
                                    Colors.blue.shade700.withOpacity(0.5)
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft)),
                          child: Text("check in at : ${employee.arrived_date}"))
                      .animate()
                      .scale(
                          duration: Duration(seconds: 2),
                          begin: Offset(1.1, 1.1),
                          curve: Curves.fastEaseInToSlowEaseOut),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:fl_chart/fl_chart.dart';

// List<String> titleList = [
//   "Total points",
//   "Points this month",
//   "Points this day",
//   "Services",
//   "Bonus points"
// ];
// List<String> dataList = ["30,000", "5,900", "1,200", "21", "+900"];
// Map<String, double> dataMap = {
//   "Attended": 21,
//   "Missed": 3,
//   "Vacation": 5,
//   "Excused": 2,
// };
// final colorList = <Color>[
//   Colors.greenAccent,
//   Colors.red,
//   Colors.black,
//   Colors.orange,
// ];

// PieChart(
                      //   PieChartData(
                      //     pieTouchData: PieTouchData(
                      //       touchCallback: (FlTouchEvent event,
                      //           pieTouchResponse) {}, // Empty callback to avoid null check
                      //     ),
                      //     borderData: FlBorderData(
                      //       show: false,
                      //     ),
                      //     sections: pieChartSections,
                      //     centerSpaceRadius: 40,
                      //     // animateSections: false, // Disable animation
                      //   ),
                      // )

 // SizedBox(
                  //     height: MediaQuery.of(context).size.height * (0.45),
                  //     width: MediaQuery.of(context).size.width * (0.75),
                  //     // child: Image.asset(
                  //     //   "assets/images/ff.jpg",
                  //     //   fit: BoxFit.fill,
                  //     // ),
                  //     child: LineChart(
                  //       SampleLineChartData(),
                  //     )),

// LineChartData SampleLineChartData() {
//   return LineChartData(
//     gridData: FlGridData(
//       show: true,
//       horizontalInterval: 1,
//       verticalInterval: 1,
//       getDrawingHorizontalLine: (value) => const FlLine(
//         color: Colors.grey,
//         strokeWidth: 1,
//       ),
//       getDrawingVerticalLine: (value) => const FlLine(
//         color: Colors.grey,
//         strokeWidth: 1,
//       ),
//     ),
//     titlesData: FlTitlesData(
//       show: true,
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           getTitlesWidget: (value, meta) => Text(
//             [
//               'Jan',
//               'Feb',
//               'Mar',
//               'Apr',
//               'May',
//               'Jun',
//               'Jul',
//               'Aug',
//               'Sep',
//               'Oct',
//               'Nov',
//               'Dec'
//             ][value.toInt()],
//             style: const TextStyle(color: Colors.black, fontSize: 12),
//           ),
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           interval: 2,
//           getTitlesWidget: (value, meta) {
//             if (value == 0) {
//               return Text('0',
//                   style: const TextStyle(color: Colors.black, fontSize: 12));
//             } else {
//               return Text((value * 2).toString(),
//                   style: const TextStyle(color: Colors.black, fontSize: 12));
//             }
//           },
//         ),
//       ),
//       topTitles: const AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       rightTitles: const AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//     ),
//     borderData:
//         FlBorderData(show: true, border: Border.all(color: Colors.grey)),
//     minX: 0,
//     maxX: 11,
//     minY: 0,
//     maxY: 10,
//     lineBarsData: [
//       LineChartBarData(
//         spots: const [
//           FlSpot(0, 3),
//           FlSpot(1, 5),
//           FlSpot(2, 6),
//           FlSpot(3, 4),
//           FlSpot(4, 8),
//           FlSpot(5, 2),
//           FlSpot(6, 7),
//           FlSpot(7, 1),
//           FlSpot(8, 9),
//           FlSpot(9, 5),
//           FlSpot(10, 3),
//           FlSpot(11, 2),
//         ],
//         isCurved: true,
//         barWidth: 2,
//         color: Colors.blue,
//         dotData: const FlDotData(
//           show: false,
//         ),
//       ),
//     ],
//   );
// }
