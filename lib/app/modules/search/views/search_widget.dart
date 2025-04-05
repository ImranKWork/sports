import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/search/views/filter_page.dart';
import 'package:sports_trending/app/modules/search/views/search_result.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
      {
        "image": ImageAssets.img4,
        "title": "Cristiano Ronaldo Goals",
        "details": "6.2k Views  | 2.4k Likes | 230 Comments",
      },
      {
        "image": ImageAssets.img5,
        "title": "Messi vs Mbappe Skills",
        "details": "6.2k Views  | 2.4k Likes | 230 Comments",
      },
    ];

    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                Container(
                  height: Get.height / 20,
                  width: Get.width / 1.4,
                  padding: EdgeInsets.symmetric(
                    vertical: Constant.size5,
                    horizontal: Constant.size5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constant.size30),
                    border: Border.all(color: ColorAssets.grey3),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Constant.size5),
                      SvgPicture.asset(
                        ImageAssets.search,
                        height: 23,
                        width: 23,
                        color: ColorAssets.white,
                      ),
                      SizedBox(width: Constant.size10),
                      Text(
                        "Search sports videos, players, events…",
                        style: Styles.textStyleWhiteMedium.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => FilterPage());
                  },
                  child: Image.asset("assets/images/filter.png", scale: 3),
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
            Text(
              "🔥 Trending & Suggested Searches",
              style: Styles.buttonTextStyle18,
            ),
            SizedBox(height: Constant.size15),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                final item = searchItems[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SearchResult());
                  },
                  child: Padding(
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
                  ),
                );
              },
            ),
            SizedBox(height: Constant.size15),

            Text("Recent Searches", style: Styles.buttonTextStyle18),
            SizedBox(height: Constant.size15),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchItem.length,
              itemBuilder: (context, index) {
                final item = searchItem[index];
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
          ],
        ),
      ),
    );
  }
}
