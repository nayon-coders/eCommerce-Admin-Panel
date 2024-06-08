
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

var todayDate = DateFormat("dd-MM-yyyy").format(DateTime.now());


//collection name
String categoryCollection = "category";
String productCollection = "products";
String variantCollection = "variants";
String bannerCollection = "banners";
String usersCollection = "users";
String logoCollection = "app_logo";
String appSettingCollection = "settings";
String orderCollection = "orders";


//order status
String orderPending = "Pending";
String orderAccept = "Accept";
String orderCancel = "Cancel";
String orderDelivered = "Delivered";
String orderReady_to_ship = "Ready to ship";
String orderRejected = "Rejected";


Map<String, dynamic> stringToMapConvert(mapString){
  // Define the string representation of the map

  // Remove whitespace and newline characters
  mapString = mapString.replaceAll(RegExp(r'\s'), '');

  // Remove any single quotes around keys and values
  mapString = mapString.replaceAll(RegExp(r"'"), '');

  // Split the string by commas
  List<String> keyValuePairs = mapString.split(',');

  // Initialize an empty map
  Map<String, dynamic> resultMap = {};

  // Iterate over key-value pairs and add them to the map
  for (String pair in keyValuePairs) {
    List<String> parts = pair.split(':');
    String key = parts[0];
    String value = parts[1];

    // Convert value to int if possible
    int? intValue = int.tryParse(value);

    // If the value is a list, remove square brackets and split by comma
    Object listValue = parts[1].contains('[')
        ? parts[1].replaceAll(RegExp(r'[\[\]]'), '').split(',')
        : parts[1];

    // Add key-value pair to the map
    resultMap[key] = intValue ?? listValue;
  }

  // Output the resulting map
  print("resultMap---- ${resultMap}");
  return resultMap;
}


///app snackbar
void appSnackBar({required BuildContext context, required String text}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
    content: Text("$text"),
    duration: Duration(milliseconds: 3000),
  ));
}



Future<void> appAlertDialog({required BuildContext context, required Widget child, required VoidCallback onClick}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                child,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('YES'),
              onPressed: onClick
            ),
          ],
        );
      },
    );
  }