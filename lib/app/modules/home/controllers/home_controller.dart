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
  var myVideosCategories = [
    {"name": "Liked Videos", "id": "1"},
    {"name": "Shared Videos", "id": "2"},
    {"name": "Commented Videos", "id": "3"},
    {"name": "Viewed Videos", "id": "4"},
  ];

  RxString selectedCategoryId = ''.obs; // Stores selected category ID
  final RxString selectedCategory = ''.obs;
  var videos = <Map<String, dynamic>>[].obs;
  var recentsLikesVideos = <Map<String, dynamic>>[].obs;
  var recentsCommentsVideos = <Map<String, dynamic>>[].obs;
  var recentsViewedVideos = <Map<String, dynamic>>[].obs;
  var recentsSharedVideos = <Map<String, dynamic>>[].obs;
  var commentsList = <Map<String, dynamic>>[].obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  void setIndex(int index) {
    currentIndex.value = index;
    if (index == 4) Get.put(ProfileController()).getProfileById();
  }

  likeVideos(String videoId) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/video/$videoId/like');

      var response = await http.post(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");
        return data;
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  shareVideos(String videoId) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/video/$videoId/share');

      var response = await http.post(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");
        return data;
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  viewVideos(String videoId) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/video/$videoId/view');

      var response = await http.post(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");
        return data;
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> myCommentsVideos() async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/my-video/recent-comments');

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");

        if (data['data'] != null && data['data']['recent_comment'] != null) {
          recentsCommentsVideos.value = List<Map<String, dynamic>>.from(
            data['data']['recent_comment'],
          );
        } else {
          errorMessage.value = "No videos found";
        }
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> mySharedVideos() async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/my-video/recent-shared');

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");

        if (data['data'] != null && data['data']['recent_shared'] != null) {
          recentsSharedVideos.value = List<Map<String, dynamic>>.from(
            data['data']['recent_shared'],
          );
        } else {
          errorMessage.value = "No videos found";
        }
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> myViewedVideos() async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/my-video/recent-viewed');

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");

        if (data['data'] != null && data['data']['recent_views'] != null) {
          recentsViewedVideos.value = List<Map<String, dynamic>>.from(
            data['data']['recent_views'],
          );
        } else {
          errorMessage.value = "No videos found";
        }
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> commentVideos(String videoId, comment, [void param2]) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    try {
      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/video/$videoId/add-comment');

      var response = await http.post(
        url,
        body: {"commentText": comment},
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          // ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");
        fetchComments(videoId);
        //message Video Liked
        //likes

        // if (data['data'] != null && data['data']['videosData'] != null) {
        //   videos.value = List<Map<String, dynamic>>.from(
        //     data['data']['videosData'],
        //   );
        // } else {
        //   errorMessage.value = "No videos found";
        // }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch videos: $e";
    } finally {
      isLoading.value = false;
    }
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
        '${ApiUtils.BASE_URL}/v1/get-youtube-videos?keyWordId=$categoryId&pageNumber=1&limit=300',
      );

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
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

  Future<void> fetchComments(String id, [void param2]) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    commentsList.value.clear();
    try {
      isLoading.value = true;
      errorMessage.value = '';

      var url = Uri.parse(
        '${ApiUtils.BASE_URL}/v1/video/$id/comments?pageNumber=1&limit=100',
      );

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home datas: ${response.body}");
        print("access Token: ${accessToken} hh:");

        if (data['data'] != null && data['data']['comments'] != null) {
          commentsList.value = List<Map<String, dynamic>>.from(
            data['data']['comments'],
          );

          commentsList.refresh();
          param2;
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
      param2;
    }
  }

  Future<void> editComment(
    String videoId,
    String commentId,
    String commentText,
  ) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);

    var url = Uri.parse(
      '${ApiUtils.BASE_URL}/v1/video/$commentId/edit-comment',
    );

    var body = jsonEncode({"commentText": commentText});

    try {
      var response = await http.put(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("Comment edited successfully: ${response.body}");
        await fetchComments(videoId);
      } else {
        print("Failed to edit comment. Status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("Error editing comment: $e");
    }
  }

  Future<void> deleteComment(String videoId, String commentId) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    final userId = SharedPref.getString(PrefsKey.userId);

    var url = Uri.parse(
      '${ApiUtils.BASE_URL}/v1/video/$commentId/delete-comment',
    );

    var body = jsonEncode({"user_id": userId});

    try {
      final response = await http.delete(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer $accessToken",
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("Comment deleted successfully");
        await fetchComments(videoId); // refresh comment list
      } else {
        print("Failed to delete comment: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("Error deleting comment: $e");
    }
  }

  Future<void> fetchLikedVideos() async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    recentsLikesVideos.clear();
    try {
      isLoading.value = true;
      errorMessage.value = '';

      var url = Uri.parse('${ApiUtils.BASE_URL}/v1/my-video/recent-liked');

      var response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Home data: ${response.body}");

        if (data['data'] != null && data['data']['recent_liked'] != null) {
          recentsLikesVideos.value = List<Map<String, dynamic>>.from(
            data['data']['recent_liked'],
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
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
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
            selectedCategory.value = categories[0]['name'];
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
    //fetchCategories();
    Get.put(ProfileController()).getProfileById();
    super.onInit();
  }
}
