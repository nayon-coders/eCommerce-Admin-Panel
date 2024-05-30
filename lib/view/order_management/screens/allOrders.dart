import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/common_widget/table_widgets/table.dart';
import 'package:new_admin/common_widget/table_widgets/table_row_colloumn.dart';
import 'package:new_admin/controller/product_controller/product_controller.dart';
import 'package:new_admin/model/product/product_model.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:new_admin/view/product_management/product_management.dart';
import 'package:new_admin/view/product_management/screens/edit_product.dart';

import '../../main_page/main_page.dart';

class AllOrders extends StatefulWidget {
  AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  final searchController = TextEditingController();

  bool _isEdit = false;
  bool _isView = false;

  ProductModel? _selectedProductModel;
  var docId;
  var  _searchValue;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _isEdit || _isView ? EditProduct(
      onClose: (){
        setState(() {
          _isEdit = false;
          _isView = false;
        });
      },
      productModel: _selectedProductModel, id: docId,
      isView: _isView,
    ) : Container(
      padding: EdgeInsets.all(20),
      child: Expanded(child:
      AppTable(

        title: "All Order's",
        headersChildren: [

          AppTableHeader(width: 30, text: "ID"),
          AppTableHeader(width: 200, text: "Product Name"),
          AppTableHeader(width: 60, text: "Amount"),
          AppTableHeader(width: 100, text: "Order Method"),
          AppTableHeader(width: 50, text: "Status"),
          AppTableHeader(width: 80, text: "Date"),
          AppTableHeader(width: 50, text: "Action"),

        ],
        row: Expanded(
          child: StreamBuilder(
              stream: ProductController.getProduct(),
              builder: (context, snapshot) {


                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                List<ProductModel> searchProduct = [];
                for(var i in snapshot.data!.docs){
                  if(_searchValue.toString().toLowerCase().contains(ProductModel.fromJson(i.data()).name!.toLowerCase())){
                    searchProduct.add(ProductModel.fromJson(i!.data()));
                  }
                }
                return searchProduct.isNotEmpty ?
                ListView.builder(
                  itemCount: searchProduct.length,
                  itemBuilder: (_, index){
                    var data = searchProduct[index];
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
                          AppTableRow(width: 30, text: "${data.id}",),
                          AppTableRow(width: 200, text: "${data.name}"),

                          AppTableRow(width: 60, text: "\$${data.sellingPrice}"),
                          AppTableRow(width: 100, text: "COD"),
                          AppTableRow(width: 50, text: "${data.status}"),
                          AppTableRow(width: 80, text: "${data.createAt}"),
                          Row(
                            children: [

                              AppTableRow(width: 40, clickChild: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _isView = true;
                                    _selectedProductModel = data;
                                    docId = snapshot.data!.docs[index]!.id.toString();
                                  });

                                },
                                icon: Icon(Icons.remove_red_eye, color: Colors.green,),
                              ), isClick: true, onTap: (){}, text: '', ),
                              SizedBox(width: 10,),

                            ],
                          ),

                        ],
                      ),
                    );
                  },)
                    : snapshot.data!.docs.isNotEmpty ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index){
                    var data = ProductModel.fromJson(snapshot.data!.docs[index]!.data());
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
                          AppTableRow(width: 30, text: "${data.id}",),
                          AppTableRow(width: 200, text: "${data.name}"),

                          AppTableRow(width: 80, text: "\$${data.sellingPrice}"),
                          AppTableRow(width: 100, text: "COD"),
                          AppTableRow(width: 50, text: "${data.status}"),
                          AppTableRow(width: 80, text: "${data.createAt}"),
                          Row(
                            children: [

                              AppTableRow(width: 40, clickChild: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _isView = true;
                                    _selectedProductModel = data;
                                    docId = snapshot.data!.docs[index]!.id.toString();
                                  });

                                },
                                icon: Icon(Icons.remove_red_eye, color: Colors.green,),
                              ), isClick: true, onTap: (){}, text: '', ),

                            ],
                          ),

                        ],
                      ),
                    );
                  },) : Center(child: Text("Empty"),);
              }
          ),
        ),
        onChanged: (v){
          setState(() {
            _searchValue = v;
          });
        },
        searchController: searchController, onSearch: () {  },
      )
      ),
    );
  }
}
