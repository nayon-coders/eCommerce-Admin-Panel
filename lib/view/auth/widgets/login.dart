import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_admin/common_widget/app_button/app_button.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/controller/auth_controller/auth_controller.dart';
import 'package:new_admin/utility/colors.dart';
import 'package:new_admin/view/main_page/main_page.dart';

import '../../dashboards/screens/dashboards.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({super.key, required this.onCreateButtonPress});
  final VoidCallback onCreateButtonPress;

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final _loginKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _pass = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Log In",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "You can login with your email and password",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputField(
                  controller: _email,
                  hintText: "Enter your email",
                ),
                SizedBox(
                  height: 15,
                ),
                AppInputField(
                  controller: _pass,
                  hintText: "Enter your password",
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Forget password?",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: AppColors.mainColor),
                ),
                SizedBox(
                  height: 20,
                ),
                AppButton(
                  isLoading: _isLoading,
                  onClick: () async{
                    setState(() {
                      _isLoading = true;
                    });
                    AuthController.adminLogin(
                      context: context,
                        email: _email.text, password: _pass.text);
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  text: "Login",
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
