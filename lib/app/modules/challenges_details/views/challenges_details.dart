import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';

class ChallengesDetails extends StatefulWidget {
  const ChallengesDetails({super.key});

  @override
  State<ChallengesDetails> createState() => _ChallengesDetailsState();
}

class _ChallengesDetailsState extends State<ChallengesDetails> {
  double progressValue = 0.4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      // Background Image
                      Image.asset(
                        "assets/images/playing_football.jpg",
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // Overlay Image (Full Cover)
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Back Button & Title
                Positioned(
                  top: 60,
                  left: 16,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          "assets/images/back.png",
                          scale: 2.2,
                        ),
                      ),
                      SizedBox(width: Constant.size25),
                      Text(
                        "Challenge Details",
                        style: Styles.textStyleBlackMedium.copyWith(
                          color: ColorAssets.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Timer Display
                Positioned.fill(
                  top: 100,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTimeBlock("48", "Hours"),
                        buildColon(),
                        buildTimeBlock("34", "Minutes"),
                        buildColon(),
                        buildTimeBlock("45", "Seconds"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Space below Stack
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        "🔥 Share 10 Videos Today &\nEarn 240 ST Coins",
                        style: Styles.textStyleBlackMedium,
                      ),
                      Spacer(),
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: ColorAssets.themeColorBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("27", style: Styles.textMetalHeader18),
                            Text("Jan", style: Styles.textStyleWhiteRegular),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Progress",
                    textAlign: TextAlign.center,
                    style: Styles.textBlackHeader,
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

                  Text(
                    "${(progressValue * 100).toInt()}% Completed",
                    style: Styles.textStyleBlackMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: Constant.size20),

                  Text(
                    "Description",
                    textAlign: TextAlign.center,
                    style: Styles.textBlackHeader,
                  ),
                  SizedBox(height: Constant.size10),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    textAlign: TextAlign.start,
                    style: Styles.textStyleWhite14.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: Constant.size20),

                  Text(
                    "Rules & Regulations",
                    textAlign: TextAlign.center,
                    style: Styles.textBlackHeader,
                  ),
                  SizedBox(height: Constant.size10),
                  Row(
                    children: [
                      Icon(Icons.circle, color: ColorAssets.black, size: 5),
                      SizedBox(width: Constant.size8),
                      Text(
                        "Likes Needed:",
                        style: Styles.textStyleBlackRegular,
                      ),
                      SizedBox(width: Constant.size4),

                      Text(
                        "“Like 10 sports videos”",
                        style: Styles.textStyleBlackRegular.copyWith(
                          color: ColorAssets.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constant.size10),
                  Row(
                    children: [
                      Icon(Icons.circle, color: ColorAssets.black, size: 5),
                      SizedBox(width: Constant.size8),
                      Text(
                        "Comments Required:",
                        style: Styles.textStyleBlackRegular,
                      ),
                      SizedBox(width: Constant.size4),

                      Text(
                        "“Comment on 5 football clips”",
                        style: Styles.textStyleBlackRegular.copyWith(
                          color: ColorAssets.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constant.size10),
                  Row(
                    children: [
                      Icon(Icons.circle, color: ColorAssets.black, size: 5),
                      SizedBox(width: Constant.size8),
                      Text("Shares Goal:", style: Styles.textStyleBlackRegular),
                      SizedBox(width: Constant.size4),

                      Text(
                        "“Share 3 trending videos”",
                        style: Styles.textStyleBlackRegular.copyWith(
                          color: ColorAssets.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constant.size10),
                  Row(
                    children: [
                      Icon(Icons.circle, color: ColorAssets.black, size: 5),
                      SizedBox(width: Constant.size8),
                      Text("Watch Time:", style: Styles.textStyleBlackRegular),
                      SizedBox(width: Constant.size4),

                      Text(
                        "“Watch 30 minutes of content”",
                        style: Styles.textStyleBlackRegular.copyWith(
                          color: ColorAssets.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constant.size15),
                  Row(
                    children: [
                      SizedBox(width: Constant.size5),

                      Text("Leaderboards", style: Styles.buttonTextStyle18),
                      Spacer(),
                      Text("View All", style: Styles.textBlueHeader),
                      SizedBox(width: Constant.size5),
                    ],
                  ),
                  Stack(
                    clipBehavior: Clip.none, // Allow overflow
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
                            child: Text(
                              "1",
                              style: Styles.textStyleWhiteMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constant.size15),
                  Center(
                    child: Text(
                      "Winner",
                      style: Styles.textStyleWhite16,
                      textAlign: TextAlign.center,
                    ),
                  ),

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
                    itemCount: 4, // Number of items
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                        ), // Space between items
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              index == 2
                                  ? ColorAssets.textColorSea
                                  : ColorAssets.grey2, // Change 3rd item color
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${index + 2}",
                              style: Styles.textStyleBlackMedium,
                            ),
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
                  Row(
                    children: [
                      SizedBox(width: Constant.size5),

                      Text(
                        "Related Challenges",
                        style: Styles.buttonTextStyle18,
                      ),
                      Spacer(),
                      Text("View All", style: Styles.textBlueHeader),
                      SizedBox(width: Constant.size5),
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
                            image: AssetImage(
                              "assets/images/playing_football.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 280,
                      ),

                      // Overlay Image
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(
                            0.5,
                          ), // Black overlay with transparency
                        ),
                      ),

                      // Top Right Container with Timer Text
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                ColorAssets
                                    .white, // Semi-transparent background
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
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

                      // Content
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
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Constant.size12),
        child: CommonButton(
          label: "View Results",
          onClick: () {
            //  Get.to(() => EditProfileView());
          },
        ),
      ),
    );
  }

  // Function to create Time Blocks (Column)
  Widget buildTimeBlock(String value, String unit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Styles.textStyleBlackMedium.copyWith(
            color: ColorAssets.white,
            fontSize: 32,
          ),
        ),
        SizedBox(height: 5), // Space between number and unit
        Text(
          unit,
          style: Styles.textStyleBlackMedium.copyWith(
            color: ColorAssets.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget buildColon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        ":",
        style: Styles.textStyleBlackMedium.copyWith(
          color: ColorAssets.white,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
