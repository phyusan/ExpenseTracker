import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleModel {
  ScheduleModel({
    this.id,
    this.appID,
    this.serviceTypeID,
    this.serviceType,
    this.serviceArea,
    this.expServiceFee,
    this.extraFee,
    this.dayOfWeek,
    this.timeOfDay,
    this.isDeleted,
    this.accesstime,
  });
  int? id;
  String? appID;
  String? serviceTypeID;
  String? serviceType;
  String? serviceArea;
  double? expServiceFee;
  double? extraFee;
  String? dayOfWeek;
  String? timeOfDay;
  bool? isDeleted;
  String? accesstime;
  var intIndex = 0;
  var strShiftType = 'Select shift type'.obs;
  TextEditingController chargesController = TextEditingController();

  ScheduleModel.fromJson(dynamic json) {
    id = json['id'];
    appID = json['appID'];
    serviceTypeID = json['serviceTypeID'];
    serviceType = json['serviceType'];
    serviceArea = json['serviceArea'];
    expServiceFee = (json['expServiceFee'] == null)
        ? 0.0
        : json['expServiceFee'].toDouble();
    extraFee = (json['extraFee'] == null) ? 0.0 : json['extraFee'].toDouble();
    dayOfWeek = json['dayOfWeek'];
    timeOfDay = json['timeOfDay'];
    isDeleted = json['isDeleted'];
    accesstime = json['accesstime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['appID'] = appID;
    _data['serviceTypeID'] = serviceTypeID;
    _data['serviceType'] = serviceType;
    _data['serviceArea'] = serviceArea;
    _data['expServiceFee'] = expServiceFee;
    _data['extraFee'] = extraFee;
    _data['dayOfWeek'] = dayOfWeek;
    _data['timeOfDay'] = timeOfDay;
    _data['isDeleted'] = isDeleted;
    _data['accesstime'] = accesstime;
    return _data;
  }
}
