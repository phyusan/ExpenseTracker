


import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionCheckHelper{

    static Future<bool> isCon()async{
      var conResult = await(Connectivity().checkConnectivity());
      if (conResult == ConnectivityResult.none) {
        return false;
      }else{
        return true;
      }
    }
}