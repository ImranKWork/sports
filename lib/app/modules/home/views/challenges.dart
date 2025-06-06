import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/profile/controllers/profile_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../challenges_details/views/challenges_details.dart';
import '../../wallet/views/wallet_page.dart';

class ChallengesWidget extends StatefulWidget {
  const ChallengesWidget({super.key});

  @override
  State<ChallengesWidget> createState() => _ChallengesWidgetState();
}

class _ChallengesWidgetState extends State<ChallengesWidget> {
  final List<Map<String, String>> staticCategories = [
    {'name': 'All'},
    {'name': 'Daily'},
    {'name': 'Weekly'},
    {'name': 'Monthly'},
    {'name': 'Event Based'},
    {'name': 'Completed'},
  ];
  String selectedCategory = 'All';
  double progressValue = 0.4;
  String? selectedFilter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(ProfileController()).getProfileById();
  }

  @override
  Widget build(BuildContext context) {
    final coins = SharedPref.getString(PrefsKey.userstcoin);

    return Scaffold(
      backgroundColor: ColorAssets.white,

      appBar: CommonAppBar(
        height: 180,
        child: Column(
          children: [
            SizedBox(height: Constant.size50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(ImageAssets.headerLogo, scale: 3),
                GestureDetector(
                  onTap: () {
                    Get.to(() => WalletPage());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Constant.size5,
                      horizontal: Constant.size5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constant.size30),
                      color: ColorAssets.lightPurple,
                    ),
                    child: Row(
                      spacing: Constant.size5,

                      children: [
                        Image.asset(ImageAssets.star, scale: 3),
                        Text(coins, style: Styles.textStyleWhiteMedium),
                        SizedBox(width: 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Constant.size20),

            _buildCategoryList(),
            SizedBox(height: Constant.size5),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: Constant.size10),
                Text("Challenges", style: Styles.buttonTextStyle18),
                Spacer(),
                DropdownButtonHideUnderline(
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(46),
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        "Sort By",
                        style: Styles.textBlackHeader.copyWith(fontSize: 10),
                      ),
                      value: selectedFilter,
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: ColorAssets.black,
                        size: 15,
                      ),
                      style: Styles.textBlackHeader.copyWith(fontSize: 10),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      items:
                          [
                            'All challenges',
                            'New Challenges',
                            'Joined challenges',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFilter = newValue;
                        });
                        // Handle filter logic
                      },
                    ),
                  ),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size10),

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
            SizedBox(height: Constant.size10),
            Stack(
              alignment: Alignment.center,
              children: [
                // Background Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.running),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 260,
                ),

                // Overlay Image
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(
                      0.5,
                    ), // Black overlay with transparency
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
                            SizedBox(
                              height: 5,
                            ), // Space between number and unit
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
                        "🔥 View 100 Videos",
                        style: Styles.textStyleWhiteSemiBold.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "🎁 Earn 200 STCoins in 4 Days\n13 Hours!",
                        style: Styles.textStyleWhiteSemiBold.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: ColorAssets.textColorSea,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorAssets.themeColorOrange,
                        ),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${(progressValue * 100).toInt()}% Completed",
                          style: Styles.textStyleWhiteRegular.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Constant.size10),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.playing),
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
                        "🔥 Share 20 More Videos",
                        style: Styles.textStyleWhiteSemiBold.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "🎁 23 Days to Win 500 STCoins +\nExclusive Video Access!",
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
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: staticCategories.length,
        itemBuilder: (context, index) {
          final category = staticCategories[index]['name']!;
          bool isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? ColorAssets.themeColorOrange
                        : ColorAssets.grey1,
                borderRadius: BorderRadius.circular(46),
              ),
              child: Center(
                child: Text(
                  category,
                  style:
                      isSelected
                          ? Styles.textStyleWhiteMedium
                          : Styles.textStyleWhite14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
