import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:new_admin/database/db_connection.dart';
import 'package:new_admin/utility/assets.dart';
import 'package:new_admin/view/dashboards/screens/dashboards.dart';
import 'package:new_admin/view/product_management/screens/add_products.dart';

import '../product_management/product_management.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
                        Container(
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
                                Tab(child: Text('Event Management')),
                                Tab(child: Text('Manually Scripting')),
                                Tab(child: Text('Setting')),
                              ],
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[

                          ProductManagement(),
                          Dashboard(),
                          Icon(Icons.directions_car, size: 350),
                          Icon(Icons.directions_car, size: 350),
                          Icon(Icons.directions_car, size: 350),
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
