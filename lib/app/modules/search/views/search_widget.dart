import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_trending/app/modules/search/views/filter_page.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../controller/search_videos_controller.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchVideoController searchVideoController = Get.put(
    SearchVideoController(),
  );
  String formatNumber(dynamic number) {
    if (number == null) return '0';

    final num n = num.tryParse(number.toString()) ?? 0;

    if (n >= 1e9) return '${(n / 1e9).toStringAsFixed(1)}B';
    if (n >= 1e6) return '${(n / 1e6).toStringAsFixed(1)}M';
    if (n >= 1e3) return '${(n / 1e3).toStringAsFixed(1)}K';
    return n.toString();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   searchVideoController.fetchSearchVideos(keyword: "", page: 1, limit: 10);
  // }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: Constant.size10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Constant.size30),
                    border: Border.all(color: ColorAssets.grey3),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.search,
                        height: 20,
                        width: 20,
                        color: ColorAssets.white,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (keyword) {
                            searchVideoController.fetchSearchVideos(
                              keyword: keyword,
                              page: 1,
                              limit: 100,
                              timeRange: '',
                              type: '',
                              sort: '',
                            );
                          },
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorAssets.white,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "Search sports videos, players, events…",

                            hintStyle: Styles.textStyleWhiteMedium.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
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
        child: Obx(() {
          if (searchVideoController.isLoading.value) {
            return ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(width: Constant.size10),
                        // Wrap this Column with Expanded to avoid overflow
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity, // auto takes max space
                                height: 15,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: Get.width / 2.5,
                                height: 12,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (searchVideoController.videoResults.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 280),
                child: Text(
                  "No videos found",
                  style: Styles.buttonTextStyle18.copyWith(
                    color: ColorAssets.darkGrey,
                  ),
                ),
              ),
            );
          } else {
            return Column(
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
                  itemCount: searchVideoController.videoResults.length,
                  itemBuilder: (context, index) {
                    final video = searchVideoController.videoResults[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                video['thumbnailUrl'],
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: Constant.size10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width / 1.7,
                                  child: Text(
                                    video['title'],
                                    style: Styles.textMetalHeader.copyWith(
                                      color: ColorAssets.black,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${formatNumber(video['sourceViews'])}  Views  |  ${formatNumber(video['sourceLikes'])}  Likes  |  ${formatNumber(video['sourceComments'])}  Comments",
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
              ],
            );
          }
        }),
      ),
    );
  }
}
