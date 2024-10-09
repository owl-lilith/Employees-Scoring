import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/model/employee.dart';

class LeaderBoardHeadersWidget extends StatelessWidget {
  Employee employee;
  Color color;
  LeaderBoardHeadersWidget({super.key, required this.employee, required this.color});

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.all(landscape ? 20 : 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      color.withOpacity(0.2),
                      color.withOpacity(0.2),
                      color.withOpacity(0.7),
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.asset(employee.primary_image_url,
                        height: landscape ? 150 : 100,
                        width: landscape ? 150 : 100)))
            .animate()
            .fadeIn(duration: 2.seconds, curve: Curves.easeInOut)
            .moveY(curve: Curves.fastEaseInToSlowEaseOut),
        Padding(
          padding: EdgeInsets.only(bottom: landscape ? 0 : 15),
          child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.all(landscape ? 20 : 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      gradient: LinearGradient(colors: [
                        color.withOpacity(0.2),
                        color,
                      ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text("${employee.totalPoints}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))))
              .animate()
              .fadeIn(duration: 4.seconds, curve: Curves.easeInOut)
              .moveY(curve: Curves.fastEaseInToSlowEaseOut),
        ),
        Text("${employee.first_name} ${employee.last_name}"),
      ],
    );
  }
}
