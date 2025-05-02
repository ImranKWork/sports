import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/utils/api_utils.dart';
import 'package:sports_trending/utils/app_utils.dart';

class UserProfileController extends GetxController {
  //TODO: Implement UserProfileController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onReady() {
    super.onReady();
    getProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  var totalLikes = 0.obs;
  var totalWached = 0.obs;
  var totalShared = 0.obs;
  var totalComments = 0.obs;

  Future<http.Response> getProfile() async {
    final url = Uri.parse('${ApiUtils.BASE_URL}/v1/my-video/track-engagement');
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    String deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    final response = await http.get(
      url,

      headers: {
        ApiUtils.DEVICE_ID: deviceId,
        ApiUtils.DEVICE_TOKEN: token,
        ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,

        ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
      },
    );

    if (response.statusCode == 200) {
      debugPrint("response : ${response.body}");
      var data = json.decode(response.body);
      totalLikes.value = data["data"]["total_liked_videos"];
      totalWached.value = data["data"]["total_watched_videos"];
      totalShared.value = data["data"]["total_shared_videos"];
      totalComments.value = data["data"]["total_comments_made"];

      return response;
    } else if (response.statusCode == 400) {
      return response;
    } else {
      throw Exception("Failed");
    }
  }
}
