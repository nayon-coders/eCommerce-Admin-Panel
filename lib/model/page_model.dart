// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<PageModel> pageModelFromJson(String str) => List<PageModel>.from(json.decode(str).map((x) => PageModel.fromJson(x)));

String pageModelToJson(List<PageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PageModel {
  final String? name;
  final Widget? page;

  PageModel({
    this.name,
    this.page,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
    name: json["name"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "page": page,
  };
}
