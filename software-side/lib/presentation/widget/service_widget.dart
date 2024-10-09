import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/service.dart';

class ServiceWidget extends StatefulWidget {
  Service service;
  ServiceWidget(this.service, {super.key});
  bool val = false;

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget editingDialog(BuildContext ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("edit service details:"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 1,
                decoration: const InputDecoration(
                    label: Text(
                  "Enter new points value",
                  style: TextStyle(fontSize: 14),
                )),
                onChanged: (value) => setState(() {
                  widget.service.points = int.parse(value);
                }),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "this field is required";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                // onFieldSubmitted: (value) {},
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      );
    }

    Widget serviceCardContent() {
      return Card(
        child: ListTile(
          leading: landscape
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Colors.cyanAccent.withOpacity(0.5),
                        Colors.blueAccent.withOpacity(0.5),
                        Colors.blue.shade700.withOpacity(0.5)
                      ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (ctx) {
                          return editingDialog(ctx);
                        }),
                  ))
              : const SizedBox(),
          title: Text(
            widget.service.name,
            maxLines: 2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("${widget.service.points} points"),
          ),
        ),
      );
    }

    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(10.w),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: landscape
            ? serviceCardContent()
            : Dismissible(
                behavior: HitTestBehavior.translucent,
                key: const ValueKey("value"),
                background: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.cyanAccent.withOpacity(0.5),
                      Colors.blue.shade700.withOpacity(0.5)
                    ]),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                  margin: EdgeInsets.only(top: 10.r, bottom: 10.r, right: 10.r),
                  padding: EdgeInsets.all(20.r),
                  child: const Icon(
                    Icons.edit,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => setState(() {
                      if (direction == DismissDirection.endToStart) {
                        print("edit");
                      }
                    }),
                confirmDismiss: (direction) {
                  return showDialog(
                      context: context,
                      builder: (ctx) {
                        return editingDialog(ctx);
                      });
                },
                child: serviceCardContent()));
  }
}
