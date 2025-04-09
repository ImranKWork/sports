import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sports_trending/app/modules/profile/controllers/profile_controller.dart';

import '../../../../core/shared_preference.dart';
import '../../../../utils/api_utils.dart';
import '../../../../utils/app_utils.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  var categories = <Map<String, dynamic>>[].obs;
  RxString selectedCategoryId = ''.obs; // Stores selected category ID

  var videos = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  void setIndex(int index) {
    currentIndex.value = index;
    if (index == 4) Get.put(ProfileController()).getProfileById();
  }

  Future<void> fetchVideos(String categoryId) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      isLoading.value = true;
      errorMessage.value = '';
      selectedCategoryId.value = categoryId;

      var url = Uri.parse(
        '${ApiUtils.BASE_URL}/v1/get-youtube-videos?keyWordId=$categoryId&pageNumber=1&limit=20',
      );

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");

        if (data['data'] != null && data['data']['videosData'] != null) {
          videos.value = List<Map<String, dynamic>>.from(
            data['data']['videosData'],
          );
        } else {
          errorMessage.value = "No videos found";
        }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    String accessToken = SharedPref.getString(PrefsKey.accessToken) ?? "";

    try {
      isLoading.value = true;

      var url = Uri.parse('${ApiUtils.BASE_URL}/admin/list-categories');

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['data'] != null && data['data']['categories'] != null) {
          categories.value = List<Map<String, dynamic>>.from(
            data['data']['categories'],
          );

          if (categories.isNotEmpty) {
            selectedCategoryId.value = categories[0]['_id'];
            fetchVideos(selectedCategoryId.value);
          }
        }
      } else {
        print("Failed to load categories: ${response.statusCode}");
      }
    } catch (e) {
      print("Category fetch error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchCategories();
    Get.put(ProfileController()).getProfileById();
    super.onInit();
  }
}
