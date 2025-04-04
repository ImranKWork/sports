import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/challenges_details/views/challenges_details.dart';
import 'package:sports_trending/app/modules/wallet/views/st_coins.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';

import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final List<Map<String, dynamic>> searchItems = [
    {
      "image": ImageAssets.img1,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🏆 Challenge Reward",
      "details": "Completed ‘Watch 10 Videos’ Challenge",
      "coins": "+100 STCoins",
      "color": const Color(0xff0F9849),
    },
    {
      "image": ImageAssets.img2,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red, // ✅ RED
    },
    {
      "image": ImageAssets.img3,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red, // ✅ RED
    },
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
                SizedBox(width: Constant.size10),

                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(width: Constant.size30),
                Text(
                  "Wallet",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
                Spacer(),
                Image.asset(ImageAssets.question, scale: 3),
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
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorAssets.pink,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Image.asset(ImageAssets.wallet, scale: 2.8),
                      SizedBox(width: Constant.size10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Total STCoins Balance",
                            style: Styles.textBlackHeader.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "2,343 (+50)",
                            style: Styles.textBlackHeader.copyWith(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Constant.size20),
                  CommonButton(label: 'Earn More STCoins', onClick: () {}),
                ],
              ),
            ),
            SizedBox(height: Constant.size15),
            Row(
              children: [
                Text("STCoins Transactions", style: Styles.buttonTextStyle18),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => StCoins());
                  },
                  child: Text("View All", style: Styles.textBlueHeader),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size10),
            Text("Today", style: Styles.textStyleBlackMedium),
            SizedBox(height: Constant.size10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                final item = searchItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image on the left
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item["image"],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: Constant.size10),

                      // Middle content (date, title, details)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["date"],
                              style: Styles.textStyleWhite14.copyWith(
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item["title"],
                              style: Styles.textMetalHeader.copyWith(
                                color: ColorAssets.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item["details"],
                              style: Styles.textStyleWhite14.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          item["coins"],
                          style: Styles.textBlackHeader.copyWith(
                            color: item["color"],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: Constant.size10),
            Row(
              children: [
                Text("Earn ST Coins", style: Styles.buttonTextStyle18),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text("View All", style: Styles.textBlueHeader),
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
                    borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
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
            Row(
              children: [
                Text("Redeem Rewards", style: Styles.buttonTextStyle18),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text("View All", style: Styles.textBlueHeader),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size10),
            SizedBox(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              // _showVideoDialog();
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.37),
                                  child: Image.asset(
                                    "assets/images/playing_football.jpg",
                                    width: Get.width / 1.2,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 220,
                                  width: Get.width / 1.2,
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(7.37),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Constant.size5,
                                      horizontal: Constant.size5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Constant.size30,
                                      ),
                                      color: Colors.white24,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(ImageAssets.star, scale: 3),
                                        SizedBox(width: 3),
                                        Text(
                                          "250.0",
                                          style: Styles.textStyleBlackSemiBold
                                              .copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/lock.png",
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          "250.0",
                                          style: Styles.textMetalHeader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "FIFA Behind-the-Scenes",
                          style: Styles.textBlackHeader.copyWith(fontSize: 14),
                        ),
                        SizedBox(height: Constant.size5),
                        Text(
                          "#NBA #UCL #WorldCup",
                          style: Styles.textStyleBlackRegular.copyWith(
                            color: ColorAssets.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
