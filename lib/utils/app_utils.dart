import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/styles.dart';

import '../source/color_assets.dart';

// handle email validation
class AppUtils {
  static isEmailValid(String str) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!(regex.hasMatch(str)));
  }

  static Future<String?> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        return build.id; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;

        return data.identifierForVendor ?? ""; //UUID for iOS
      }
    } on PlatformException {
      return null;
    }
  }

  // show toast
  //   static showToast(String text) {
  //     return Fluttertoast.showToast(
  //       msg: text,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 2,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 16,
  //     );
  //   }

  static Future<void> showDialog(
    String title, {
    VoidCallback? onConfirm,
    String? buttonTxt,
  }) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: Styles.textStyleBlackMedium,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  ColorAssets.themeColorOrange,
                ),
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text("Ok"),
            ),
          ),
        ],
      ),
    );
  }

  static Future<String?> getRefreshToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    final refreshTokens = await user!.getIdTokenResult(true);
    SharedPref.setValue(PrefsKey.accessToken, refreshTokens.token);
    return refreshTokens.token;
  }

  // hide keyboard
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  //get current timestamp
  static String getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String getCurrentDateYYYYMMDD([DateTime? dt]) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dt ?? now);
    return formattedDate;
  }

  static String getCurrentDateDDMMYYYY() {
    var now = DateTime.now();
    var formatter = DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getDateDDMMYYYY(DateTime notificationDateTime) {
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    DateFormat formatter;
    //Check if same year
    if (notificationDateTime.year == todayDate.year) {
      int dayOfNotificationDate = int.parse(
        DateFormat("D").format(notificationDateTime),
      );
      int weekOfNotificationDate =
          ((dayOfNotificationDate - notificationDateTime.weekday + 10) / 7)
              .floor();

      int dayOfTodayDate = int.parse(DateFormat("D").format(todayDate));
      int weekOfTodayDate =
          ((dayOfTodayDate - todayDate.weekday + 10) / 7).floor();

      //check if same week, then show day i.e. Thursday else 16 Aug
      if (weekOfTodayDate == weekOfNotificationDate) {
        formatter = DateFormat('EEEE');
      } else {
        formatter = DateFormat('dd MMM');
      }
    } else {
      //If it is of different year then show i.e. 16 Aug 2022
      formatter = DateFormat('dd MMM yyyy');
    }
    String formattedDate = formatter.format(notificationDateTime);
    return formattedDate;
  }

  static String getDateYMMMD([DateTime? dt]) {
    var now = DateTime.now();
    var formatter = DateFormat.yMMMd();
    String formattedDate = formatter.format(dt ?? now);
    return formattedDate;
  }

  static String getCurrentTime([DateTime? dt]) {
    var now = DateTime.now();
    var formatter = DateFormat.Hm();
    String formattedDate = formatter.format(dt ?? now);
    return formattedDate;
  }

  static String getCurrentDays([DateTime? dt]) {
    var now = DateTime.now();
    var formatter = DateFormat.EEEE();
    String formattedDate = formatter.format(dt ?? now);
    return formattedDate;
  }

  static String getPreviousDate({required int days}) {
    var now = DateTime.now().subtract(Duration(days: days));
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static DateTime convertStringToDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }

  static String getDateFormatDDMMMYYYY(String date) {
    DateTime dateTime = convertStringToDate(date);
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static String getDateYYYYMMDD(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String getMonthViseDate(int lastMonth) {
    final date = DateTime.now();
    var lastMonthDate =
        DateTime(date.year, date.month - lastMonth, date.day).toString();
    var dateParse = DateTime.parse(lastMonthDate);
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateParse);
    return formattedDate;
  }

  static String getYearViseDate(int lastYear) {
    final date = DateTime.now();
    var lastMonthDate =
        DateTime(date.year - lastYear, date.month, date.day).toString();
    var dateParse = DateTime.parse(lastMonthDate);
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateParse);
    return formattedDate;
  }

  static String getHourMinSec(DateTime dateTime) {
    var formatter = DateFormat('HH:mm:ss');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static getDeviceType() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'other';
    }
  }

  static int getCurrentWeekDay() {
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    return todayDate.weekday;
  }

  static String getCurrency(String name) {
    //USD //PKR //INR //GBP //CAD
    Locale locale = Localizations.localeOf(Get.context!);
    var format = NumberFormat.simpleCurrency(
      locale: locale.toString(),
      name: name,
    );
    return format.currencySymbol;
  }

  static String covertNumber(int number, [String? symbol]) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol:
          symbol ??
          '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(number).toString();
  }
}
