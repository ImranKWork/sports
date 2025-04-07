import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sports_trending/source/image_assets.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../../../widgets/common_svg_images.dart';

class ReferYourFriends extends StatefulWidget {
  const ReferYourFriends({super.key});

  @override
  State<ReferYourFriends> createState() => _ReferYourFriendsState();
}

class _ReferYourFriendsState extends State<ReferYourFriends> {
  final TextEditingController _inviteLinkController = TextEditingController(
    text: "https://sportstrending.com/invite/ih/ukjs21...",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        height: 145,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 50, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(height: Constant.size12),
                Text(
                  "Refer your friends\n& Earn 500 ST Coins",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constant.size10),
            Image.asset(ImageAssets.refer2),
            Center(
              child: Text(
                "Refer friends and earn 15% of their\nSports Trending Coins",
                style: Styles.buttonTextStyle18.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Constant.size10),

            RichText(
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Styles.textStyleWhite14,
                children: [
                  const TextSpan(
                    text:
                        "Know someone who’s curious about challenges? Refer them to Sports Trending and earn 15% of all fees generated from new users you refer. By sending the link, you agree to our ",
                    style: TextStyle(height: 1.5),
                  ),

                  TextSpan(
                    text: "terms.",
                    style: Styles.textStyleWhite14.copyWith(
                      color: ColorAssets.themeColorOrange,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: Constant.size20),
            Text(
              "Share Link",
              style: Styles.textStyleBlackNormal.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: Constant.size20),

            TextFormField(
              textInputAction: TextInputAction.done,
              style: Styles.textStyleBlackMedium,
              readOnly: true,
              controller: _inviteLinkController,
              decoration: InputDecoration(
                hintText: "https://sportstrending.com/invite/ih/ukjs21...",
                hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 12),
                contentPadding: const EdgeInsets.only(right: 14, left: 8),

                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: _inviteLinkController.text),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Link copied to clipboard')),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 4, bottom: 4, top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: ColorAssets.themeColorOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Copy', style: Styles.textStyleWhiteRegular),
                    ),
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorAssets.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(Constant.size8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(Constant.size8),
                ),
              ),
              validator:
                  (value) =>
                      value!.isEmpty ? "Please enter old password" : null,
            ),
            SizedBox(height: Constant.size20),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xffD6D6D6),
                    thickness: 1,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "Or share with",
                  style: Styles.textStyleBlackRegular.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xffD6D6D6),
                    thickness: 1,
                    indent: 10,
                  ),
                ),
              ],
            ),
            SizedBox(height: Constant.size20),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialLoginButton("assets/images/youtube.svg", () {
                    //   controller.youTubeLogin();
                  }),
                  socialLoginButton("assets/images/facebook.svg", () {
                    //   controller.facebookLogin();
                  }),
                  socialLoginButton("assets/images/instagram.svg", () {}),
                  socialLoginButton("assets/images/twitter.svg", () {
                    //  controller.signInWithTwitter();
                  }),

                  socialLoginButton("assets/images/apple.svg", () {
                    // signInWithApple();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget socialLoginButton(String assetPath, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: GestureDetector(
      onTap: onTap,
      child: CommonSvgImages(image: assetPath),
    ),
  );
}
