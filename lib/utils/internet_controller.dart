import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetController extends GetxController {
  var isConnected = false.obs;

  Future<bool> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;

    if (isConnected.value) {
      return true;
    }
    return false;
  }
}
