import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_admin/model/page_model.dart';
import 'package:new_admin/utility/colors.dart';
import 'package:new_admin/view/product_management/screens/product_list.dart';
import 'package:new_admin/view/product_management/screens/product_variants.dart';

import '../../common_widget/menu_widgets/side_menus.dart';
import 'screens/add_products.dart';
import 'screens/category.dart';


class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _currentWidgets = 0;

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
                Text("Manage Products",
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
              child: ListOfProductManagementMenu.List[_currentWidgets]["page"] as Widget,
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
      "name" : "Product Variant",
      "page" : ProductVariant()
    } ,
    {
      "name" : "All Category",
      "page" : Category()
    } ,

    {
      "name" : "Add New Product",
      "page" : AppProducts()
    } ,
    {
      "name" : "All Products",
      "page" : AllProducts()
    } ,

  ];
}
