import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_button/app_button.dart';
import 'package:new_admin/controller/user_controller/user_controller.dart';
import 'package:new_admin/model/user_model/user_model.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({super.key, required this.userModel, required this.docId});
  final UserModel userModel;
  final String docId;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('User Info: '),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Customer Name: ${widget.userModel!.name}'),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
            Text('Customer Email: ${widget.userModel!.email}'),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
            Text('Account Status: ${widget.userModel!.status}'),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
            AppButton(bgColor:  widget.userModel!.status == "Deactivate" ?  Colors.green : Colors.red, onClick: (){
             widget.userModel!.status == "Deactivate" ?   UserController.updateUserStatus(widget.docId, context, "Active") :  UserController.updateUserStatus(widget.docId, context, "Deactivate");
            }, text: "Change Status")
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
