import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:new_admin/model/product/category_model.dart';

import '../../utility/app_const.dart';

class AppSettingController{
  
  //instance for firebase firestore 
  static final _firestore = FirebaseFirestore.instance; 
  
  //add logo 
  static void addLogo(BuildContext context, String logo){
    try{
      _firestore.collection(logoCollection).doc("app_logo").set({"logo" : logo});
      appSnackBar(context: context, text: "Logo uploaded success.");
    }catch(e){
      print("addLogo --- ${e}");
    }
  }


  //get logo
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getLogo(){
    return   _firestore.collection(logoCollection).doc("app_logo").snapshots();
  }


  //add banner
  static void addBanner(BuildContext context, String image, CategoryModel categoryModel){
    try{
      _firestore.collection(bannerCollection).add({
        "image" : image,
        "category" : categoryModel.toJson()
      }
      );
      appSnackBar(context: context, text: "Banner uploaded success.");
    }catch(e){
      print("addLogo --- ${e}");
    }
  }


  //get banner
  static Stream<QuerySnapshot<Map<String, dynamic>>> getBanners(){
    return _firestore.collection(bannerCollection).snapshots();
  }

  //delete banner
  static deleteBanner(String id, BuildContext context){
    try{
      _firestore.collection(bannerCollection).doc(id).delete();
      appSnackBar(context: context, text: "Banner deleted");
      Navigator.pop(context);
    }catch(e){
      print("deleteBanner --- $e");
    }
  }




  ///-------///
  //
  static addAboutUs(String text, BuildContext context){
    try{
      _firestore.collection(appSettingCollection).doc("app_settings").set({
        "about" : text
      });
      appSnackBar(context: context, text: "About us updated");
    }catch(e){
      print("addAboutUs --- ${e}"); 
    }
  }

  //get about us
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAboutUs(){
      return _firestore.collection(appSettingCollection).doc("app_settings").snapshots();
  }


  static addContactInfo(String text, BuildContext context){
    try{
      _firestore.collection(appSettingCollection).doc("app_settings").set({
        "about" : text
      });
      appSnackBar(context: context, text: "About us updated");
    }catch(e){
      print("addAboutUs --- ${e}");
    }
  }

  //get about us
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getContactInfo(){
    return _firestore.collection(appSettingCollection).doc("app_settings").snapshots();
  }


}
