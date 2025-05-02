import 'dart:async' show Future;

import 'package:get_storage/get_storage.dart';

abstract class PrefsKey {
  static const isLoggedIn = "key_IsLoggedIn";
  static const isCaraSoulIn = "key_IsCaraSoulIn";
  static const accessToken = "key_AccessToken";
  static const key_uid = "key_uid";
  static const refreshToken = "key_RefreshToken";
  static const tokenType = "key_tokenType";
  static const userData = "key_userData";
  static const userId = "key_userId";
  static const isBankAccountAdded = "key_isBankAccountAdded";
  static const isFromNotification = "key_isFromNotification";
  static const channelId = "key_channelId";
  static const appointmentId = "key_appointmentId";
  static const agoraToken = "key_agoraToken";

  static const rememberMe = "key_RememberMe";
  static const email = "key_email";
  static const password = "key_password";
  static const labels = "key_labels";
  static const version = "key_version";
  static const language = "key_language";
  static const profilePhoto = "key_profilePhoto";
  static const bio = "key_bio";
  static const memberSince = "key_memberSince";

  static const onboarding = "key_onboarding";
  static const fName = "key_fName";
  static const lName = "key_lName";
  static const phoneNo = "key_PhoneNo";
  static const phoneNocountry = "key_PhoneNo_country";
}

abstract class SharedPref {
  static GetStorage? _prefsInstance;

  static init() {
    _prefsInstance ??= GetStorage();
  }

  static void _isPreferenceReady() {
    assert(_prefsInstance != null, "SharedPreferences not ready yet!");
  }

  static bool getBool(String key, [bool? defValue]) {
    _isPreferenceReady();
    return _prefsInstance?.read(key) ?? defValue ?? false;
  }

  static int getInt(String key, [int? defValue]) {
    _isPreferenceReady();
    return _prefsInstance?.read(key) ?? defValue ?? 0;
  }

  static double getDouble(String key, [double? defValue]) {
    _isPreferenceReady();
    return _prefsInstance?.read(key) ?? defValue ?? 0.0;
  }

  static String getString(String key, [String? defValue]) {
    _isPreferenceReady();
    return _prefsInstance?.read(key) ?? defValue ?? "";
  }

  static List<String> getStringList(String key, [List<String>? defValue]) {
    _isPreferenceReady();
    return _prefsInstance?.read(key) ?? defValue ?? [""];
  }

  static Future<void> setValue(String key, dynamic value) async {
    _prefsInstance?.write(key, value);
  }

  // Removes an entry from persistent storage.
  static Future<void> remove(String key) async {
    _prefsInstance?.remove(key);
  }

  // Returns all keys in the persistent storage.
  static Set<String>? getKeys() {
    _isPreferenceReady();
    return _prefsInstance?.getKeys();
  }

  // Completes with true once the user preferences for the app has been cleared.
  static Future<void> clearData() async {
    _prefsInstance?.erase();
  }

  // Best to clean up by calling this function in the State object's dispose() function.
  static void dispose() {
    _prefsInstance = null;
  }
}
