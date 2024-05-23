import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/common_widget/table_widgets/table.dart';
import 'package:new_admin/common_widget/table_widgets/table_row_colloumn.dart';

class AllProducts extends StatelessWidget {
   AllProducts({super.key});
  
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(child:
          AppTable(
            title: "Product List",
              headersChildren: [

                AppTableHeader(width: 30, text: "ID"),
                AppTableHeader(width: 120, text: "Product Name"),
                AppTableHeader(width: 60, text: "Price"),
                AppTableHeader(width: 80, text: "Whole Sell"),
                AppTableHeader(width: 80, text: "Seller Price"),
                AppTableHeader(width: 50, text: "Status"),
                AppTableHeader(width: 80, text: "Date"),
                AppTableHeader(width: 200, text: "Action"),

              ],
              row: Expanded(
                child: ListView.builder(itemCount: 20, itemBuilder: (_, index){
                  return  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : Colors.grey.shade200
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTableRow(width: 30, text: "${index+1}",),
                        AppTableRow(width: 120, text: "Alos"),
                        AppTableRow(width: 60, text: "\$50.90"),
                        AppTableRow(width: 80, text: "\$34.00"),
                        AppTableRow(width: 80, text: "\$45.09"),
                        AppTableRow(width: 50, text: "active"),
                        AppTableRow(width: 80, text: "22-05-2023"),
                        Row(
                          children: [
                            AppTableRow(width: 80, text: "Edit", isClick: true, onTap: (){}, ),
                            SizedBox(width: 10,),
                            AppTableRow(width: 80, text: "Delete", isClick: true, onTap: (){}, ),
                          ],
                        ),

                      ],
                    ),
                  );
                },),
              ),
              onSearch: (){},
              searchController: searchController
          )
          )
        ],
      )
    ); 
  }
}
