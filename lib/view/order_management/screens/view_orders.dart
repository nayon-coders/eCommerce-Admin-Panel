import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/images/app_network_image.dart';
import 'package:new_admin/controller/order_controller/order_controller.dart';
import 'package:new_admin/controller/user_controller/user_controller.dart';
import 'package:new_admin/model/orders_model/order_model.dart';
import 'package:new_admin/model/user_model/user_model.dart';

import '../../../utility/app_const.dart';

class ViewSingleOrder extends StatefulWidget {
  final OrderModel orderModel;
  final VoidCallback onClick;
  final String id;
  const ViewSingleOrder({super.key, required this.orderModel, required this.onClick, required this.id});

  @override
  State<ViewSingleOrder> createState() => _ViewSingleOrderState();
}

class _ViewSingleOrderState extends State<ViewSingleOrder> {

  double subTotal = 0.00; double total = 0.00;
  getSubTotal(){
    for(var i in widget.orderModel!.items!){
      setState(() {
        subTotal = subTotal + (double.parse(i.qty!.toString()) * double.parse(i.price!.toString()));
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubTotal();
    print("order id ---- ${widget.id}");
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          stream: OrderController.getSingleOrders(widget.id),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            OrderModel orderModel = OrderModel.fromJson(snapshot.data!.data()!);

            print("orderModel statsuy --- ${orderModel.status}");


            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: widget.onClick,
                        icon: Icon(Icons.arrow_back_sharp, color: Colors.black,)
                    ),
                    Text("Order id: #${orderModel.id.toString()}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //order details
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(

                          children: [
                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Date: ${orderModel!.date}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                               Row(
                                 children: [
                                   Container(
                                     width: 150,
                                     height: 30,
                                     decoration: BoxDecoration(
                                         color:  orderModel.status == orderPending
                                             ? Colors.blue.shade200
                                             : orderModel.status == orderCancel
                                             ? Colors.red.shade200
                                             : orderModel.status == orderRejected
                                             ? Colors.red.shade200
                                             : orderModel.status == orderReady_to_ship
                                             ? Colors.deepPurple.shade200
                                             : orderModel.status == orderAccept
                                             ? Colors.greenAccent :
                                         Colors.green.shade200,
                                         borderRadius: BorderRadius.circular(100)
                                     ),
                                     child: Center(
                                       child:  Text("${orderModel!.status}",
                                         style: TextStyle(
                                             fontWeight: FontWeight.w400,
                                             color: Colors.black
                                         ),
                                       ),
                                     ),
                                   ),
                                   SizedBox(width: 20,),
                                   orderModel!.status == orderPending ?   InkWell(
                                     onTap: (){
                                       print(" widget.id, --- ${ widget.id}");
                                       appAlertDialog(context: context, child: Text("Are you sure? You want to cancel this order."), onClick: ()async{
                                         await OrderController.updateOrder(context, widget.id.toString(), orderCancel.toString());
                                       });
                                     },
                                     child: Container(
                                       width: 150,
                                       height: 30,
                                       decoration: BoxDecoration(
                                           color: Colors.red,
                                           borderRadius: BorderRadius.circular(100)
                                       ),
                                       child: Center(
                                         child:  Text("Cancel Order",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w400,
                                               color: Colors.black
                                           ),
                                         ),
                                       ),
                                     ),
                                   )  :Center()
                                 ],
                               )

                              ],
                            ),
                            SizedBox(height: 15,),
                            ListView.builder(
                              shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orderModel!.items!.length,
                                itemBuilder: (_, index){
                                  var product = orderModel!.items![index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: AppNetworkImage(src:  product.product!.images![0],),
                                    title: Text(product.product!.name.toString()),
                                    subtitle: Text("${product.qty} X \$${product.price}"),
                                    trailing: Text("\$${(double.parse(product.qty!.toString()) * double.parse(product.price!.toString()))}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15
                                      ),
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: 10,),
                            Divider(),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Sub Total:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Text("\$${subTotal}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Total:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    fontSize: 17
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Text("\$${subTotal}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 300,
                      padding: EdgeInsets.all(10),
                      //height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Payment Info",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("${orderModel!.paymentMethod!}",
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Delivery Addres",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("${orderModel!.deliveryAddress!}",
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          CustomerInfo(widget: widget),
                          SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Action",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 10,),
                                orderModel.status! == orderPending
                                    ?  DetailsButton(
                                        status: orderAccept,
                                        id: widget.id,
                                        bg: Colors.green,
                                        text: "Accept Order",
                                      )
                                    : widget.orderModel.status! == orderAccept
                                          ?  DetailsButton(
                                        status: orderReady_to_ship,
                                        id: widget.id,
                                        bg: Colors.purple,
                                        text: "Ready to ship",
                                      )
                                    : orderModel.status! == orderReady_to_ship
                                        ?  DetailsButton(
                                      status: orderDelivered,
                                      id: widget.id,
                                      bg: Colors.green,
                                      text: "Delivered",
                                    ) : orderModel.status! == orderCancel
                                    ? Center(
                                  child: Text("Order is ${orderModel.status}"),
                                ):  orderModel.status! == orderRejected
                                    ?  Center(
                                  child: Text("Order is ${orderModel.status}"),
                                ): Center(
                                  child: Text("Order is ${orderModel.status}"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //user and delivery details
                  ],
                )

              ],
            );
          }
        ),
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key, required this.text, required this.bg, required this.status, required this.id,
  });
  final String text;
  final Color bg;
  final String id;
  final String status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        //update orders
        appAlertDialog(context: context, child: Text("Are you sure? You want to $status this order."), onClick: ()async{
          await OrderController.updateOrder(context, id, status);
        });


      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color:  bg,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child:  Text("${"$status"}",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.widget,
  });

  final ViewSingleOrder widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(5)
      ),
      child: StreamBuilder(
        stream: UserController.getSingleUser(widget.orderModel!.user),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          return  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 10,),
              Text("Name: ${snapshot.data!.docs[0].data()["name"]}",),
              SizedBox(height: 7,),
              Text("Email: ${snapshot.data!.docs[0].data()["email"]}",)
            ],
          );
        }
      ),
    );
  }
}
