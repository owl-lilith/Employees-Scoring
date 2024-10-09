import 'package:flutter/material.dart';
import '../../business/theme_bloc/theme_bloc.dart';

class MenuDrawerTab extends StatelessWidget {
  String tab_name;
  IconData tab_icon;
  void Function() tab_action;

  MenuDrawerTab(
      {super.key,
      required this.tab_icon,
      required this.tab_name,
      required this.tab_action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tab_action,
      leading: Icon(
        tab_icon,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      title: Text(
        tab_name,
        style: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
