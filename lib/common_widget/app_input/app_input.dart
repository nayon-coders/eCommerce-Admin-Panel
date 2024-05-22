import 'package:flutter/material.dart';


class AppInputField extends StatelessWidget {
  const AppInputField({super.key, required this.controller, required this.hintText, this.maxLine,this.keyboardType,  this.type, this.onTab, this.focusNode, this.validator});

  final TextEditingController controller;
  final String hintText;
  final int? maxLine;
  final TextInputType? keyboardType;
  final String? type;
  final VoidCallback? onTab;
  final FocusNode? focusNode;
  final String Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTab,
      focusNode: focusNode,
      maxLines: maxLine,
      keyboardType: keyboardType,
      keyboardAppearance: Brightness.light,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade200)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade200)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade200)
          ),
          hintText: "${hintText}"
      ),

      validator: validator

    );
  }
}
