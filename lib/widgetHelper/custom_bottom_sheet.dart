import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/manage_schedule_controller.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/model/nurse_schedules_week_response_model.dart';
import 'package:expense_tracker/model/service_model.dart';
import 'package:expense_tracker/widgetHelper/custom_text_button_widget.dart';

class CustomBottomSheet {
  static void show({
    required BuildContext cc,
    required List<ServiceModel> myList,
    NurseScheduleWeekResponseModel? schModel,
  }) {
    final ManageScheduleController manageScheduleController =
        Get.put(ManageScheduleController());
    showModalBottomSheet(
      context: cc,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext cc) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(
                        color: MyColor.colorDivider,
                        thickness: 2,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: myList.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        manageScheduleController.shiftList[i].isCheck.value =
                            !manageScheduleController
                                .shiftList[i].isCheck.value;
                        manageScheduleController.selectShiftType(
                            myList[i].id ?? 0, myList);
                      },
                      child: SizedBox(
                        height: 35,
                        child: Obx(
                          () => ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.only(left: 20),
                            trailing: myList[i].isDisable.isTrue
                                ? const Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(Icons.check_box),
                                  )
                                : Checkbox(
                                    activeColor: MyColor.colorTransparent,
                                    checkColor: MyColor.colorPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => const BorderSide(
                                          width: 1.5, color: Colors.red),
                                    ),
                                    value: myList[i].isCheck.value,
                                    onChanged: (value) {
                                      // myList[i].isCheck.value =
                                      //     !myList[i].isCheck.value;
                                      manageScheduleController
                                          .shiftList[i].isCheck.value = value!;
                                      manageScheduleController.selectShiftType(
                                          myList[i].id ?? 0, myList);
                                    }),
                            title: Text(
                              myList[i].shiftName ?? '',
                              style: const TextStyle(
                                color: MyColor.colorNeutral900,
                                fontSize: FontSize.textSizeNormalReaderView,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: CustomTextButtonWidget(
                    backgroundColor: MyColor.colorPrimary,
                    textColor: MyColor.colorWhite,
                    borderSideColor: MyColor.colorTextFieldBorder,
                    btnText: 'Save',
                    onPressed: () {
                      var result = manageScheduleController.shiftList
                          .where((element) => element.isCheck.isTrue)
                          .firstOrNull;
                      schModel?.sch?.strShiftType.value =
                          result?.shiftName ?? 'Select shift type';

                      print("Shift type::${result?.shiftName}");
                      print(
                          "Shift Result:::${schModel?.sch?.strShiftType.value}");
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        );

        // Scaffold(
        //   body: SingleChildScrollView(
        //     physics: const AlwaysScrollableScrollPhysics(),
        //     child: Container(
        //       padding: const EdgeInsets.only(top: 20, bottom: 20),
        //       child: Column(
        //         children: [
        //           ListView.separated(
        //               shrinkWrap: true,
        //               physics: const NeverScrollableScrollPhysics(),
        //               itemBuilder: (cc, index) {
        //                 return SizedBox(
        //                   height: 35,
        //                   child: Text(
        //                     myList[index].shiftName.toString(),
        //                     style: const TextStyle(color: MyColor.colorPrimary),
        //                   ),
        //                 );
        //               },
        //               separatorBuilder: (cc, index) {
        //                 return const SizedBox(
        //                   height: 5,
        //                 );
        //               },
        //               itemCount: myList.length)
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }
}
