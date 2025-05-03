import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchVideoController extends GetxController {
  var isLoading = false.obs;
  var videoResults = <Map<String, dynamic>>[].obs;
  var videoTrendingResults = <Map<String, dynamic>>[].obs;
  var recentSearchdata = [].obs;
  var trendingSearchdata = [].obs;

  RxString selectedSort = ''.obs;
  RxString selectedDateRange = ''.obs;
  RxString selectedPlatForm = ''.obs;

  RxString fselectedSort = ''.obs;
  RxString fselectedDateRange = ''.obs;
  RxString fselectedPlatForm = ''.obs;
  RxList<Map<String, dynamic>> videos = <Map<String, dynamic>>[].obs;
  RxBool isLoadingMore = false.obs;
  RxInt currentPage = 1.obs;

  Future<void> trendingVideos({bool isLoadMore = false}) async {
    if (isLoadMore && isLoadingMore.value) return;

    if (isLoadMore) {
      isLoadingMore.value = true;
      currentPage.value++;
    } else {
      isLoading.value = true;
      currentPage.value = 1;
      videos.clear();
      videoResults.clear();
    }

    final url = Uri.parse(
      'https://urgd9n1ccg.execute-api.us-east-1.amazonaws.com/v1/search/get-trending-video?pageNumber=${currentPage.value}&limit=10',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final newVideos = List<Map<String, dynamic>>.from(
          jsonData['data']['videosData'],
        );

        if (isLoadMore) {
          videos.addAll(newVideos); // Append to existing list
        } else {
          videos.assignAll(newVideos); // Replace list
        }

        videoTrendingResults.value = videos;
      } else {
        Get.snackbar('Error', 'Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  Future<void> recentSearchData({bool isLoadMore = false}) async {
    final url = Uri.parse(
      'https://urgd9n1ccg.execute-api.us-east-1.amazonaws.com/v1/search/trending-recent',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        recentSearchdata.value = jsonData['recent_searches'];

        trendingSearchdata.value = jsonData['trending_searches'];
      } else {
        Get.snackbar('Error', 'Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {}
  }

  Future<void> fetchSearchVideos({
    required String keyword,
    required int page,
    required int limit,
    required String timeRange,
    required String type,
    required String sort,
  }) async {
    isLoading.value = true;

    final encodedKeyword = Uri.encodeComponent(keyword);
    final url = Uri.parse(
      'https://urgd9n1ccg.execute-api.us-east-1.amazonaws.com/v1/search/search-video'
      '?timeRange=$timeRange'
      '&pageNumber=$page'
      '&limit=$limit'
      '&type=$type'
      '&sort=$sort'
      '&keyword=$encodedKeyword',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        videoResults.value = List<Map<String, dynamic>>.from(
          jsonData['data']['videosData'],
        );

        print(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
