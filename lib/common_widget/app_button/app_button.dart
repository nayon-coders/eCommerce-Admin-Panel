import 'package:flutter/material.dart';
import 'package:new_admin/utility/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.onClick,
      required this.text,
      this.isLoading = false,
      this.width = 200,
      this.bgColor = AppColors.mainColor});
  final VoidCallback onClick;
  final String text;
  final bool isLoading;
  final double width;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        padding: EdgeInsets.only(left: 25, right: 25, top: 9, bottom: 9),
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Center(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  "${text}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}
