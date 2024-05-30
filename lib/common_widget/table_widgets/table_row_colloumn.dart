import 'package:flutter/material.dart';

class AppTableHeader extends StatelessWidget {
  const AppTableHeader({super.key, required this.width, required this.text});
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


class AppTableRow extends StatelessWidget {
  const AppTableRow({super.key, this.onTap, required this.width, required this.text, this.isClick = false, this.clickChild});
  final VoidCallback? onTap;
  final bool isClick;
  final double width;
  final String text;
  final Widget? clickChild;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
           // color: isClick ? Colors.green : Colors.transparent
        ),
        width: width,
        height: isClick ? 40 : 20,
        child: isClick ? clickChild : SizedBox(
          width: width,
          height: 100,
          child: Text("$text",
            // overflow: TextOverflow.ellipsis,
            // maxLines: 1,
            // softWrap: false,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
                    ),
        ),
      ),
    );
  }
}

