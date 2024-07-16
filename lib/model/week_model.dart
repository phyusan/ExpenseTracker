import 'package:get/get.dart';

class WeekModel {
  WeekModel({
    this.id,
    this.name,
    this.description,
    this.isSelect,
    this.isDisable,
  });
  int? id;
  String? name;
  String? description;
  RxBool? isSelect;
  RxBool? isDisable;
}