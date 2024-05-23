import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<void> successAlert({required BuildContext context, required String body}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.close, color: Colors.grey, size: 20,),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Icon(Icons.check_circle, color: Colors.green, size: 30,),
              SizedBox(height: 20,),
              Text(body,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}


Future<void> errorAlert({required BuildContext context, required String body}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.close, color: Colors.grey, size: 20,),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.red, size: 30,),
              SizedBox(height: 20,),
              Text(body,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}


Future<void> appLoading(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: 200,
          height: 100,
          child: Center(child: CircularProgressIndicator(),),
        ),
      );
    },
  );
}