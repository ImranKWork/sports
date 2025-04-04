import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';

class StCoins extends StatefulWidget {
  const StCoins({super.key});

  @override
  State<StCoins> createState() => _StCoinsState();
}

class _StCoinsState extends State<StCoins> {
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
      "color": Colors.red,
    },
    {
      "image": ImageAssets.img3,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red,
    },
    {
      "image": ImageAssets.img3,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red,
    },
    {
      "image": ImageAssets.img4,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red,
    },
    {
      "image": ImageAssets.img5,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red,
    },
    {
      "image": ImageAssets.img5,
      "date": "05-02-2025 | 12:45 PM",
      "title": "🎁 Redemption",
      "details": "Redeemed Exclusive Content",
      "coins": "-500 STCoins",
      "color": Colors.red,
    },
  ];
  String? selectedFilter;
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
          children: [
            Row(
              children: [
                SizedBox(width: Constant.size10),
                Text("STCoins Transactions", style: Styles.buttonTextStyle18),
                Spacer(),
                DropdownButtonHideUnderline(
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                            'Last Week',
                            'Last Month',
                            'Last 3 Months',
                            'Last 6 Months',
                            'Custom',
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

            /* Row(
              children: [
                SizedBox(width: Constant.size10),
                Text("STCoins Transactions", style: Styles.buttonTextStyle18),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(46),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Sort By",
                        style: Styles.textBlackHeader.copyWith(fontSize: 10),
                      ),
                      SizedBox(width: 5),

                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: ColorAssets.black,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),*/
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
          ],
        ),
      ),
    );
  }
}
