import 'package:flutter/material.dart';


class ProductJson{

  //add category json fields
  static final category = {
    "id" : "1",
    "category_name" : "name",
    "category_image" : "da",
    "create_at" : "adsfsd"
  };


  //add category json fields
  static final subCategory = {
    "id" : "1",
    "category" : "name",
    "sub_category" : "da",
    "create_at" : "adsfsd"
  };


  //variant
  static final variantsJson = {
    "id" : "1",
    "name": "name",
    "variants" : [],
    "create_at" : "asdfsd"
  };


  //products controllers
  static final productsJson = {
    "name" : "Product Name",
    "short_description" : "",
    "long_description" :"",
    "products_tags" : [],
    "images" : [],
    "regular_price" : "",
    "whole_price" : "",
    "selling_price" : "",
    "discount_price" : "",
    "category's" : {
      "id" : "1",
      "category_name" : "name",
      "category_image" : "da",
      "create_at" : "adsfsd"
    },
    "variants" : [
      {
        "name" : "xl",
        "prince" : "princ"
      },
      {
        "name" : "xl",
        "prince" : "princ"
      }
    ],
    "status" : "10",
    "is_stock" : "",
    "product_type" : "KG",
    "create_at" : ""

  };


  static final productTypeList = [
    "KG (Kilogram)",
    "G (Gram)",
    "MG (Milligram)",
    "L (Liter)",
    "ML (Milliliter)",
    "CM (Centimeter)",
    "MM (Millimeter)",
    "M (Meter)",
    "Liquid",
    "Solid",
    "Gas",
    "Powder",
    "Gel",
    "Paste",
    "Crystals",
    "Granules",
    "Pellets",
    "Packet",
    "Bottle",
    "Jar",
    "Can",
    "Box",
    "Bag",
    "Tube",
    "Sachet",
    "Carton",
    "Barrel",
    "Drum",
    "Container",
    "Blister Pack",
    "Strip Pack",
    "Pouch"
  ];




}