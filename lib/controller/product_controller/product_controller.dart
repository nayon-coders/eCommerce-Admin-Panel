import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:new_admin/model/product/product_model.dart';
import 'package:new_admin/utility/app_const.dart';

class ProductController{

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add product
  static addProducts(ProductModel productModel, BuildContext context){
    try{
      _firestore.collection(productCollection).add(productModel.toJson()).then((value){
        appSnackBar(context: context, text: "Product added successfully.");
      });
    }catch(e){
      print("addProducts error ===== ${e}");
    }
  }
  //get product
  static Stream<QuerySnapshot<Map<String, dynamic>>> getProduct(){
    return _firestore.collection(productCollection).snapshots();
  }
  //edit product
  static editProducts(String id, ProductModel productModel, BuildContext context){
    try{
      _firestore.collection(productCollection).doc(id).update(productModel.toJson()).then((value){
        appSnackBar(context: context, text: "Product edit successfully.");
      });
    }catch(e){
      print("addProducts error ===== ${e}");
    }
  }
  //delete product
  static deleteProduct(String id, BuildContext context)async{
    try{
      await _firestore.collection(productCollection).doc(id).delete();
      appSnackBar(context: context, text: "Product deleted successfully.");
      Navigator.pop(context);
    }catch(e){

    }
  }

}