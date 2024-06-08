import 'package:flutter/material.dart';
import 'package:new_admin/view/order_management/screens/view_orders.dart';

import '../../../common_widget/table_widgets/table.dart';
import '../../../common_widget/table_widgets/table_row_colloumn.dart';
import '../../../controller/order_controller/order_controller.dart';
import '../../../model/orders_model/order_model.dart';
import '../../../utility/app_const.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  final searchController = TextEditingController();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  bool _isEdit = false;
  bool _isView = false;

  OrderModel? _selectedOrderModel;
  var docId;
  var  _searchValue;

  bool _isDetails = false;

  int selectedPageNumber = 1;
  List<Widget> pages = [Container()];
  int currentPages = 0;

  int _startIndex = 0;
  int _endIndex = 2;
  List totalItems = [];



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _isDetails ? ViewSingleOrder(
      onClick: (){
        setState(() {
          _isDetails = false;
        });
      },
      orderModel: _selectedOrderModel!, id: docId,
    ) : Scaffold(
      key: _key,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text("Pending Details",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height-100,
        child:
        AppTable(
          isSearchShow: false,
          title: "Cancel Order's",
          headersChildren: const [
            AppTableHeader(width: 60, text: "Order ID"),
            AppTableHeader(width: 200, text: "Payment Method"),
            AppTableHeader(width: 300, text: "Delivery Address"),
            AppTableHeader(width: 120, text: "Status"),
            AppTableHeader(width: 140, text: "Date"),
            AppTableHeader(width: 50, text: "Action"),
          ],
          row:Expanded(
            child: StreamBuilder(
                stream: OrderController.getPendingOrder(),
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }

                  return SizedBox(

                    height: MediaQuery.of(context).size.height-200,
                    width: MediaQuery.of(context).size.width-200,
                    child: snapshot.data!.docs.isNotEmpty ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        totalItems.add(index);
                        var data = OrderModel.fromJson(snapshot.data!.docs[index]!.data());
                        return Container(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.white : Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTableRow(width: 60, text: "${data.id}"),
                              AppTableRow(width: 200, text: "${data.paymentMethod}"),
                              AppTableRow(width: 300, text: "${data.deliveryAddress}"),
                              AppTableRow(
                                width: 120,
                                clickChild: Container(
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: data.status == orderPending
                                        ? Colors.blue.shade200
                                        : data.status == orderCancel
                                        ? Colors.red.shade200
                                        : data.status == orderRejected
                                        ? Colors.red.shade200
                                        : data.status == orderReady_to_ship
                                        ? Colors.deepPurple.shade200
                                        : data.status == orderAccept
                                        ? Colors.greenAccent
                                        : Colors.green.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text("${data.status}"),
                                  ),
                                ),
                                isClick: true,
                                onTap: () {},
                                text: '',
                              ),
                              AppTableRow(width: 140, text: "${data.date}"),
                              Row(
                                children: [
                                  AppTableRow(
                                    width: 80,
                                    clickChild: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedOrderModel = data;
                                          docId = snapshot.data!.docs[index].id.toString();
                                          _isDetails = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.green,
                                      ),
                                    ),
                                    isClick: true,
                                    onTap: () {},
                                    text: '',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ) : Center(child: Text("Empty"),),
                  );

                }
            ),
          ) ,

          onChanged: (v){
            setState(() {
              _searchValue = v;
              print(" _searchValue === ${_searchValue}");
            });
          },
          searchController: searchController, onSearch: () {  },
        ),
      ),



    );
  }
}
