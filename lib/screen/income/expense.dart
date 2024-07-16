import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/screen/history/expense_controller.dart';

class ExpenseScreen extends StatelessWidget {
  ExpenseScreen({super.key});
  final ExpendController _expendController = Get.put(ExpendController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Expense Card
              Container(
                decoration: BoxDecoration(
                  color: MyColor.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 185, 182, 182)
                          .withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
                height: 200,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "March Savings",
                        style: TextStyle(
                          color: MyColor.colorBlackSemiTransparent,
                          fontSize: FontSize.textSizeSmall,
                        ),
                      ),
                      const Text(
                        "23,430,000 Ks",
                        style: TextStyle(
                          color: MyColor.colorBlackSemiTransparent,
                          fontSize: FontSize.textSizeExtraLarge,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColor.colorGreyLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            Container(
                                height: 30,
                                width: 210,
                                decoration: BoxDecoration(
                                    color: MyColor.colorBlue.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 3),
                                  child: Text(
                                    "Earned",
                                    style: TextStyle(
                                        color: MyColor.colorWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            const Positioned(
                              right: 20,
                              top: 3,
                              child: Text(
                                '20,5000 Ks',
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColor.colorGreyLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color:
                                        MyColor.colorTextRed.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 3),
                                  child: Text(
                                    "Spend",
                                    style: TextStyle(
                                        color: MyColor.colorWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            const Positioned(
                              right: 20,
                              top: 3,
                              child: Text(
                                '10,5000 Ks',
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Top Spending',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.textSizeLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: _expendController.spendingCategoryList.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _expendController
                                    .spendingCategoryList[i].containerColor ??
                                MyColor.colorPinkLight.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.emoji_transportation,
                              color: _expendController
                                      .spendingCategoryList[i].iconColor ??
                                  MyColor.colorWhite,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(_expendController
                                .spendingCategoryList[i].description ??
                            '')
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Monthly Budget",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.textSizeLarge),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: MyColor.colorBlueLightBg,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   color: MyColor.colorWhite,
                //   boxShadow: [
                //     BoxShadow(
                //       color: const Color.fromARGB(255, 185, 182, 182)
                //           .withOpacity(0.3),
                //       spreadRadius: 2,
                //       blurRadius: 1,
                //       offset:
                //           const Offset(1, 2), // changes position of shadow
                //     ),
                //   ],
                // ),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _expendController.spendingCategoryList.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 10,
                              dense: true,
                              leading: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _expendController
                                              .spendingCategoryList[i]
                                              .containerColor ??
                                          MyColor.colorBlue),
                                  child: const Icon(Icons.emoji_transportation,
                                      size: 24)),
                              title: Text(_expendController
                                      .spendingCategoryList[i].description ??
                                  ''),
                              trailing: const Text(
                                "45,800 Ks",
                                style: TextStyle(
                                    fontSize:
                                        FontSize.textSizeNormalReaderView),
                              ),
                            ),
                            if (i + 1 ==
                                _expendController
                                    .spendingCategoryList.length) ...[
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: MyColor.colorBlue, width: 2)),
                                  child: const Text(
                                    'Total Amount  :   785000 Ks',
                                    style: TextStyle(
                                        fontSize:
                                            FontSize.textSizeNormalReaderView),
                                  ))
                            ]
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
