import 'package:get/get.dart';
import 'package:sports_trending/providers/api_provider.dart';


class LifeCycleController extends SuperController {

  @override
  void onReady() {
    //ApiProvider.setDeviceSession("1");
  }

  @override
  void onDetached() {
  }

  @override
  void onInactive() {
    //ApiProvider.setDeviceSession("0");
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
    //ApiProvider.setDeviceSession("1");
  }

  @override
  void onHidden() {

  }
}