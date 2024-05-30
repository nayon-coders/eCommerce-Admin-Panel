import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/common_widget/table_widgets/table.dart';
import 'package:new_admin/common_widget/table_widgets/table_row_colloumn.dart';
import 'package:new_admin/controller/product_controller/product_controller.dart';
import 'package:new_admin/controller/user_controller/user_controller.dart';
import 'package:new_admin/model/product/product_model.dart';
import 'package:new_admin/model/user_model/user_model.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:new_admin/view/product_management/product_management.dart';
import 'package:new_admin/view/product_management/screens/edit_product.dart';
import 'package:new_admin/view/user_management/widgets/view_user_info.dart';

import '../../main_page/main_page.dart';

class ActiveUsers extends StatefulWidget {
  ActiveUsers({super.key});

  @override
  State<ActiveUsers> createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  final searchController = TextEditingController();



  UserModel? _selectedProductModel;
  var docId;
  var  _searchValue;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: AppTable(
        title: "Active Customer List",
        headersChildren: [

          AppTableHeader(width: 50, text: "ID"),
          AppTableHeader(width: 200, text: "Cusomer Name"),
          AppTableHeader(width: 300, text: "Customer Email"),
          AppTableHeader(width: 100, text: "Status"),
          AppTableHeader(width: 100, text: "Date"),
          AppTableHeader(width: 100, text: "Action"),

        ],
        row: Expanded(
          child: StreamBuilder(
              stream: UserController.getUserList(),
              builder: (context, snapshot) {
          
          
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                List<UserModel> searchUsers = [];
                for(var i in snapshot.data!.docs){
                  if(_searchValue.toString().toLowerCase().contains(UserModel.fromJson(i.data()).name!.toLowerCase())){
                    searchUsers.add(UserModel.fromJson(i!.data()));
                  }
                }
                return searchUsers.isNotEmpty ?
                ListView.builder(
                  itemCount: searchUsers.length,
                  itemBuilder: (_, index){
                    var data = searchUsers[index];
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
                          AppTableRow(width: 60, text: "${data.id}",),
                          AppTableRow(width: 200, text: "${data.name}"),
                          AppTableRow(width: 300, text: "${data.email}"),
                          AppTableRow(width: 100, text: "${data.status}"),
                          AppTableRow(width: 100, text: "${data.createAt}"),
                          AppTableRow(width: 100, clickChild: IconButton(
                            onPressed: (){
                              setState(() {
                                _selectedProductModel = data;
                                docId = snapshot.data!.docs[index]!.id.toString();
                              });
          
                            },
                            icon: Icon(Icons.remove_red_eye, color: Colors.green,),
                          ), isClick: true, onTap: (){}, text: '', ),
          
          
                        ],
                      ),
                    );
                  },)
                    : snapshot.data!.docs.isNotEmpty ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index){
                    var data = UserModel.fromJson(snapshot.data!.docs[index]!.data());
                    return  data.status == "Active" ? Container(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: index.isEven ? Colors.white : Colors.grey.shade200
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTableRow(width: 60, text: "${data.id}",),
                          AppTableRow(width: 200, text: "${data.name}"),
                          AppTableRow(width: 300, text: "${data.email}"),
                          AppTableRow(width: 100, text: "${data.status}"),
                          AppTableRow(width: 100, text: "${data.createAt}"),
                          AppTableRow(width: 100, clickChild: IconButton(
                            onPressed: (){
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return UserInfo(userModel: data, docId: snapshot.data!.docs[index]!.id.toLowerCase(),);
                                }
                              );
          
                            },
                            icon: Icon(Icons.remove_red_eye, color: Colors.green,),
                          ), isClick: true, onTap: (){}, text: '', ),
          
                        ],
                      ),
                    ) : Center();
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
      ),
    );
  }
}
