import 'package:get/get.dart';

class ServiceModel {
  ServiceModel({
    this.id,
    this.name,
    this.serviceType,
    this.shiftName,
    this.description,
    this.isDeleted,
    this.accesstime,
  });
  int? id;
  String? name;
  String? serviceType;
  String? shiftName;
  String? description;
  bool? isDeleted;
  String? accesstime;
  var isCheck = false.obs;
  var isDisable = false.obs;

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceType = json['serviceType'];
    shiftName = json['shiftName'];
    description = json['description'];
    isDeleted = json['isDeleted'];
    accesstime = json['accesstime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['serviceType'] = serviceType;
    _data['shiftName'] = shiftName;
    _data['description'] = description;
    _data['isDeleted'] = isDeleted;
    _data['accesstime'] = accesstime;
    return _data;
  }
}
