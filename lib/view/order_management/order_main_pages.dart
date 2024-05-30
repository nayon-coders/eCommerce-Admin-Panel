import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_admin/controller/firebase_controlle/firebase_image_controller.dart';
import 'package:new_admin/utility/colors.dart';
import 'package:new_admin/view/order_management/screens/accepted_orders.dart';
import 'package:new_admin/view/order_management/screens/allOrders.dart';
import 'package:new_admin/view/order_management/screens/canceled_orders.dart';
import 'package:new_admin/view/order_management/screens/delivered_orders.dart';
import 'package:new_admin/view/order_management/screens/pending_orders.dart';
import 'package:new_admin/view/order_management/screens/rejected_orders.dart';
import 'package:new_admin/view/product_management/screens/product_list.dart';
import 'package:new_admin/view/product_management/screens/product_variants.dart';
import '../../common_widget/menu_widgets/side_menus.dart';


class OrderManagement extends StatefulWidget {
  final int pages;
  const OrderManagement({super.key, this.pages = 0});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentWidgets = widget.pages!;
  }

  int? _currentWidgets;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Row(
        children: [
          //sider bar
          Container(
            width: 250,
            padding: EdgeInsets.all(20),
            height: size.width,
            color: Colors.white,
            child: ListView(
              children: [
                Text("Manage Orders",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                Divider(height: 1, color: Colors.grey.shade200,),
                SizedBox(height: 10,),
                for(var i =0; i <ListOfProductManagementMenu.List!.length; i++)
                  SidebarMenuItems(
                    name: ListOfProductManagementMenu.List![i]["name"].toString(),
                    bgColor: _currentWidgets == i ? AppColors.sidebarSelectedMenuColor : AppColors.sidebarUnselectedMenuColor,
                    onClick: (){
                      setState(() {
                        _currentWidgets = i;
                      });
                    },
                  )

              ],
            ),
          ),

          Expanded(
            child: Container(
              height: size.width,
              color: Colors.grey.shade200,
              child: ListOfProductManagementMenu.List[_currentWidgets!]["page"] as Widget,
            ),
          ),


          //view
        ],
      ),
    );
  }
}



class ListOfProductManagementMenu{
  static final List = [
    {
      "name" : "All Order",
      "page" : AllOrders()
    } ,
    {
      "name" : "Pending Orders",
      "page" : PendingOrders()
    } ,
    {
      "name" : "Accepted Order",
      "page" : AcceptedOrders()
    } ,

    {
      "name" : "Delivered Order",
      "page" : DeliveredOrders()
    } ,
    {
      "name" : "Cancel Order",
      "page" : CanceledOrders()
    } ,
    {
      "name" : "Rejected Order",
      "page" : RejectedOrders()
    } ,




  ];
}
