import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/utility/app_const.dart';

class UserController{

  //instance for firebase firestore
  static final _firestore = FirebaseFirestore.instance;

  //get user list
  static Stream<QuerySnapshot<Map<String, dynamic>>>  getUserList(){
    return _firestore.collection(usersCollection).snapshots();
  }

  //get user list
  static Stream<QuerySnapshot<Map<String, dynamic>>>  getSingleUser(email){
    print("email -- $email");
    return _firestore.collection(usersCollection).where("email", isEqualTo: email).snapshots();
  }



  //update user
  static Future updateUserStatus(String id, BuildContext context, String status)async{
    try{
      _firestore.collection(usersCollection).doc(id).update({"status" : status});
      appSnackBar(context: context, text: "User status updated");
      Navigator.pop(context);
    }catch(e){
      print("getUserList --- $e");
    }
  }

}