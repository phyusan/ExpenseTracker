import 'package:expense_tracker/model/blocked_schedule_list_model.dart';
import 'package:expense_tracker/model/schedule_model.dart';

class NurseScheduleWeekResponseModel {
  NurseScheduleWeekResponseModel({
    this.sch,
    this.blockedschlist,
  });
  ScheduleModel? sch;
  List<BlockedschModel>? blockedschlist;

  NurseScheduleWeekResponseModel.fromJson(dynamic json) {
    sch = ScheduleModel.fromJson(json['sch']);
    blockedschlist = List.from(json['blockedschlist'])
        .map((e) => BlockedschModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sch'] = sch?.toJson();
    _data['blockedschlist'] = blockedschlist?.map((e) => e.toJson()).toList();
    return _data;
  }
}


// class AutoGenerate {
//   AutoGenerate({
//     required this.sch,
//     required this.blockedschlist,
//   });
//   late final Sch sch;
//   late final List<Blockedschlist> blockedschlist;
  
//   AutoGenerate.fromJson(Map<String, dynamic> json){
//     sch = Sch.fromJson(json['sch']);
//     blockedschlist = List.from(json['blockedschlist']).map((e)=>Blockedschlist.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['sch'] = sch.toJson();
//     _data['blockedschlist'] = blockedschlist.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

// class Sch {
//   Sch({
//     required this.id,
//     required this.appID,
//     required this.serviceTypeID,
//     required this.serviceType,
//     required this.serviceArea,
//     required this.expServiceFee,
//     required this.extraFee,
//     required this.dayOfWeek,
//     required this.timeOfDay,
//     required this.isDeleted,
//     required this.accesstime,
//   });
//   late final int id;
//   late final String appID;
//   late final String serviceTypeID;
//   late final String serviceType;
//   late final String serviceArea;
//   late final int expServiceFee;
//   late final int extraFee;
//   late final String dayOfWeek;
//   late final String timeOfDay;
//   late final bool isDeleted;
//   late final String accesstime;
  
//   Sch.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     appID = json['appID'];
//     serviceTypeID = json['serviceTypeID'];
//     serviceType = json['serviceType'];
//     serviceArea = json['serviceArea'];
//     expServiceFee = json['expServiceFee'];
//     extraFee = json['extraFee'];
//     dayOfWeek = json['dayOfWeek'];
//     timeOfDay = json['timeOfDay'];
//     isDeleted = json['isDeleted'];
//     accesstime = json['accesstime'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['appID'] = appID;
//     _data['serviceTypeID'] = serviceTypeID;
//     _data['serviceType'] = serviceType;
//     _data['serviceArea'] = serviceArea;
//     _data['expServiceFee'] = expServiceFee;
//     _data['extraFee'] = extraFee;
//     _data['dayOfWeek'] = dayOfWeek;
//     _data['timeOfDay'] = timeOfDay;
//     _data['isDeleted'] = isDeleted;
//     _data['accesstime'] = accesstime;
//     return _data;
//   }
// }

// class Blockedschlist {
//   Blockedschlist({
//     required this.id,
//     required this.appID,
//     required this.date,
//     required this.dayOfWeek,
//     required this.timeOfDay,
//     required this.isDeleted,
//     required this.accessTime,
//   });
//   late final int id;
//   late final String appID;
//   late final String date;
//   late final String dayOfWeek;
//   late final String timeOfDay;
//   late final bool isDeleted;
//   late final String accessTime;
  
//   Blockedschlist.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     appID = json['appID'];
//     date = json['date'];
//     dayOfWeek = json['dayOfWeek'];
//     timeOfDay = json['timeOfDay'];
//     isDeleted = json['isDeleted'];
//     accessTime = json['accessTime'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['appID'] = appID;
//     _data['date'] = date;
//     _data['dayOfWeek'] = dayOfWeek;
//     _data['timeOfDay'] = timeOfDay;
//     _data['isDeleted'] = isDeleted;
//     _data['accessTime'] = accessTime;
//     return _data;
//   }
// }
