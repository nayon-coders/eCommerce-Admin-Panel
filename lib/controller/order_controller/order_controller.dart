import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/utility/app_const.dart';


class OrderController{
  
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  
  
  //get all order 
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrder(){
    return _firestore.collection(orderCollection).snapshots();
  }
  //get all order 
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPendingOrder(){
    return _firestore.collection(orderCollection).where("status", isEqualTo: orderPending).snapshots();
  }

  //get all order
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAcceptOrder(){
    return _firestore.collection(orderCollection).where("status", isEqualTo: orderAccept).snapshots();
  }
  //get all order
  static Stream<QuerySnapshot<Map<String, dynamic>>> getDeliveredOrder(){
    return _firestore.collection(orderCollection).where("status", isEqualTo: orderDelivered).snapshots();
  }
  //get all order
  static Stream<QuerySnapshot<Map<String, dynamic>>> getReadyToShipOrder(){
    return _firestore.collection(orderCollection).where("status", isEqualTo: orderReady_to_ship).snapshots();
  }

  //get all order
  static Stream<QuerySnapshot<Map<String, dynamic>>> getRejectedOrder(){
    return _firestore.collection(orderCollection).where("status", isEqualTo: orderRejected).snapshots();
  }

  //get all order
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCancelOrder(){
    return _firestore.collection(orderCollection).where("status", isEqualTo: orderCancel).snapshots();
  }
  
  
  
}