import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/apiService/base_api_controller.dart';
import 'package:expense_tracker/helper/sharepreferences_helper.dart';
import 'package:expense_tracker/helper/show_date_time_helper.dart';
import 'package:expense_tracker/model/nurse_schedules_week_response_model.dart';
import 'package:expense_tracker/model/schedule_model.dart';
import 'package:expense_tracker/model/service_model.dart';
import 'package:expense_tracker/model/week_model.dart';

class ManageScheduleController extends GetxController {
  final _apiController = Get.put(BaseApiController());
  final SharePreferencesHelper _sharePreferencesHelper =
      SharePreferencesHelper();
  RxList<WeekModel> weeks = <WeekModel>[].obs;
  RxList<ServiceModel> shiftList = <ServiceModel>[].obs;
  RxList dateList = [].obs;
  RxList<DateTime> date = <DateTime>[].obs;
  RxList<NurseScheduleWeekResponseModel> scheduleList =
      <NurseScheduleWeekResponseModel>[].obs;

  var pickDay = 1.obs;
  RxString myAppId = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();

    weeks.addAll([
      WeekModel(
        id: 1,
        name: "S",
        description: 'Sunday',
        isSelect: false.obs,
      ),
      WeekModel(
        id: 2,
        name: "M",
        description: 'Monday',
        isSelect: false.obs,
      ),
      WeekModel(
        id: 3,
        name: "T",
        description: 'Tuesday',
        isSelect: false.obs,
      ),
      WeekModel(
        id: 4,
        name: "W",
        description: 'Wednesday',
        isSelect: false.obs,
      ),
      WeekModel(
        id: 5,
        name: "T",
        description: 'Thursday',
        isSelect: false.obs,
      ),
      WeekModel(id: 6, name: "F", description: 'Friday', isSelect: false.obs),
      WeekModel(
        id: 7,
        name: "S",
        description: 'Saturday',
        isSelect: false.obs,
      ),
    ]);
    getShiftType();
    getNursebyWeekSchedule();
  }

  init() async {
    await _sharePreferencesHelper.initSharePref();
    myAppId.value = _sharePreferencesHelper.getUserAppId();
  }

  getShiftType() async {
    Response response = await _apiController.getShiftType();
    if (response.isOk) {
      for (var i in response.body) {
        shiftList.add(ServiceModel.fromJson(i));
      }

      print("Length::${shiftList.length}");
    }
  }

  getNursebyWeekSchedule() async {
    scheduleList.clear();
    Response response = await _apiController.getNurseScheListByWeek(
        'ad1451019a7142f3a8dc44d7fb8db789', 'Sunday');
    print("Code::${response.statusCode}");
    if (response.isOk) {
      print("ResponseBody:${response.body}");
      for (var i in response.body) {
        var model = NurseScheduleWeekResponseModel.fromJson(i);
        model.sch?.strShiftType.value = (i['sch']['timeOfDay'] == null)
            ? 'Select Shift time'
            : i['sch']['timeOfDay'];
        scheduleList.add(model);
        print('Schedule::${model.toJson()}');
      }
      print("ScheduleList::${scheduleList[0].sch?.timeOfDay}");
    }
  }

  addNewSchedule() {
    var model = NurseScheduleWeekResponseModel();
    model.sch = ScheduleModel(id: 0);
    model.blockedschlist = [];
    scheduleList.add(model);
    // selectNurseSchAndBlockedSchList.add(model);
  }

  selectShiftType(int id, List<ServiceModel> list) {
    for (var i in list) {
      if (i.id != id) {
        i.isCheck.value = false;
      }
    }
  }

  getAvailableDate() async {
    Response response = await _apiController.getDateTimeListByDay("Sunday");
    if (response.isOk) {
      for (var i in response.body) {
        dateList.add(i);
      }
      print("Response body::${response.body}");
      print("ResponseLength::${dateList.length}");
    }
  }
}
