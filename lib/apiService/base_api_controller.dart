import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:logger/logger.dart';
import 'package:expense_tracker/helper/app_constant.dart';

class BaseApiController extends GetConnect {
  var logger = Logger(printer: PrettyPrinter(colors: true, printEmojis: true));

  @override
  void onInit() {
    httpClient.baseUrl = BaseUrl.nurseApi;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addRequestModifier((Request request) async {
      if (kDebugMode) {
        if (request.method == 'get') {
          logger.w(
              'http method ${request.method} =====> ${request.url.path} ${request.url.queryParameters}');
        }

        if (request.method == 'post') {
          logger.w(
              'http method ${request.method} =====> ${request.url.path} ${await request.bodyBytes.bytesToString()}');
        }
      }

      return request;
    });
    httpClient.addResponseModifier((request, response) async {
      if (kDebugMode) {
        logger.i(response.body);
      }

      return response;
    });

    // TODO: implement onInit
    super.onInit();
  }

  Future<Response> getShiftType() async =>
      await get('api/Schedule/GetShftTypeList');
  Future<Response> getNurseScheListByWeek(
          String appid, String dayofweek) async =>
      await get('api/Schedule/GetNurseScheduleListByWeek', query: {
        'appid': appid,
        'dayofweek': dayofweek,
      });
  Future<Response> getDateTimeListByDay(String day) async =>
      await get('api/Schedule/GetDateListByDay', query: {
        'day': day,
      });
}
