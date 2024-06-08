import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:new_admin/view/auth/auth.dart';
import 'package:new_admin/view/main_page/main_page.dart';

class AuthController {
  static final _firebaseFirestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  //admin login
  static Future adminLogin({required BuildContext context, required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successful sign-in
      print('Signed in: ${userCredential.user?.email}');
      // Navigate to a different screen if needed
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainPage()), (route) => false);
    } catch ( e) {
      if(e.toString().contains("invalid-email")){
        appSnackBar(context: context, text: "Invalid email address");
      }if(e.toString().contains("invalid-credential")){
        appSnackBar(context: context, text: "Invalid credential");
      }
      print('Error signing in: $e');
      // Display an error message
    }
  }

  static logout(context){
    try{
      _auth.signOut();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Authentication()), (route) => false);
    }catch(e){
      print("logout --- ${e}");
    }
  }

}
