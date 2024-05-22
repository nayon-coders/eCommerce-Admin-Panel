import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({super.key, required this.width, required this.text});
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: width,
      child: Text("$text",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14
        ),
      ),
    );
  }
}


class TableRow extends StatelessWidget {
  const TableRow({super.key, required this.onTap, required this.width, required this.text});
  final VoidCallback onTap;
  final bool isClick = false;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isClick ? Colors.green : Colors.transparent
        ),
        width: width,
        height: isClick ? 40 : 20,
        child: isClick ? Center(
          child: Text("$text",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white
            ),
          ),
        ) : Text("$text",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14
          ),
        ),
      ),
    );
  }
}

