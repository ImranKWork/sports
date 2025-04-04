import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/utils/screen_util.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../widgets/common_header.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int selectedIndex = 0;
  int selectedIndexs = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        height: 120,
        child: Column(
          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: Constant.size50),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(width: Constant.size50),
                Text(
                  "Leaderboard",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),

            Spacer(),

            //   SizedBox(height: Constant.size5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabItem(0, "Videos Ranking"),
                SizedBox(width: 16),
                _buildTabItem(1, "User Ranking"),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constant.size15),

            Text(
              selectedIndex == 0
                  ? "Video Ranking Leaderboard"
                  : "User Ranking Leaderboard",
              style: Styles.buttonTextStyle18,
            ),
            SizedBox(height: Constant.size15),
            Container(
              height: 50,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndexs = index;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 109,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 29,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selectedIndexs == index
                                ? ColorAssets.themeColorOrange
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        ['Global', 'Regional', 'Local'][index],
                        style:
                            selectedIndexs == index
                                ? Styles
                                    .textMetalHeader // Selected Text Style
                                : Styles.textStyleWhite14,
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: Constant.size15),

            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/crown.png",
                        height: 30,
                      ), // Crown Image
                      SizedBox(height: Constant.size5),

                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorAssets.themeColorOrange,
                            width: 3,
                          ), // Border color
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/icons/user.jpg",
                            height: 80, // Adjust size
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: -7, // Shift badge slightly downward
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorAssets.themeColorOrange,
                    ),
                    child: Center(
                      child: Text("1", style: Styles.textStyleWhiteMedium),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Constant.size15),

            Center(child: Text("Winner", style: Styles.textStyleWhite16)),

            Center(
              child: Text(
                "Cristofer Vetrovs",
                style: Styles.textStyleBlackMedium,
              ),
            ),
            SizedBox(height: Constant.size5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                SizedBox(width: Constant.size20),

                Column(
                  children: [
                    Image.asset(
                      "assets/images/chat2.png",
                      height: 35,
                      width: 35,
                    ),
                    SizedBox(height: Constant.size5),

                    Text("14 K", style: Styles.textBlackHeader),
                  ],
                ),
              ],
            ),
            SizedBox(height: Constant.size15),

            ListView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // If inside another scrollable widget
              itemCount: 5, // Number of items
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                  ), // Space between items
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    color:
                        index == 2
                            ? ColorAssets.textColorSea
                            : ColorAssets.grey2, // Change 3rd item color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text("${index + 2}", style: Styles.textStyleBlackMedium),
                      SizedBox(width: Constant.size8),

                      Image.asset(
                        "assets/images/user2.png",
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: Constant.size8),
                      Text(
                        index == 2 ? "You" : "Marsha Fisher",
                        style: Styles.textStyleBlackMedium,
                      ),
                      Spacer(),
                      Text(
                        "${(index + 1) * 10} pts",
                        style: Styles.textStyleBlackMedium,
                      ),
                      SizedBox(width: Constant.size8),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: Constant.size15),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Styles.textMetalHeader.copyWith(
                color: selectedIndex == index ? Colors.white : ColorAssets.grey,
              ),
            ),
            SizedBox(height: 4),
            if (selectedIndex == index)
              Container(
                width: 133,
                height: 4,
                decoration: BoxDecoration(
                  color: ColorAssets.white,
                  borderRadius: BorderRadius.circular(4), // ✅ Border radius
                ),
              ),
          ],
        ),
      ),
    );
  }
}
