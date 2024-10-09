import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/model/employee.dart';

class LeaderBoardWidget extends StatelessWidget {
  Employee employee;
  LeaderBoardWidget(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.asset(employee.primary_image_url,
                      height: landscape ? 100 : 50,
                      width: landscape ? 100 : 50)),
              Expanded(
                // height: 100,
                child: ListTile(
                  title: Text("${employee.first_name} ${employee.last_name}"),
                  trailing: Container(
                          padding: const EdgeInsets.all(10),
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text("${employee.totalPoints}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ))
                      .animate()
                      .fadeIn(duration: 2.seconds, curve: Curves.easeInOut)
                      .moveY(curve: Curves.fastEaseInToSlowEaseOut),
                ),
              )
            ],
          ),
        )));
  }
}
