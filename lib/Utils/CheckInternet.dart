
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet {
  static Future<bool> checkInternet() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}