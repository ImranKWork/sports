import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../challenges_details/views/challenges_details.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final List<Map<String, String>> searchItems = [
    {
      "image": ImageAssets.img1,
      "title": "🏀 NBA Finals Highlights",
      "details": "6.2k Views  | 2.4k Likes | 230 Comments",
    },
    {
      "image": ImageAssets.img2,
      "title": "⚽ Top World Cup Goals",
      "details": "6.2k Views  | 2.4k Likes | 230 Comments",
    },
    {
      "image": ImageAssets.img3,
      "title": "🎾 Wimbledon 2024 Best Moments",
      "details": "6.2k Views  | 2.4k Likes | 230 Comments",
    },
  ];
  final List<Map<String, String>> searchItem = [
    {"image": ImageAssets.img4, "title": "Football"},
    {"image": ImageAssets.img5, "title": "Tennis"},
    {"image": ImageAssets.img5, "title": "Basketball"},
  ];

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
                  "Search Result",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📺 Videos", style: Styles.buttonTextStyle18),
            SizedBox(height: Constant.size15),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                final item = searchItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Image.asset(item["image"]!, width: 80, height: 85),
                      SizedBox(width: Constant.size10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: Styles.textMetalHeader.copyWith(
                              color: ColorAssets.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item["details"]!,
                            style: Styles.textStyleWhite16.copyWith(
                              color: ColorAssets.darkGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: Constant.size15),

            Text("🏷️ Categories", style: Styles.buttonTextStyle18),
            SizedBox(height: Constant.size15),
            SizedBox(
              height: 157,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: searchItem.length,
                itemBuilder: (context, index) {
                  final item = searchItem[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Background Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item["image"]!,
                            width: 146,
                            height: 157,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Overlay Image on top
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/overlay.png', // Replace with your actual path
                            width: 146,
                            height: 157,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Bottom Centered Text
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Text(
                            item["title"]!,
                            style: Styles.textMetalHeader.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: Constant.size15),

            Text("🎯 Challenges", style: Styles.buttonTextStyle18),

            SizedBox(height: Constant.size15),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage("assets/images/playing_football.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 280,
                ),

                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorAssets.white, // Semi-transparent background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "48",
                              style: Styles.textStyleBlackMedium.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Hours",
                              style: Styles.textStyleBlackMedium.copyWith(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            ":",
                            style: Styles.textStyleBlackMedium.copyWith(
                              fontSize: 13.9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "34",
                              style: Styles.textStyleBlackMedium.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Minutes",
                              style: Styles.textStyleBlackMedium.copyWith(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Constant.size90),
                      Text(
                        "🔥 Like 10 Videos Today!",
                        style: Styles.textStyleWhiteSemiBold.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "🎁 Earn 50 STCoins + Unlock an Exclusive\nVideo",
                        style: Styles.textStyleWhiteSemiBold.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => ChallengesDetails());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          "Join Challenge",
                          style: Styles.textStyleWhiteSemiBold.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Constant.size15),
          ],
        ),
      ),
    );
  }
}
