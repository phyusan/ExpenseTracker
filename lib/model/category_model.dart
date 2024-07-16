import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.containerColor,
    this.iconColor,
    this.isSelect,
    this.isDisable,
  });
  int? id;
  String? name;
  String? description;
  Color? containerColor;
  Color? iconColor;
  RxBool? isSelect;
  RxBool? isDisable;
}

