import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/helper/app_constant.dart';

class ActiveAppointmentDetail extends StatelessWidget {
  const ActiveAppointmentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool checkBoxValue = false.obs;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              color: MyColor.colorTeal600,
              child: const Center(
                  child: Text('ACTIVE APPOINTMENT',
                      style: TextStyle(
                        color: MyColor.colorTextWhite,
                        fontSize: FontSize.textSizeNormal,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("FROM"),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColor.colorBlackSemiTransparent,
                          ),
                        ),
                        subtitle: const Text('+9596543210'),
                        title: const Text('Khin Maung Zaw',
                            style: TextStyle(
                                color: MyColor.colorTextBlack500,
                                fontSize: FontSize.textSizeNormal)),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1,
                                  color: MyColor.colorTextFieldBorder)),
                          child: const Center(
                            child: Icon(
                              Icons.phone_in_talk_outlined,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'REQUESTED DATE',
                        style: TextStyle(
                            color: MyColor.colorNeutral500,
                            fontSize: FontSize.textSizeNormal),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '23 Apr 2024',
                          style: TextStyle(
                              color: Color(0xffFCA5A5),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xffFCA5A5)),
                        ),
                        Obx(
                          () => Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: 0),
                            activeColor: MyColor.colorTransparent,
                            checkColor: MyColor.colorPrimary,
                            value: checkBoxValue.value,
                            onChanged: (value) {
                              checkBoxValue.value = value!;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.5, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '24 Apr 2024',
                          style: TextStyle(
                            color: Color(0xffF43F5E),
                          ),
                        ),
                        Obx(
                          () => Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: 0),
                            activeColor: MyColor.colorTransparent,
                            checkColor: MyColor.colorPrimary,
                            value: checkBoxValue.value,
                            onChanged: (value) {
                              checkBoxValue.value = value!;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.5, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
