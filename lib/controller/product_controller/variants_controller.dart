import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:new_admin/model/product/variants_model.dart';
import 'package:new_admin/utility/app_const.dart';

class VariantsController{

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add variants
  static Future addVariants(VariantsModel variantsModel)async{
    try{
      await _firestore.collection(variantCollection).add(variantsModel.toJson()).then((value) {
        print("addVariants success --------- $value");
        AlertController.show("Variants added", "Variants added successfully.", TypeAlert.success);
      });

    }catch(e){
      print("addVariants error --------- $e");
    }
  }

  //get variants
  static Stream<QuerySnapshot<Map<String, dynamic>>> getVariants(){
    return _firestore.collection(variantCollection).snapshots();
  }
  //edit variants
  static Future editVariants(String id, VariantsModel variantsModel)async{
    try{
      await _firestore.collection(variantCollection).doc(id).update(variantsModel.toJson()).then((value) {
        AlertController.show("Variants updated", "Variants update successfully.", TypeAlert.success);
      });

    }catch(e){
      print("addVariants error --------- $e");
    }
  }
  //delete variants
  static Future deleteVariants(String id, )async{
    try{
      await _firestore.collection(variantCollection).doc(id).delete().then((value) {
        AlertController.show("Variants deleted", "Variants delete successfully.", TypeAlert.success);
      });

    }catch(e){
      print("addVariants error --------- $e");
    }
  }
}