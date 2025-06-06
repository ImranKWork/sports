import 'dart:convert';

import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/utils/internet_controller.dart';

import '../../../../model/sign_up/sign_up_response.dart';
import '../../../../providers/api_provider.dart';
import '../../../../source/color_assets.dart';
import '../../language/controllers/language_controller.dart';

class EditProfileController extends GetxController {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var mobileController = TextEditingController();
  var isLoading = false.obs;
  var profileImage = "".obs;
  final ApiProvider apiService = ApiProvider();
  var countryCode = "+91".obs;
  var countryN = "IN".obs;
  final LanguageController languageController = Get.find();
  var numberc = "".obs;

  final internetController = Get.put(InternetController());

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setEditProfileData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    clearControllerValue();
    super.onClose();
  }

  void clearControllerValue() {
    isLoading.value = false;
    nameController.clear();
    emailController.clear();
    mobileController.clear();
    bioController.clear();
  }

  String? getIsoFromDialCode(String dialCode) {
    final country = CountryPickerUtils.getCountryByPhoneCode(
      dialCode.replaceAll('+', ''),
    );
    return country.isoCode; // e.g., "IN"
  }

  setEditProfileData() {
    String name =
        "${SharedPref.getString(PrefsKey.fName, "")} ${SharedPref.getString(PrefsKey.lName, "")}";
    String email = SharedPref.getString(PrefsKey.email, "");
    String phone = SharedPref.getString(PrefsKey.phoneNo, "");
    String bio = SharedPref.getString(PrefsKey.bio, "");
    var cdf = SharedPref.getString(PrefsKey.phoneNocountry, "");
    if (cdf.isNotEmpty) {
      countryN.value = getIsoFromDialCode(cdf.toString()).toString();
    }

    nameController = TextEditingController(text: name);
    emailController = TextEditingController(text: email);
    mobileController = TextEditingController(text: phone);
    bioController = TextEditingController(text: bio);

    profileImage.value = SharedPref.getString(PrefsKey.profilePhoto, "");
  }

  Future<void> save() async {
    final isConnected = await internetController.checkInternet();

    if (!isConnected) {
      Get.snackbar(
        languageController.getLabel("internet_error"),
        languageController.getLabel("no_internet_con"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phoneWithoutCode = mobileController.text.trim().replaceAll(" ", "");
    String phone = phoneWithoutCode;
    String bio = bioController.text.trim();
    String lang = SharedPref.getString(PrefsKey.language, "");
    String profilePhoto = SharedPref.getString(PrefsKey.profilePhoto, "");
    String userId = SharedPref.getString(PrefsKey.userId, "");

    List<String> nameParts = name.split(" ");
    String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      Get.snackbar(
        languageController.getLabel("invalid_email"),
        languageController.getLabel("valid_email"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    isLoading(true);

    final update = await updateProfile(
      firstName,
      lastName,
      email,
      lang,
      bio,
      phone,
      userId,
      profilePhoto,
      countryCode.value.trim(),
    );

    isLoading(false);

    if (update?.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(update!.body);
      final signUpData = SignUpResponseModel.fromJson(responseData);
      await SharedPref.setValue(PrefsKey.phoneNo, phoneWithoutCode);
      await SharedPref.setValue(PrefsKey.phoneNocountry, countryN.value);

      Get.put(LoginController()).saveUserInfo(signUpData);

      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => HomeView());
      });
    }
  }

  /* Future<void> save() async {
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
    String phone = mobileController.text.trim();
    String countryCode =
        this.countryCode.value; // From GetX observable or variable
    String fullPhone = "$countryCode$phone";

    String bio = bioController.text.trim();
    String lang = SharedPref.getString(PrefsKey.language, "");
    String profilePhoto = SharedPref.getString(PrefsKey.profilePhoto, "");
    String userId = SharedPref.getString(PrefsKey.userId, "");

    List<String> nameParts = name.trim().split(" ");
    String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(" ") : " ";

    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    isLoading(true);

    final update = await updateProfile(
      firstName,
      lastName,
      email,
      lang,
      bio,
      fullPhone, // Pass full phone with country code
      userId,
      profilePhoto,
    );

    isLoading(false);

    if (update?.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(update!.body);
      final signUpData = SignUpResponseModel.fromJson(responseData);

      Get.put(LoginController()).saveUserInfo(signUpData);

      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => HomeView());
      });
    }
  }
*/
  updatePhoto(String profilePhoto, String userId) async {
    isLoading.value = true;
    final response = await apiService.updateProfilePhoto(userId, profilePhoto);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final signUpData = SignUpResponseModel.fromJson(responseData);

      SharedPref.setValue(PrefsKey.profilePhoto, signUpData.data.profileImage);
      profileImage.value = signUpData.data.profileImage;

      Get.snackbar(
        languageController.getLabel("success"),
        languageController.getLabel("profile_update_success"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.themeColorOrange,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return response;
    } else {
      Get.snackbar(
        languageController.getLabel("error"),
        response.body,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }

  Future<http.Response?> updateProfile(
    String fName,
    String lName,
    String email,
    String language,
    String bio,
    String phoneNo,
    String userId,
    String profilePhoto,
    String countryCode,
  ) async {
    isLoading.value = true;
    try {
      final response = await apiService.updateProfile(
        fName,
        lName,
        email,
        language,
        bio,
        phoneNo,
        userId,
        profilePhoto,
        countryCode,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          languageController.getLabel("success"),
          languageController.getLabel("profile_update_success"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.themeColorOrange,
          colorText: Colors.white,
        );
        return response;
      } else if (response.statusCode == 400) {
        Get.snackbar(
          languageController.getLabel("error"),
          response.body,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
        return response;
      } else {
        Get.snackbar(
          languageController.getLabel("error"),
          languageController.getLabel("edit_pro_failed"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
      }
      return response;
    } catch (e) {
      Get.snackbar(
        languageController.getLabel("error"),
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
    isLoading.value = false;
    return null;
  }
}
