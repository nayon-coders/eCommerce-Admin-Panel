// To parse this JSON data, do
//
//     final variantsModel = variantsModelFromJson(jsonString);

import 'dart:convert';

VariantsModel variantsModelFromJson(String str) => VariantsModel.fromJson(json.decode(str));

String variantsModelToJson(VariantsModel data) => json.encode(data.toJson());

class VariantsModel {
  final String? id;
  final String? name;
  final List<dynamic>? variants;
  final String? createAt;

  VariantsModel({
    this.id,
    this.name,
    this.variants,
    this.createAt,
  });

  factory VariantsModel.fromJson(Map<String, dynamic> json) => VariantsModel(
    id: json["id"],
    name: json["name"],
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "create_at": createAt,
  };
}
