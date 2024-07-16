class BlockedschModel {
  BlockedschModel({
    this.id,
    this.appID,
    this.date,
    this.dayOfWeek,
    this.timeOfDay,
    this.isDeleted,
    this.accessTime,
  });
  int? id;
  String? appID;
  String? date;
  String? dayOfWeek;
  String? timeOfDay;
  bool? isDeleted;
  String? accessTime;
  //var strShiftType = 'Select shift type'.obs;
  //TextEditingController chargesController = TextEditingController();
  var selectedDateTime = <String>[];

  BlockedschModel.fromJson(dynamic json) {
    id = json['id'];
    appID = json['appID'];
    date = json['date'];
    dayOfWeek = json['dayOfWeek'];
    timeOfDay = json['timeOfDay'];
    isDeleted = json['isDeleted'];
    accessTime = json['accessTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['appID'] = appID;
    _data['date'] = date;
    _data['dayOfWeek'] = dayOfWeek;
    _data['timeOfDay'] = timeOfDay;
    _data['isDeleted'] = isDeleted;
    _data['accessTime'] = accessTime;
    return _data;
  }
}
