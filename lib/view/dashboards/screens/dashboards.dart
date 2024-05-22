import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:new_admin/utility/assets.dart';
import 'package:new_admin/view/product_management/screens/add_products.dart';

import '../../../utility/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(

      decoration: BoxDecoration(
        color: Colors.grey.shade200
      ),

      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),


          ],
        ),
      ),


    );

  }

}
