import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/wallet/views/wallet_page.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';

class UnlockPremiumVideo extends StatefulWidget {
  const UnlockPremiumVideo({super.key});

  @override
  State<UnlockPremiumVideo> createState() => _UnlockPremiumVideoState();
}

class _UnlockPremiumVideoState extends State<UnlockPremiumVideo> {
  int currentStep = 1;
  double progressValue = 0.9;
  final List<Map<String, dynamic>> videoList = [
    {
      "image": ImageAssets.coins3,
      "title": "View 50 Videos",
      "description": "Lorem ipsum sit amet consectetur elipscing",
      "progress": 0.99,
    },
    {
      "image": ImageAssets.coins4,
      "title": "Give 100 Likes and Unlock Video",
      "description": "Lorem ipsum sit amet consectetur elipscing",
      "progress": 0.23,
    },
    {
      "image": ImageAssets.coins5,
      "title": "Share 278 to your friends!!!",
      "description": "Lorem ipsum sit amet consectetur elipscing",
      "progress": 0.49,
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
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(width: Constant.size30),
                Text(
                  "Unlock Premium Videos",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
                Spacer(),
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
                      children: [
                        Image.asset(ImageAssets.star, scale: 3),
                        Text("250.0", style: Styles.textStyleWhiteMedium),
                        SizedBox(width: 2),
                      ],
                    ),
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
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorAssets.textColorSea,
                borderRadius: BorderRadius.circular(Constant.size8),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints.maxWidth;
                  double sectionWidth = totalWidth / 5; // updated to 6 sections

                  return Stack(
                    children: [
                      Positioned(
                        left:
                            sectionWidth * (currentStep - 1) +
                            sectionWidth / 2 -
                            40,
                        top: 0,
                        child: Column(
                          children: [
                            Text(
                              "You are\nhere",
                              style: Styles.textStyleBlackRegular,
                              textAlign: TextAlign.center,
                            ),
                            Image.asset(ImageAssets.arrow, scale: 2.8),
                            SizedBox(height: Constant.size5),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child:
                                      index < currentStep
                                          ? Image.asset(
                                            ImageAssets.coins1,
                                            scale: 2.5,
                                          )
                                          : Opacity(
                                            opacity: 0.3,
                                            child: Image.asset(
                                              ImageAssets.coins2,
                                              scale: 2.5,
                                            ),
                                          ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: List.generate(5, (index) {
                                return Expanded(
                                  child: Container(
                                    height: 10,
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    color:
                                        index < currentStep
                                            ? ColorAssets.themeColorOrange
                                            : Colors.grey.shade300,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  "Only 30 Mins Remaining",
                                  style: Styles.textStyleBlackRegular,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: Constant.size10),
                                Image.asset(ImageAssets.fire, scale: 3),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 20),
            Text("For Unlock This Videos", style: Styles.textStyleBlackMedium),
            SizedBox(height: 5),
            Text(
              "You have to unlock those milestones",
              style: Styles.textStyleWhite14,
            ),
            SizedBox(height: 10),
            ListView.builder(
              itemCount: videoList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = videoList[index];
                final progressValue = item["progress"] as double;

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorAssets.grey4,
                    border: Border.all(color: Color(0xffE5EBF0)),
                    borderRadius: BorderRadius.circular(Constant.size8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(item["image"], scale: 2.5),
                          SizedBox(width: Constant.size8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                style: Styles.textStyleBlackMedium,
                              ),
                              SizedBox(height: Constant.size5),
                              Text(
                                item["description"],
                                style: Styles.textStyleWhite14.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: Constant.size5),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
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
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                currentStep < 3
                    ? ColorAssets.grey5
                    : ColorAssets.themeColorOrange,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          onPressed:
              currentStep < 3
                  ? () {
                    setState(() {
                      if (currentStep < 3) currentStep++;
                    });
                  }
                  : null,
          child: Text(
            currentStep < 3 ? "Next Step" : "All Steps Completed",
            style: Styles.textStyleWhiteMedium,
          ),
        ),
      ),
    );
  }
}
