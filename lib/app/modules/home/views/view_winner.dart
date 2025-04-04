import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';

class ViewWinner extends StatefulWidget {
  const ViewWinner({super.key});

  @override
  State<ViewWinner> createState() => _ViewWinnerState();
}

class _ViewWinnerState extends State<ViewWinner> {
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
                  "View Winner",
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
              itemCount: 8, // Number of items
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
}
