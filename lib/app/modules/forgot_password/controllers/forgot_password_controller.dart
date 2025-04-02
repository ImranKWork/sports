import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/utils/internet_controller.dart';

class ForgotPasswordController extends GetxController {

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString successMessage = ''.obs;
  final internetController = Get.put(InternetController());

  Future<void> forgotPassword(String email) async {
    try {

      final isConnected = await internetController.checkInternet();

      if(!isConnected){
        Get.snackbar(
          "Internet Error",
          "No internet connection",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      await _auth.sendPasswordResetEmail(email: email);
      successMessage.value = "Password reset link sent! Check your email.";

      Get.snackbar(
        "Success",
        successMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.themeColorOrange,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {

      errorMessage.value = getErrorMessage(e.code);
      Get.snackbar(
        "Error",
       errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );

    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkUserExists(String email) async {
    final auth = FirebaseAuth.instance;

    try {
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }


  Future<void> reset() async {
    String email = emailController.text.trim();

    if(email.isEmpty){
      Get.snackbar(
        "Validation Error",
        "Email is required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }



    await forgotPassword(email);

    Future.delayed(const Duration(seconds: 1), () {
      emailController.clear();
      isLoading.value = false;
      Get.to(() => LoginView());
    });
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Invalid email format.";
      case "user-not-found":
        return "No account found with this email.";
      case "network-request-failed":
        return "No internet connection.";
      default:
        return "An unknown error occurred.";
    }
  }
}


