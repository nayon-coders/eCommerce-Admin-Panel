import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/controller/order_controller/order_controller.dart';
import 'package:new_admin/model/orders_model/order_model.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalOrderInDashbaord extends StatefulWidget {
   TotalOrderInDashbaord({super.key});

  @override
  State<TotalOrderInDashbaord> createState() => _TotalOrderInDashbaordState();
}

class _TotalOrderInDashbaordState extends State<TotalOrderInDashbaord> {
  List orderList = [
    orderPending,
    orderAccept,
    orderReady_to_ship,
    orderDelivered,
    orderCancel,
    orderRejected,
  ];

  List<Color> bgColor = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.redAccent.shade100,
  ];


  // List<_SalesData> data = [
  //   _SalesData('Jan', 35),
  //   _SalesData('Feb', 28),
  //   _SalesData('Mar', 34),
  //   _SalesData('Apr', 32),
  //   _SalesData('May', 40)
  // ];

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: OrderController.getAllOrder(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 160
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    child: Container(color: Colors.white,), baseColor: Colors.grey.shade100, highlightColor: Colors.white);
              },
            );
          }

          double totalPending =0;
          double totalAccept =0;
          double totalRedyToShip =0;
          double totalRejected =0;
          double totalCancel =0;
          double totalDelivered =0;

          double totalIncome =0;
          double totalPendingIncome =0;
          double totalIncomingIncome =0;
          double totalCancelIncome =0;


          for(var i in snapshot.data!.docs){
            var data = OrderModel.fromJson(i.data());
            if(data.status == orderPending){
              totalPending = totalPending + 1;
              for(var j in data!.items!){
                totalPendingIncome = totalPendingIncome + (double.parse("${j.price}") * double.parse("${j.qty}"));
              }

            }
            if(data.status == orderAccept){
              totalAccept = totalAccept + 1;
              for(var j in data!.items!){
                totalPendingIncome = totalPendingIncome + (double.parse("${j.price}") * double.parse("${j.qty}"));
              }
            }
            if(data.status == orderReady_to_ship){
              totalRedyToShip = totalRedyToShip + 1;
              for(var j in data!.items!){
                totalIncomingIncome = totalPendingIncome + (double.parse("${j.price}") * double.parse("${j.qty}"));
              }
            }
            if(data.status == orderRejected){
              totalRejected = totalRejected + 1;
              for(var j in data!.items!){
                totalCancelIncome = totalPendingIncome + (double.parse("${j.price}") * double.parse("${j.qty}"));
              }
            }
            if(data.status == orderCancel){
              totalCancel = totalCancel + 1;
              for(var j in data!.items!){
                totalCancelIncome = totalPendingIncome + (double.parse("${j.price}") * double.parse("${j.qty}"));
              }
            }
            if(data.status == orderDelivered){
              totalDelivered = totalDelivered + 1;
              for(var j in data!.items!){
                totalIncome = totalPendingIncome + (double.parse("${j.price}") * double.parse("${j.qty}"));
              }
            }


          }

          return  Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
                                SizedBox(height: 10,),
                                TitleText(text: "$totalPending"),
                                SizedBox(height: 5,),
                                Text("Pending Orders")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
                                SizedBox(height: 10,),
                                TitleText(text: "$totalAccept"),
                                SizedBox(height: 5,),
                                Text("Accepted Orders")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
                                SizedBox(height: 10,),
                                TitleText(text: "$totalRedyToShip"),
                                SizedBox(height: 5,),
                                const Text("Ready to ship")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
                                SizedBox(height: 10,),
                                TitleText(text: "$totalDelivered"),
                                SizedBox(height: 5,),
                                Text("Deliverd Orders")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
                                SizedBox(height: 10,),
                                TitleText(text: "$totalCancel"),
                                SizedBox(height: 5,),
                                Text("Canceled Orders")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
                                SizedBox(height: 10,),
                                TitleText(text: "$totalRejected"),
                                SizedBox(height: 5,),
                                Text("Rejected Orders")
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Container(
                width: 300,
                height: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Net Icome",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text("\$${totalIncome}",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600,color: Colors.white
                      ),
                    ),

                    SizedBox(height: 5,),
                    Divider(),
                    SizedBox(height: 5,),
                    TotalIncomeWIdgets(
                        totalIncomingIncome: totalIncomingIncome,
                        icon: Icons.incomplete_circle_rounded,
                        text: "Upcoming Payment",
                    ),
                    TotalIncomeWIdgets(
                      totalIncomingIncome: totalPendingIncome,
                      icon: Icons.pending,
                      text: "Pending Payment",
                    ),
                    TotalIncomeWIdgets(
                      totalIncomingIncome: totalCancelIncome,
                      icon: Icons.cancel_presentation_rounded,
                      text: "Cancel Payment",
                    ),

                  ],
                ),
              )
            ],
          );

          // return GridView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 6,
          //     crossAxisSpacing: 10.0,
          //     mainAxisSpacing: 10.0,
          //     mainAxisExtent: 160
          //   ),
          //   itemCount: orderList.length,
          //   itemBuilder: (context, index) {
          //     return
          //       Expanded(
          //         child: Container(
          //           padding: EdgeInsets.all(20),
          //           decoration: BoxDecoration(
          //             color: bgColor[index],
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Column(
          //             children: [
          //               Icon(Icons.shopping_basket_outlined, color: Colors.black, size: 40,),
          //               SizedBox(height: 10,),
          //               TitleText(text: "11119"),
          //               SizedBox(height: 5,),
          //               Text("Pending Orders")
          //             ],
          //           ),
          //         ),
          //       );
          //   },
          // );
        }
      )
    );
  }
}

class TotalIncomeWIdgets extends StatelessWidget {
  const TotalIncomeWIdgets({
    super.key,
    required this.totalIncomingIncome, required this.text, required this.icon,
  });

  final double totalIncomingIncome;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white, size: 20,),
      title: Text("$text",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 13
        ),
      ),
      trailing: Text("\$$totalIncomingIncome",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          fontSize: 15
        ),
      ),
    );
  }
}


class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}