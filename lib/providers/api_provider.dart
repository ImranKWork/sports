import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:sports_trending/utils/app_utils.dart';

import '../core/shared_preference.dart';
import '../utils/api_utils.dart';

class ApiProvider {
  static var client = http.Client();

  Future<http.Response> signUp(
    String fName,
    String lName,
    String email,
    String password,
  ) async {
    final url = Uri.parse('${ApiUtils.BASE_URL}/auth/register');
    var reff = SharedPref.getString(PrefsKey.refercode) ?? "";
    final response = await http.post(
      url,
      body: jsonEncode({
        "firstname": fName,
        "lastname": lName,
        "email": email,
        "password": password,
        "referralCode": reff,
      }),
      headers: {"Content-Type": "application/json"},
    );
    debugPrint("response : ${response.body}");

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400) {
      return response;
    } else {
      throw Exception("Failed to sign up");
    }
  }

  Future<http.Response> updateUser(
    String fName,
    String lName,
    String email,
    String? uid, {
    String? language,
    String? socialToken,
    String? token,
  }) async {
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    // String? language = SharedPref.getString(PrefsKey.language);
    final url = Uri.parse('${ApiUtils.BASE_URL}/auth/update-user');
    final accessToken =
        token.isNotEmpty ? token : SharedPref.getString(PrefsKey.accessToken);

    final response = await http.post(
      url,
      body:
          language != null
              ? jsonEncode({
                "firstname": fName,
                "lastname": lName,
                "email": email,
                "language": language,
                "userId": uid,
              })
              : jsonEncode({
                "firstname": fName,
                "lastname": lName,
                "email": email,
                "userId": uid,
              }),

      headers: {
        ApiUtils.DEVICE_ID: deviceId,
        ApiUtils.DEVICE_TOKEN: token,
        ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        ApiUtils.AUTHORIZATION: accessToken,
      },
    );

    debugPrint(
      "req update user: ${jsonEncode({"firstname": fName, "lastname": lName, "email": email, "language": language})}",
    );

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400) {
      return response;
    } else {
      throw Exception("Failed to sign up");
    }
  }

  Future<http.Response> updateProfilePhoto(
    String userId,
    String profilePhoto,
  ) async {
    try {
      String token = await FirebaseMessaging.instance.getToken() ?? "";
      String deviceId = await AppUtils.getDeviceDetails() ?? "";
      final url = Uri.parse('${ApiUtils.BASE_URL}/user/$userId');
      final accessToken = SharedPref.getString(PrefsKey.accessToken) ?? "";
      //
      // if (accessToken.isEmpty) {
      //   throw Exception("Access token is missing");
      // }

      // Validate file format (only allow JPG and PNG)
      String? mimeType = lookupMimeType(profilePhoto);
      if (mimeType != "image/jpeg" && mimeType != "image/png") {
        throw Exception(
          "Invalid image format. Please select a JPG or PNG file.",
        );
      }

      var request = http.MultipartRequest('PUT', url);

      request.headers.addAll({
        ApiUtils.DEVICE_ID: deviceId,
        ApiUtils.DEVICE_TOKEN: token,
        ApiUtils.AUTHORIZATION: accessToken,
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          profilePhoto,
          contentType: MediaType.parse(
            mimeType!,
          ), // Ensure correct content type
        ),
      );

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      debugPrint("Status Code: ${responseData.statusCode}");
      debugPrint("Response Body: ${responseData.body}");

      return responseData;
    } catch (e) {
      debugPrint("Error uploading profile photo: $e");
      throw Exception("Failed to upload profile photo: $e");
    }
  }

  Future<http.Response> updateProfile(
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
    final url = Uri.parse('${ApiUtils.BASE_URL}/user/$userId');
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    String deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    debugPrint("uid :$userId");

    Map<String, dynamic> requestBody = {};
    var uid = SharedPref.getString(PrefsKey.key_uid);

    if (fName.isNotEmpty) requestBody["firstname"] = fName;
    if (lName.isNotEmpty) requestBody["lastname"] = lName;
    if (email.isNotEmpty) requestBody["email"] = email;
    if (language.isNotEmpty) requestBody["language"] = language;
    if (bio.isNotEmpty) requestBody["bio"] = bio;
    if (profilePhoto.isNotEmpty) requestBody["file"] = profilePhoto;
    if (phoneNo.isNotEmpty) requestBody["phoneNumber"] = phoneNo;
    if (phoneNo.isNotEmpty) requestBody["countryCode"] = countryCode;
    requestBody["userId"] = uid;

    if (requestBody.isNotEmpty) {
      final response = await http.put(
        url,
        body: jsonEncode(requestBody),
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,

          ApiUtils.AUTHORIZATION: accessToken,
        },
      );
      debugPrint("request : $requestBody}");

      if (response.statusCode == 200) {
        debugPrint("response : ${response.body}");
        return response;
      } else if (response.statusCode == 400) {
        return response;
      } else {
        throw Exception("Failed");
      }
    } else {
      throw Exception("Failed");
    }
  }

  Future<http.Response> fetchLabels() async {
    debugPrint("calling fetch label api");
    final url = Uri.parse(
      '${ApiUtils.BASE_URL}/admin/get-label?pageNumber=1&limit=10000',
    );

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    debugPrint("response : ${response.body}");

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to get labels");
    }
  }

  Future<http.Response> getProfileById(String userId) async {
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    String deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    final url = Uri.parse('${ApiUtils.BASE_URL}/user/$userId');

    final response = await http.get(
      url,
      headers: {
        ApiUtils.DEVICE_ID: deviceId,
        ApiUtils.DEVICE_TOKEN: token,
        ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
        ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
      },
    );
    debugPrint("response : ${response.body}");

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to get labels");
    }
  }

  Future<http.Response> contactUs(
    String name,
    String email,
    String message,
  ) async {
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    String deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    final url = Uri.parse('${ApiUtils.BASE_URL}/admin/contact-us');

    final response = await http.post(
      url,
      body: jsonEncode({"email": email, "name": name, "message": message}),
      headers: {
        ApiUtils.DEVICE_ID: deviceId,
        ApiUtils.DEVICE_TOKEN: token,
        ApiUtils.AUTHORIZATION: accessToken,
        ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
      },
    );
    debugPrint("response : ${response.body}");

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to send message");
    }
  }

  Future<http.Response> getSpecificPage(String pageKey) async {
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    String deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    final url = Uri.parse('${ApiUtils.BASE_URL}/admin/get-page');
    debugPrint("page key : $pageKey");

    final response = await http.post(
      url,
      body: jsonEncode({"pageKey": pageKey}),
      headers: {
        ApiUtils.DEVICE_ID: deviceId,
        ApiUtils.DEVICE_TOKEN: token,
        ApiUtils.AUTHORIZATION: accessToken,
        ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
      },
    );
    debugPrint("response : ${response.body}");

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to get content");
    }
  }
}
