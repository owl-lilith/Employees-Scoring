
import 'package:flutter/material.dart';
import '../../data/model/employee.dart';
import '../../presentation/widget/leaderboard_widget.dart';
import '../widget/leaderBoard_headers_widget.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sortedEmployeeList =
        employeesList.sort((a, b) => a.totalPoints.compareTo(b.totalPoints));
    List<Employee> reversedEmployeeList = employeesList.reversed.toList();

    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    Widget LandScapeMode() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: 400,
              child: ListView(
                children: [
                  LeaderBoardHeadersWidget(
                    employee: reversedEmployeeList[1],
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: LeaderBoardHeadersWidget(
                      employee: reversedEmployeeList[0],
                      color: Colors.amberAccent,
                    ),
                  ),
                  LeaderBoardHeadersWidget(
                    employee: reversedEmployeeList[2],
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 500,
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: reversedEmployeeList.length - 3,
                  itemBuilder: (context, index) {
                    return LeaderBoardWidget(reversedEmployeeList[index + 3]);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget PortraitMode() {
      return Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              height: MediaQuery.of(context).size.height * 0.3,
              width: 500,
              alignment: Alignment.center,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  LeaderBoardHeadersWidget(
                    employee: reversedEmployeeList[1],
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: LeaderBoardHeadersWidget(
                      employee: reversedEmployeeList[0],
                      color: Colors.amberAccent,
                    ),
                  ),
                  LeaderBoardHeadersWidget(
                    employee: reversedEmployeeList[2],
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              width: 500,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: reversedEmployeeList.length - 3,
                itemBuilder: (context, index) {
                  return LeaderBoardWidget(reversedEmployeeList[index + 3]);
                },
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: landscape ? LandScapeMode() : PortraitMode());
  }
}
