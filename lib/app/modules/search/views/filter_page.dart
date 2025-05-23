import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';
import '../controller/search_videos_controller.dart';

class FilterPage extends StatefulWidget {
  String searchkey = "";
  FilterPage(this.searchkey, {super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final SearchVideoController searchController = Get.find();
  final List<String> _sortOptions = ["Newest", "Most Viewed", "Most Liked"];
  final List<String> _dateRangeOptions = [
    "Last 24h",
    "7 Days",
    "30 Days",
    "All Time",
  ];
  //final List<String> _changePlatFormOptions = ["YouTube", "TikTok"];

  @override
  void initState() {
    super.initState();
  }

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
                  "Filters",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      searchController.selectedSort.value = '';
                      searchController.selectedDateRange.value = '';
                      searchController.selectedPlatForm.value = '';

                      searchController.fselectedSort.value = '';
                      searchController.fselectedDateRange.value = '';
                      searchController.fselectedPlatForm.value = '';
                      searchController.videoResults.clear();

                      searchController.fetchSearchVideos(
                        keyword: widget.searchkey,
                        page: 1,
                        limit: 100,
                        timeRange: "",
                        type: "",
                        sort: "",
                      );

                      Get.back();
                    });
                  },
                  child: Text("Clear", style: Styles.textMetalHeader),
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
            Text("Sort By", style: Styles.buttonTextStyle18),
            SizedBox(height: 10),
            Column(
              children:
                  _sortOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.selectedSort.value =
                                    searchController.selectedSort.value ==
                                            option
                                        ? ''
                                        : option;
                              });

                              if (option == "Newest") {
                                searchController.fselectedSort.value =
                                    "uploadDate";
                              } else if (option == "Most Viewed") {
                                searchController.fselectedSort.value =
                                    "totalViews";
                              } else {
                                searchController.fselectedSort.value =
                                    "totalLikes";
                              }
                            },
                            child: Image.asset(
                              searchController.selectedSort.value == option
                                  ? "assets/images/check.png"
                                  : "assets/images/uncheck.png",
                              width: 16,
                              height: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            option,
                            style: Styles.textBlackHeader.copyWith(
                              fontWeight: FontWeight.w400,
                              color:
                                  searchController.selectedSort.value == option
                                      ? ColorAssets.black
                                      : Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 15),
            Text("Date Range", style: Styles.buttonTextStyle18),
            SizedBox(height: 5),
            Column(
              children:
                  _dateRangeOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.selectedDateRange.value =
                                    searchController.selectedDateRange.value ==
                                            option
                                        ? ''
                                        : option;
                              });

                              if (option == "Last 24h") {
                                searchController.fselectedDateRange.value =
                                    "last24Hours";
                              } else if (option == "7 Days") {
                                searchController.fselectedDateRange.value =
                                    "last7Days";
                              } else if (option == "30 Days") {
                                searchController.fselectedDateRange.value =
                                    "last30Days";
                              } else {
                                searchController.fselectedDateRange.value =
                                    "allTime";
                              }
                            },
                            child: Image.asset(
                              searchController.selectedDateRange.value == option
                                  ? "assets/images/check.png"
                                  : "assets/images/uncheck.png",
                              width: 16,
                              height: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            option,
                            style: Styles.textBlackHeader.copyWith(
                              fontWeight: FontWeight.w400,
                              color:
                                  searchController.selectedDateRange.value ==
                                          option
                                      ? ColorAssets.black
                                      : Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
            // SizedBox(height: 15),
            // Text("Platform", style: Styles.buttonTextStyle18),
            // SizedBox(height: 5),
            // Column(
            //   children:
            //       _changePlatFormOptions.map((option) {
            //         return Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 8.0),
            //           child: Row(
            //             children: [
            //               GestureDetector(
            //                 onTap: () {
            //                   setState(() {
            //                     searchController.selectedPlatForm.value =
            //                         searchController.selectedPlatForm.value ==
            //                                 option
            //                             ? ''
            //                             : option;
            //                   });

            //                   if (option == "YouTube") {
            //                     searchController.fselectedPlatForm.value =
            //                         "youtube";
            //                   } else {
            //                     searchController.fselectedPlatForm.value =
            //                         "tik-tok";
            //                   }
            //                 },
            //                 child: Image.asset(
            //                   searchController.selectedPlatForm.value == option
            //                       ? "assets/images/check.png"
            //                       : "assets/images/uncheck.png",
            //                   width: 16,
            //                   height: 16,
            //                 ),
            //               ),
            //               SizedBox(width: 8),
            //               Text(
            //                 option,
            //                 style: Styles.textBlackHeader.copyWith(
            //                   fontWeight: FontWeight.w400,
            //                   color:
            //                       searchController.selectedPlatForm.value ==
            //                               option
            //                           ? ColorAssets.black
            //                           : Colors.blueGrey,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       }).toList(),
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CommonButton(
          label: 'Apply Filters',
          onClick: () {
            if (searchController.selectedSort.value.isNotEmpty ||
                searchController.selectedDateRange.value.isNotEmpty ||
                searchController.selectedPlatForm.value.isNotEmpty) {
              searchController.fetchSearchVideos(
                keyword: widget.searchkey,
                page: 1,
                limit: 100,
                timeRange: searchController.fselectedDateRange.value,
                type: searchController.fselectedPlatForm.value,
                sort: searchController.fselectedSort.value,
              );
              Get.back();
            } else {
              Get.snackbar('Error', 'Please select all filters.');
            }
          },
        ),
      ),
    );
  }
}
