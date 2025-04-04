import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:sports_trending/source/image_assets.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';

class NotificationPref extends StatefulWidget {
  const NotificationPref({super.key});

  @override
  State<NotificationPref> createState() => _NotificationPrefState();
}

class _NotificationPrefState extends State<NotificationPref> {
  bool isPushNotificationOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(width: Constant.size30),
                Text(
                  "Notification Preferences",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Constant.size15),

            Image.asset(ImageAssets.notifications, scale: 3),
            SizedBox(height: Constant.size15),

            Text(
              "Turn on notification to get the most out of\nthe perks & benefits of our app",
              style: Styles.textStyleBlackMedium,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Constant.size20),

            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              style: Styles.textStyleWhite14.copyWith(fontSize: 12),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Constant.size40),
            Row(
              children: [
                Text(
                  "Push Notification",
                  style: Styles.textStyleWhite14.copyWith(
                    color: ColorAssets.black,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                FlutterSwitch(
                  value: isPushNotificationOn,
                  onToggle: (val) {
                    setState(() {
                      isPushNotificationOn = val;
                    });
                  },
                  activeColor: ColorAssets.themeColorOrange,
                  inactiveColor: ColorAssets.grey,
                  toggleColor:
                      isPushNotificationOn ? Colors.white : ColorAssets.grey3,
                  height: 22,
                  width: 45,
                  toggleSize: 15,
                ),
              ],
            ),
            SizedBox(height: Constant.size25),
            Row(
              children: [
                Text(
                  "Email Notification",
                  style: Styles.textStyleWhite14.copyWith(
                    color: ColorAssets.black,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                FlutterSwitch(
                  value: isPushNotificationOn,
                  onToggle: (val) {
                    setState(() {
                      isPushNotificationOn = val;
                    });
                  },
                  activeColor: ColorAssets.themeColorOrange,
                  inactiveColor: ColorAssets.grey,
                  toggleColor:
                      isPushNotificationOn ? Colors.white : ColorAssets.grey3,
                  height: 22,
                  width: 45,
                  toggleSize: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
