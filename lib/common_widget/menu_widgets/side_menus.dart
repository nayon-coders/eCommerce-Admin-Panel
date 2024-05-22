import 'package:flutter/material.dart';

class SidebarMenuItems extends StatelessWidget {
  const SidebarMenuItems({super.key, required this.name, required this.onClick, required this.bgColor});

  final String name;
  final VoidCallback onClick;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        color: bgColor,
        padding: EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
        child: Text(name,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14
          ),
        ),
      ),
    );
  }
}
