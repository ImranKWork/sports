import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/utils/internet_controller.dart';

import '../../../../model/login/auth_error_model.dart';

class OtpVerificationController extends GetxController {
  late final LoginController loginController;
  var otpController = TextEditingController();
  var isLoading = false.obs;

  var isResendButtonEnabled = false.obs;
  var resendTimer = 30.obs;
  var vId = "";
  Timer? timer;

  @override
  void onReady() {
    startResendTimer();
    loginController =  Get.find<LoginController>();
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void startResendTimer() {
    isResendButtonEnabled.value = false;
    timer?.cancel(); // Cancel any previous timers

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        isResendButtonEnabled.value = true;
        t.cancel();
      }
    });
  }

  /// Resend OTP
  Future<void> resendOTP(String phoneNumber) async {
    print("innn");
    isLoading(true);
    isResendButtonEnabled.value = false; // Disable resend button initially
    resendTimer.value = 30; // Reset timer
    startResendTimer(); // Start countdown
    loginController.sendOTP(phoneNumber,isResend: true).then((val){
      isLoading(false);
    });

  }

  final internetController = Get.put(InternetController());

  Future<void> verifyOtp() async {
    final isConnected = await internetController.checkInternet();
    if (!isConnected) {
      Get.snackbar(
        "Internet Error",
        "No internet connection",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }
    String otp = otpController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar(
        "Invalid OTP",
        "Please enter OTP!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (otp.length != 6) {
      Get.snackbar(
        "Invalid OTP",
        "Please enter a valid 6-digit OTP!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    try{
      isLoading(true);
      PhoneAuthCredential authCred =  PhoneAuthProvider.credential(
          verificationId: vId, smsCode: otp);
      UserCredential user = await FirebaseAuth.instance.signInWithCredential(authCred);
      print(user);

      loginController.updateUser(user).then((data){
        isLoading(false);

      }).catchError((error){
        isLoading(false);
      });


    }on FirebaseAuthException catch (e) {
      isLoading(false);
      AuthErrorModel authErrorModel = AuthErrorModel.fromFirebaseError(e.code);
      Get.snackbar(
        "Error",
        authErrorModel.message ?? "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    }


    // final phoneNumber = loginController.countryCode.value +
    //     loginController.mobileController.text.trim();
    // loginController.sendOTP(phoneNumber);

  }
}
