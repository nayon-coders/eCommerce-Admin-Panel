import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_button/app_button.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/controller/app_setting/app_setting_controller.dart';


class PrivacyPolicay extends StatefulWidget {
  const PrivacyPolicay({super.key});

  @override
  State<PrivacyPolicay> createState() => _PrivacyPolicayState();
}

class _PrivacyPolicayState extends State<PrivacyPolicay> {

  final _aboutInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(20),
      child: StreamBuilder(
          stream: AppSettingController.getAboutUs(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            _aboutInput.text = snapshot.data!.data()!["privacy"];
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(text: "Terms & Policy"),
                  SizedBox(height: 20,),
                  AppInputField(controller: _aboutInput, hintText: "Terms & policy...", maxLine: 10, ),
                  SizedBox(height: 20,),
                  AppButton(onClick: (){
                    AppSettingController.addPrivacy(_aboutInput.text, context);
                  }, text: "Update")


                ],
              ),
            );
          }
      ),
    );
  }
}
