import 'package:flutter/material.dart';


class AppProducts extends StatefulWidget {
  const AppProducts({super.key});

  @override
  State<AppProducts> createState() => _AppProductsState();
}

class _AppProductsState extends State<AppProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Add new product"),
      ),
    );
  }
}
