import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/controller/manage_schedule_controller.dart';
import 'package:expense_tracker/generated/assets.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/model/blocked_schedule_list_model.dart';
import 'package:expense_tracker/widgetHelper/custom_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

class ManageSchedule extends StatelessWidget {
  ManageSchedule({super.key});
  final ManageScheduleController _manageScheduleController =
      Get.put(ManageScheduleController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Manage Schedule',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.textSizeExtraXLarge,
                    color: MyColor.colorNeutral900),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Set up your available schedule to connect to your clients',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.textSizeNormal,
                    color: MyColor.colorNeutral500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Service type",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.textSizeNormal,
                    color: MyColor.colorNeutral500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 1, color: MyColor.colorTextFieldBorder)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Day",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.textSizeNormalReaderView,
                            color: MyColor.colorNeutral500),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Your Service Area",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.textSizeNormal,
                    color: MyColor.colorNeutral500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 1, color: MyColor.colorTextFieldBorder)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Service area",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.textSizeNormalReaderView,
                            color: MyColor.colorNeutral500),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Choose your available schedule",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.textSizeNormal,
                    color: MyColor.colorNeutral500),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _manageScheduleController.pickDay(
                              _manageScheduleController.weeks[index].id);

                          logger.w(
                              "PickDay::${_manageScheduleController.pickDay}");
                        },
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                color:
                                    (_manageScheduleController.pickDay.value ==
                                            index + 1)
                                        ? MyColor.colorPrimary
                                        : MyColor.colorTransparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: MyColor.colorTextFieldBorder)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                '${_manageScheduleController.weeks[index].name}',
                                style: TextStyle(
                                    color: (_manageScheduleController
                                                .pickDay.value ==
                                            index + 1)
                                        ? MyColor.colorWhite
                                        : MyColor.colorNeutral900,
                                    fontSize: FontSize.textSizeLarge,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, i) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                    itemCount: _manageScheduleController.weeks.length),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_manageScheduleController.scheduleList.isNotEmpty) ...[
                _scheduleCard()
              ] else ...[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColor.colorNeutral100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.imagesManagescheduleicon,
                          color: MyColor.colorPrimary,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "NO SCHEDULE YET FOR SUNDAY",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.textSizeNormal,
                              color: MyColor.colorNeutral500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _manageScheduleController.addNewSchedule();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: MyColor.colorPrimary,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add schedule",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.textSizeNormal,
                          color: MyColor.colorPrimary),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ))),
    );
  }

  Widget _scheduleCard() {
    return ListView.separated(
        separatorBuilder: (context, i) {
          return const SizedBox(
            height: 10,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _manageScheduleController.scheduleList.length,
        itemBuilder: (context, i) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(width: 2, color: MyColor.colorTextFieldBorder)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    color: MyColor.colorNeutral100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SUNDAY| SHIFT ${i + 1}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.textSizeNormal,
                              color: MyColor.colorNeutral600),
                        ),
                        Image.asset(
                          Assets.imagesDeleteicon,
                          width: 24,
                          height: 24,
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: MyColor.colorTextFieldBorder,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        Assets.imagesShifttype,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        _manageScheduleController
                                .scheduleList[i].sch?.strShiftType.value ??
                            'Select shift type',
                        style: const TextStyle(
                            fontSize: FontSize.textSizeNormal,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorNeutral900),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          for (var shift
                              in _manageScheduleController.shiftList) {
                            shift.isCheck = false.obs;
                            shift.isDisable = false.obs;
                          }
                          var selectedShift = _manageScheduleController
                              .scheduleList
                              .map((element) => element.sch?.timeOfDay)
                              .toList();
                          print("SSS::$selectedShift");
                          if (selectedShift.isNotEmpty) {
                            for (var i in selectedShift) {
                              var unavailableTime = _manageScheduleController
                                  .shiftList
                                  .where((element) => element.shiftName == i)
                                  .firstOrNull;
                              print("SSSSSSSSSSSS$unavailableTime");
                              if (unavailableTime != null) {
                                unavailableTime.isDisable = true.obs;
                              }
                            }
                          }
                          CustomBottomSheet.show(
                              cc: context,
                              myList: _manageScheduleController.shiftList,
                              schModel:
                                  _manageScheduleController.scheduleList[i]);
                        },
                        child: Image.asset(
                          Assets.imagesDownarrow,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: MyColor.colorTextFieldBorder,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        Assets.imagesTypeyourcharge,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        _manageScheduleController
                                .scheduleList[i].sch?.expServiceFee
                                .toString() ??
                            'Type your charges',
                        style: const TextStyle(
                            fontSize: FontSize.textSizeNormal,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorNeutral900),
                      ),
                    )),
                if (_manageScheduleController
                    .scheduleList[i].blockedschlist!.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: MyColor.colorTextFieldBorder,
                      width: 2,
                    ))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Block schedule',
                            style: TextStyle(
                                fontSize: FontSize.textSizeNormal,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorBlackSemiTransparent),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Wrap(
                              //spacing: 5,
                              direction: Axis.horizontal,
                              children: _manageScheduleController
                                  .scheduleList[i].blockedschlist!
                                  .map((i) {
                                String formatted = '';
                                if (i.date != null) {
                                  final DateFormat formatter =
                                      DateFormat('MMMd');
                                  var selectDateTime = DateFormat(
                                          'yyyy-MM-dd HH:mm:ss')
                                      .parse(i.date!.replaceAll('T', ' '), true)
                                      .toLocal();
                                  formatted = formatter
                                      .format(selectDateTime ?? DateTime.now());
                                }

                                return i.isDeleted == true
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: Chip(
                                          label: Text(
                                            formatted,
                                            style: const TextStyle(
                                              color: MyColor.colorNeutral600,
                                            ),
                                          ),
                                          onDeleted: () async {
                                            print('myDate21${i.date}');
                                            _manageScheduleController
                                                .scheduleList
                                                .refresh();
                                            // await _manageScheduleController
                                            //     .removeScheduleList(schModel,
                                            //         count, strName, i.date ?? '');
                                          },
                                        ),
                                      );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                GestureDetector(
                  onTap: () async {
                    List<DateTime> date = [];

                    date.clear();

                    await _manageScheduleController.getAvailableDate();

                    if (_manageScheduleController.dateList.isEmpty) {
                      return;
                    }
                    if (_manageScheduleController.dateList.isNotEmpty) {
                      for (var i in _manageScheduleController.dateList) {
                        var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
                            .parse(i.replaceAll('T', ' '), true)
                            .toLocal();

                        date.add(
                          DateTime(
                            localDateTime.year,
                            localDateTime.month,
                            localDateTime.day,
                          ),
                        );
                      }
                    }

                    print("Date::${date.length}");

                    final dateTime = await showDatePicker(
                      context: context,
                      firstDate: date.first,
                      initialDate: date.first,
                      lastDate: date.last,
                      selectableDayPredicate: (dateTime) =>
                          date.contains(dateTime),
                    );
                    var dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss')
                        .format(DateTime.parse(dateTime.toString()))
                        .toString();
                    print("DatePick::$dateFormat");

                    var nurseSchList = _manageScheduleController
                        .scheduleList[i].blockedschlist
                        ?.where((e) => e.date == dateFormat)
                        .firstOrNull;
                    // print('nurseList${nurseSchList?.toJson()}');
                    if (nurseSchList == null) {
                      var bModel = BlockedschModel();
                      bModel.id = 0;
                      bModel.appID = _manageScheduleController.myAppId.value;
                      bModel.date = dateFormat;
                      bModel.dayOfWeek = 'Sunday';
                      bModel.timeOfDay = _manageScheduleController
                          .scheduleList[i].sch?.timeOfDay;
                      bModel.isDeleted = false;
                      print('BlockDate::${bModel.toJson()}');
                      _manageScheduleController.scheduleList[i].blockedschlist
                          ?.add(bModel);
                    }

                    _manageScheduleController.scheduleList.refresh();

                    // _signUpCreateScheduleController.addScheduleList(
                    //     schModel, count, strName);

                    // if (_signUpCreateScheduleController
                    //     .oldNurseSchAndBlockedSchVMList.isEmpty) {
                    //   _signUpCreateScheduleController
                    //       .oldNurseSchAndBlockedSchVMList
                    //       .add(schModel);
                    // } else {
                    //   _signUpCreateScheduleController
                    //       .oldNurseSchAndBlockedSchVMList
                    //       .remove(schModel);
                    //   _signUpCreateScheduleController
                    //       .oldNurseSchAndBlockedSchVMList
                    //       .add(schModel);
                    // }
                  },
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      decoration: const BoxDecoration(),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          Assets.imagesBlockSchedule,
                          width: 24,
                          height: 24,
                        ),
                        title: const Text(
                          'Block schedule',
                          style: TextStyle(
                              fontSize: FontSize.textSizeNormal,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorPrimary),
                        ),
                      )),
                ),
              ],
            ),
          );
        });
  }
}
