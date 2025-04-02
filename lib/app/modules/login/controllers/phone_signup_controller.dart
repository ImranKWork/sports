import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sports_trending/app/modules/home/views/home_view.dart';

import '../../../../providers/api_provider.dart';
import '../../../../source/color_assets.dart';
import '../../../../utils/internet_controller.dart';

class PhoneSignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final internetController = Get.put(InternetController());
  final ApiProvider apiService = ApiProvider();
  var isLoading = false.obs;

  void clearControllerValue() {
    nameController.clear();
    emailController.clear();

    isLoading.value = false;
  }

  Future<void> register() async {
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
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    List<String> nameParts = name.trim().split(" ");

    String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(" ") : " ";

    if (name.isEmpty) {
      Get.snackbar(
        "Name Error",
        "Please enter a name!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (email.isEmpty) {
      Get.snackbar(
        "Email Error",
        "Please enter a email!",
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

    final register = await signUpUser(firstName, lastName, email, "");
    if (register?.statusCode == 200) {
      clearControllerValue();
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => HomeView());
      });
    }
  }

  Future<http.Response?> signUpUser(
    String fName,
    String lName,
    String email,
    String password,
  ) async {
    isLoading.value = true;
    try {
      final response = await apiService.signUp(fName, lName, email, password);
      debugPrint("res : ${response.statusCode}");

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          'New user created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.themeColorOrange,
          colorText: Colors.white,
        );
        return response;
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Error",
          response.body,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
        return response;
      } else {
        Get.snackbar(
          "Error",
          "Sign-up failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
      }
      return response;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}
