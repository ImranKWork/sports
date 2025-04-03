import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';

class PremiumVideos extends StatefulWidget {
  const PremiumVideos({super.key});

  @override
  State<PremiumVideos> createState() => _PremiumVideosState();
}

class _PremiumVideosState extends State<PremiumVideos> {
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
                SizedBox(width: Constant.size50),
                Text(
                  "Premium Videos",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: 10, // Adjust based on your data
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: _showVideoDialog,
                child: Stack(
                  children: [
                    /// 🎯 Background Image with Overlay
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/playing_football.jpg",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black54, // Semi-transparent black overlay
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    /// 🎯 Rating Container (Top-Left)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Constant.size5,
                          horizontal: Constant.size5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constant.size30),
                          color: Colors.white24,
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Minimum required space
                          children: [
                            Image.asset(ImageAssets.star, scale: 3),
                            SizedBox(width: 3),
                            Text(
                              "250.0",
                              style: Styles.textStyleBlackSemiBold.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// 🎯 Lock Image (Centered)
                    Positioned.fill(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/lock.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            Text("250.0", style: Styles.textMetalHeader),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 🎯 Title, Tags & Icons Row
              Row(
                children: [
                  SizedBox(width: Constant.size10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Constant.size10),
                      Text(
                        "FIFA Behind-the-Scenes",
                        style: Styles.textBlackHeader.copyWith(fontSize: 22),
                      ),
                      SizedBox(height: Constant.size5),
                      Text(
                        "#NBA #UCL #WorldCup",
                        style: Styles.textStyleBlackRegular.copyWith(
                          color: ColorAssets.darkGrey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/like2.png",
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(height: Constant.size5),
                      Text("124 K", style: Styles.textBlackHeader),
                    ],
                  ),
                  SizedBox(width: Constant.size10),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/chat2.png",
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(height: Constant.size5),
                      Text("124 K", style: Styles.textBlackHeader),
                    ],
                  ),
                  SizedBox(width: Constant.size15),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/share.png",
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(height: Constant.size5),
                      Text("124 K", style: Styles.textBlackHeader),
                    ],
                  ),
                  SizedBox(width: Constant.size10),
                ],
              ),
              SizedBox(height: Constant.size15),
            ],
          );
        },
      ),
    );
  }

  void _showVideoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: ColorAssets.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ImageAssets.balance, scale: 3),
              SizedBox(height: 5),

              Text("Balance low", style: Styles.textStyleBlackMedium),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min, // Minimum required space
                children: [
                  Image.asset(ImageAssets.star, scale: 3),
                  SizedBox(width: 3),
                  Text(
                    "20",
                    style: Styles.textStyleBlackNormal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Constant.size10),

              Text(
                "For unlimited of joy for watching the shorties! You have to use ST Coins or join challenges",
                style: Styles.textStyleWhite14.copyWith(fontSize: 12),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Constant.size20),
              Padding(
                padding: const EdgeInsets.only(left: 38.0, right: 38),
                child: CommonButton(
                  label: 'Unlock Now',
                  onClick: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
