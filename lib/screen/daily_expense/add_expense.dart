import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/database/dao/expense_dao.dart';
import 'package:expense_tracker/model/fcm_model.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/generated/assets.dart';
import 'package:expense_tracker/helper/app_constant.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key, required this.db});
  final AppDatabase db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColor.colorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 325,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: MyColor.colorBlue.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                  color: MyColor.colorWhite,
                                  fontSize: FontSize.textSizeLarge,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Mr.Gerolwu Veli',
                              style: TextStyle(
                                fontSize: FontSize.textSizeExtraLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Your Balance',
                              style: TextStyle(
                                  color: MyColor.colorWhite,
                                  fontSize: FontSize.textSizeLarge,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '439,540,00 Ks',
                              style: TextStyle(
                                  fontSize: FontSize.textSizeExtraLarge,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              var model = FcmModel(
                                  id: null,
                                  name: 'Ma Poe',
                                  phone: 123456,
                                  incomeAmount: '2340000',
                                  outcomeAmount: '34000',
                                  isRead: 0,
                                  isNew: true);
                              db.expenseDao.insertAccount(model);
                              print(
                                  "hello;;${db.expenseDao.findAllPersons().toString()}");
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: MyColor.colorGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                Assets.imagesAddicon,
                                width: 18,
                                height: 18,
                                color: MyColor.colorWhite,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Transcations",
                  style: TextStyle(
                      color: MyColor.colorBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.textSizeExtraLarge),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
