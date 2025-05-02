import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchVideoController extends GetxController {
  var isLoading = false.obs;
  var videoResults = <Map<String, dynamic>>[].obs;
  RxString selectedSort = ''.obs;
  RxString selectedDateRange = ''.obs;
  RxString selectedPlatForm = ''.obs;
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
        final videosData = jsonData['data']['videosData'] as List;

        videoResults.value =
            videosData.map((video) {
              return {
                'title': video['title'],
                'videoUrl': video['videoUrl'],
                'thumbnailUrl': video['thumbnails']['default']['url'],
                'subtitleLinks': video['videoContent']['subtitleLinks'] ?? [],
                'sourceLikes': video['sourceLikes'] ?? 0,
                'sourceViews': video['sourceViews'] ?? 0,
                'sourceComments': video['sourceComments'] ?? 0,
                'sourceSharess': video['sourceSharess'] ?? 0,
              };
            }).toList();

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
