import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/widgets/common_button.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../wallet/views/wallet_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constant.size18),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: ColorAssets.pink),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Image.asset(ImageAssets.ab, scale: 3),
                  SizedBox(width: Constant.size12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ashwin Bose has announced the\nresults of the FIFA Soccer 2025\nLeague.",
                        style: Styles.textStyleWhite14.copyWith(
                          color: ColorAssets.black,
                          height: 1.5,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Constant.size20),

                      CommonButton(label: "View Leaderboard", onClick: () {}),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "2m",
                        style: Styles.textStyleWhite14.copyWith(
                          color: ColorAssets.black,
                          letterSpacing: 0.5,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: Constant.size10),

                      Image.asset(ImageAssets.dots, scale: 3),
                    ],
                  ),
                  SizedBox(width: Constant.size10),
                ],
              ),
            ),
            SizedBox(height: Constant.size18),

            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(ImageAssets.img6, height: 50, width: 50),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                style: TextStyle(height: 2, letterSpacing: 0.5),
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Patrick ",
                                      style: Styles.textStyleBlackSemiBold
                                          .copyWith(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text:
                                          "has created a new challenge in golf! ",
                                      style: Styles.textStyleWhite14.copyWith(
                                        color: ColorAssets.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Join now ",
                                      style: Styles.textStyleWhite14.copyWith(
                                        color: ColorAssets.themeColorOrange,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "to participate and earn more rewards.",
                                      style: Styles.textStyleWhite14.copyWith(
                                        color: ColorAssets.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 48,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffE2E8F0),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "“Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry!”",
                                    style: Styles.textStyleWhite14.copyWith(
                                      height: 1.8,
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Color(0xffE2E8F0)),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
