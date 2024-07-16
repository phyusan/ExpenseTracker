import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppConstant {
  static const String txtTryAgain = 'Try again';
  static const String txtNoInternet = 'Check internet connection';
  static const String txtChooseServiceType = 'Select one';
  static const String txtChooseLocation = 'Select Location';

  static const String lightTheme = 'Light theme';
  static const String darkTheme = 'Dark theme';
  static const int camera = 0, gallery = 1;
  static String imageUrl(String url) {
    return BaseUrl.imageUrl + url;
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  static String getFileExtension(String fileExtension) {
    if (fileExtension == 'jpeg' || fileExtension == 'jpg') {
      return 'jpeg';
    } else {
      return fileExtension;
    }
  }
}

class MyColor {
  static String appTheme = AppConstant.lightTheme;

  static const colorPrimary = Color(0xffF43F5E);
  static const colorNeutral900 = Color(0xff18181B);
  static const colorNeutral100 = Color(0xffF4F4F5);
  static const colorNeutral200 = Color(0xffE4E4E7);
  static const colorNeutral300 = Color(0xffD4D4D8);
  static const colorNeutral400 = Color(0xffA1A1AA);
  static const colorNeutral500 = Color(0xff71717A);
  static const colorNeutral600 = Color(0xff52525B);
  static const colorNeutral700 = Color(0xff3F3F46);
  static const colorTeal600 = Color(0xff0D9488);
  static const colorRose50 = Color(0xffFFF1F2);
  static const colorSupportives = Color(0xff0EA5E9);

  static const colorBlueGray500 = Color(0xff64748B);
  static const Color colorRed100 = Color(0xffFEEEEF);
  static const Color colorLinkWater = Color(0xffCBD5E1);
  static const Color colorTeal = Color(0xff14B8A6);
  static const colorBlueGray = Color(0xff0f172a);
  static const Color colorWhite = Color(0xffffffff);
  static const Color colorBlackSemiTransparent = Color(0xffB2000000);
  static const Color colorTransparent = Color(0x00000000);
  static const Color colorBlue = Color(0xff0075FF);
  static const Color colorBlueLightBg = Color(0xffd9f0ff);
  static const Color colorPinkLightBg = Color(0xffFFF3F8);
  static const Color colorGreyLight = Color(0xffF4F5F7);
  static const Color colorDivider = Color(0xffEEEFF4);
  static const Color colorSearchBg = Color(0xffEEEFF4);
  static const Color colorBlueLight = Color(0xffD6DBE9);
  static const Color colorPinkLight = Color(0xffFFC7DE);
  static const Color colorGrey = Color(0xff474A57);
  static const Color colorError = Color(0xffd9534f);
  static const Color colorRedTransparent = Color(0xffb2d69d9a);
  static const Color colorGreen = Color(0xff00C6AE);

  static const Color colorProfileGradient1 = Color(0xffFFFCF1);
  static const Color colorProfileGradient2 = Color(0xffF5F9FF);
  static const Color colorProfileGradient3 = Color(0xff9EF3FF);
  static const Color colorCheckupGradient1 = Color(0xffDEE9FF);
  static const Color colorCheckupGradient2 = Color(0xffC1D6FF);
  static const Color colorCheckupGradient3 = Color(0xffDEE9FF);

  //widget color
  static const Color colorTextFieldBorder = Color(0xffEEEFF4);

  //Text color
  static const Color colorTextHint = Color(0xff9FA4B4);
  static const Color colorTextGrey = Color(0xffbab5b6);
  static const Color colorTextBlack = Color(0xff000000);
  static const Color colorTextBlack800 = Color(0xff474A57);
  static const Color colorTextWhite = Color(0xffffffff);
  static const Color colorTextRed = Color(0xffF95A2C);
  static const Color colorTextOrange = Color(0xffFFBD12);
  static const Color colorFollowSnackBarBg = Color(0xffE9E7FC);
  static const Color colorTextBlueLight = Color(0xff8094FF);
  static const Color colorTextBlack500 = Color(0xff18191F);
  static const Color colorBookingSuccessBg = Color(0xffC3DFFF);
}

class FontSize {
  static const double textSizeExtraXLLarge = 40;
  static const double textSizeExtraXLarge = 30;
  static const double textSizeExtraLarge = 24;
  static const double textSizeLarge = 20;
  static const double textSizeExtraNormal = 18;
  static const double textSizeNormal = 14;
  static const double textSizeNormalReaderView = 16;
  static const double textSizeExtraSmall = 13;
  static const double textSizeSmall = 12;
  static const double textSizeLessSmall = 10;
}

String encodeFormData(Map<String, dynamic> data) {
  return data.keys
      .map((key) => "$key=${Uri.encodeComponent(data[key])}")
      .join("&");
}

class BaseUrl {
  static const String nurseApi = "https://caremenurseapi.azurewebsites.net/";
  static const String paymentApi =
      "https://paymentgateway.yammobots.com/kbzpay/";
  static const String imageUrl =
      "https://caremestorage.blob.core.windows.net/caremerss/Careme/";
}

Map<T, List<S>> groupsBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

final logger = Logger(
  printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 200,
      errorMethodCount: 3,
      colors: true,
      printEmojis: true),
);
