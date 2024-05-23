// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String? id;
  final String? categoryName;
  final String? categoryImage;
  final String? createAt;

  CategoryModel({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.createAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_image": categoryImage,
    "create_at": createAt,
  };
}
