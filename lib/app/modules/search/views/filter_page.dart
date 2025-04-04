import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? _selectedSort;
  String? _selectedDateRange;
  String? _selectedPlatForm;

  final List<String> _sortOptions = ["Newest", "Most Viewed", "Most Liked"];
  final List<String> _dateRangeOptions = [
    "Last 24h",
    "7 Days",
    "30 Days",
    "All Time",
  ];
  final List<String> _changePlatFormOptions = [
    "YouTube",
    "TikTok",
    "Instagram",
    "Twitter",
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
                  "Filters",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSort = null;
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
                                _selectedSort =
                                    _selectedSort == option ? null : option;
                              });
                            },
                            child: Image.asset(
                              _selectedSort == option
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
                                  _selectedSort == option
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
                                _selectedDateRange =
                                    _selectedDateRange == option
                                        ? null
                                        : option;
                              });
                            },
                            child: Image.asset(
                              _selectedDateRange == option
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
                                  _selectedSort == option
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

            Text("Platform", style: Styles.buttonTextStyle18),
            SizedBox(height: 5),
            Column(
              children:
                  _changePlatFormOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPlatForm =
                                    _selectedPlatForm == option ? null : option;
                              });
                            },
                            child: Image.asset(
                              _selectedPlatForm == option
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
                                  _selectedPlatForm == option
                                      ? ColorAssets.black
                                      : Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
