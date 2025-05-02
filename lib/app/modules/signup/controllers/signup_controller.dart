import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sports_trending/app/modules/language/views/language_view.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/providers/api_provider.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/utils/internet_controller.dart';

import '../../../../model/sign_up/sign_up_response.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isIAgree = false.obs;
  var isLoading = false.obs;

  final ApiProvider apiService = ApiProvider();

  final formKey = GlobalKey<FormState>();
  final internetController = Get.put(InternetController());

  void termConditionPrivacyPolicy() {
    isIAgree.value = !isIAgree.value;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void iAgreeTermCondition() {
    isIAgree.value = !isIAgree.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void clearControllerValue() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isIAgree.value = false;
    isLoading.value = false;
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
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
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

    if (password.length < 6) {
      Get.snackbar(
        "Weak Password",
        "Password must be at least 6 characters!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "Password Mismatch",
        "Confirm Password does not match!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidPassword(password)) {
      Get.snackbar(
        "Password Error",
        "Password should have at least 1 uppercase, 1 lowercase, 1 digit and 1 special character",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidPassword(confirmPassword)) {
      Get.snackbar(
        "Password Error",
        "Confirm Password should have at least 1 uppercase, 1 lowercase, 1 digit and 1 special character",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (!isIAgree.value) {
      Get.snackbar(
        "Validation Error",
        "Please select I agree Term & Condition & Privacy & Policy",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    final register = await signUpUser(firstName, lastName, email, password);
    if (register?.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(register!.body);
      final signUpData = SignUpResponseModel.fromJson(responseData);
      var uid = responseData["data"]["uid"];
      await SharedPref.setValue(PrefsKey.key_uid, uid.toString());
      await SharedPref.setValue(PrefsKey.refercode, "");

      // clearControllerValue();
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(
          () => LanguageView(
            firstName: firstName,
            lastName: lastName,
            email: email,
            accessToken: responseData["token"],
            fromSignup: true,
          ),
        );
      });
    }
  }
}

bool isValidPassword(String password) {
  String pattern =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(password);
}
