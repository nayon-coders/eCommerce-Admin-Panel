// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  final String? id;
  final String? category;
  final String? subCategory;
  final String? createAt;

  SubCategoryModel({
    this.id,
    this.category,
    this.subCategory,
    this.createAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    id: json["id"],
    category: json["category"],
    subCategory: json["sub_category"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "sub_category": subCategory,
    "create_at": createAt,
  };
}
