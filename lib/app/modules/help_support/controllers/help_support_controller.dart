import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/utils/internet_controller.dart';

import '../../../../providers/api_provider.dart';
import '../../../../source/color_assets.dart' show ColorAssets;

class HelpSupportController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final msgController = TextEditingController();
  var isLoading = false.obs;
  var isSendMsgLoading = false.obs;
  final internetController = Get.put(InternetController());

  var selectedIndex = 0.obs;
  var selectedContent = "".obs;
  var content = "".obs;
  var termcontent = "".obs;
  final faqPageKey = "Frquently";
  final privacyPolicyPageKey = "Privacy_Policy";
  final termsPolicyPageKey = "Term_Policy";
  final ApiProvider apiService = ApiProvider();
  var faqList = <FAQModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedContent.value = privacyPolicyPageKey;
    getSpecificPage();
    gettermcPage();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      selectedContent.value = privacyPolicyPageKey;
    } else if (index == 1) {
      selectedContent.value = faqPageKey;
    } else {
      selectedContent.value = "";
    }
    if (index == 0 || index == 1) {
      getSpecificPage();
    }
  }

  Future<void> getSpecificPage() async {
    try {
      isLoading(true);
      final response = await ApiProvider().getSpecificPage(
        selectedContent.value,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("faq data: ${response.body}");
        content.value = data["data"]["pageContent"];
        var faqData = List<FAQModel>.from(
          data["data"]["faq"].map((item) => FAQModel.fromJson(item)),
        );
        faqList.value = faqData;
      }
    } catch (e) {
      debugPrint("error:$e");
      Get.snackbar("Error", "Failed to load labels : $e");
    } finally {
      isLoading(false);
    }
    isLoading(false);
  }

  Future<void> gettermcPage() async {
    try {
      isLoading(true);
      final response = await ApiProvider().getSpecificPage(termsPolicyPageKey);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("faq data: ${response.body}");
        termcontent.value = data["data"]["pageContent"];
        // var faqData = List<FAQModel>.from(
        //   data["data"]["faq"].map((item) => FAQModel.fromJson(item)),
        // );
        // faqList.value = faqData;
      }
    } catch (e) {
      debugPrint("error:$e");
      Get.snackbar("Error", "Failed to load labels : $e");
    } finally {
      isLoading(false);
    }
    isLoading(false);
  }

  void toggleFAQ(int index) {
    faqList[index].isExpanded = !faqList[index].isExpanded;
    faqList.refresh(); // Force UI update
  }

  Future<void> sendMessage() async {
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
    String message = msgController.text.trim();

    if (name.isEmpty) {
      Get.snackbar(
        "Name Error",
        "Please enter name",
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

    if (message.isEmpty) {
      Get.snackbar(
        "Message Error",
        "Please enter message",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    isSendMsgLoading(true);

    final send = await apiService.contactUs(name, email, message);

    isSendMsgLoading(false);

    if (send.statusCode == 200) {
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(SnackBar(content: Text("Message send successfully")));
        Get.back();
      });
    }
  }
}

class FAQModel {
  String question;
  String answer;
  bool isExpanded;

  FAQModel({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      question: json["question"] ?? "",
      answer: json["answer"] ?? "",
    );
  }
}
