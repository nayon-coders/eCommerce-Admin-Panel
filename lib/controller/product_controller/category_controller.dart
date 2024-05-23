import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:new_admin/model/product/category_model.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:snackbar/snackbar.dart';


class CategoryController{

  static   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;




  //add category
  static Future addCategory(Map<String, dynamic> categoryModel, context)async{
      var response = await _firebaseFirestore.collection(categoryCollection).add(categoryModel);
      print("Category Added: ${response.id}");
      Navigator.pop(context);
  }


  //get all category
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategory(){
    return _firebaseFirestore.collection(categoryCollection).snapshots();
  }


  //edit category
  static Future editCategory(String id, CategoryModel categoryModel)async{
    return _firebaseFirestore.collection(categoryCollection).doc(id).update(categoryModel.toJson()).then((value){
      AlertController.show("Updated...", "Category is updated", TypeAlert.success);
    });
  }



  //delete category
  static Future deleteCategory(id)async{
    print("deleted id ---- ${id}");
    return _firebaseFirestore.collection(categoryCollection).doc(id).delete().then((value) => AlertController.show("Deleted...", "Category is deleted", TypeAlert.success));
  }






  //add sub category



  //edit sub category




  //delete sub category




}