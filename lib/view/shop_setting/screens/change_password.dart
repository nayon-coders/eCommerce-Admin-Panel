import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_button/app_button.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/controller/app_setting/app_setting_controller.dart';
import 'package:new_admin/utility/app_const.dart';

import '../../../common_widget/app_text/title_text.dart';
import '../../../controller/auth_controller/auth_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();


  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade200,
        padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TitleText(text: "Change password"),
            SizedBox(height: 20,),
            Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInputField(controller: _newPassword, hintText: "New Password",),
                  SizedBox(height: 10,),
                  AppInputField(controller: _confirmPassword, hintText: "Confirm Password")
                ],
              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                AppButton(onClick: (){
                  if(_newPassword.text != _confirmPassword.text){
                    appSnackBar(context: context, text: "Confirm password not match");
                  }else{
                    AppSettingController.changePassword(_confirmPassword.text, context);
                  }

                }, text: "Update"),
                SizedBox(width: 20,),
                AppButton(onClick: (){
                  appAlertDialog(context: context, child: Text("Are you sure? Do you want to logout?"), onClick: (){
                    AuthController.logout(context);
                  });
                }, bgColor: Colors.red, text: "Logout")
              ],
            )


          ],
        ),
      ),
    );
  }
}
