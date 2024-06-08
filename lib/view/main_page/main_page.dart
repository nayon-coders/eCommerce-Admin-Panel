import 'package:flutter/material.dart';
import 'package:new_admin/controller/auth_controller/auth_controller.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:new_admin/view/dashboards/screens/dashboards.dart';
import 'package:new_admin/view/order_management/order_main_pages.dart';
import 'package:new_admin/view/shop_setting/shop_setting.dart';
import 'package:new_admin/view/user_management/user_management.dart';
import '../product_management/product_management.dart';

class MainPage extends StatefulWidget {
  final int page;
  final int secondPageIndex;

  const MainPage({super.key,  this.page = 0, this.secondPageIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //check db connection
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 5,
      initialIndex: widget.page!,
      child: SafeArea(
        child: Container(
          // width: double.infinity,

            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  centerTitle: false,
                  title: Text("Admin Panel",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(100),
                        //   ),
                        //   child: Center(child: Text("+ Add Ne Product"),),
                        // ),
                        InkWell(
                          onTap: (){
                            appAlertDialog(context: context, child: Text("Are you sure? Do you want to logout?"), onClick: (){
                              AuthController.logout(context);
                            });

                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10, right: 40),
                            padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(child: Text("Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                )
                            ),),
                          ),
                        )
                      ],
                    )
                  ],

                ),
                body:Center(
                  child: Container(

                    color: Colors.white,
                    child: NestedScrollView(
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          const SliverAppBar(
                            backgroundColor: Colors.white,
                              title: Text("Welcome, Boss!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            pinned: true,
                            titleSpacing: 0,
                            floating: true,

                            bottom: TabBar(
                              isScrollable: true,
                              tabs: [
                                Tab(child: Text('Dashboard')),
                                Tab(child: Text('Product Management')),
                                Tab(child: Text('Order Management')),
                                Tab(child: Text('Customer Management')),
                                Tab(child: Text('Accounts Setting')),
                              ],
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[

                          Dashboard(),
                          ProductManagement(pages: widget.secondPageIndex,),
                          OrderManagement(),
                          UserManagement(),
                          ShopSetting(),

                        ],
                      ),
                    ),
                  ),
                ))
        ),
      ),
    );

  }
}
