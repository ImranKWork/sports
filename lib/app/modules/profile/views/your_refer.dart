import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/utils/api_utils.dart';
import 'package:sports_trending/utils/app_utils.dart';

import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';

class YourRefer extends StatefulWidget {
  String id = "";
  YourRefer(this.id, {super.key});

  @override
  State<YourRefer> createState() => _YourReferState();
}

class _YourReferState extends State<YourRefer> {
  var detailsReward;
  bool isLoading = true;

  Future<void> detailsrewardsapi() async {
    final url = Uri.parse(
      'https://urgd9n1ccg.execute-api.us-east-1.amazonaws.com/v1/referral/track-milestone/${widget.id}',
    );
    String? token = await FirebaseMessaging.instance.getToken() ?? " ";
    String? deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    try {
      final response = await http.get(
        url,
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.AUTHORIZATION: "Bearer " + accessToken,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final newVideos = List<Map<String, dynamic>>.from(
          jsonData['referralDetails'],
        );
        detailsReward = newVideos[0];
        setState(() {});
      } else {
        Get.snackbar('Error', 'Failed to load videos: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsrewardsapi();
  }

  String getRewardText(rewardType) {
    bool hasStcoins = rewardType.contains('stcoins');
    bool hasPremium = rewardType.contains('premium_access');

    if (hasStcoins && hasPremium) {
      return 'Stcoins with Premium Membership';
    } else if (hasStcoins) {
      return 'Stcoins';
    } else if (hasPremium) {
      return 'Premium Membership';
    } else {
      return 'No Rewards';
    }
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
                SizedBox(width: Constant.size10),

                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                Spacer(),
                Text(
                  "Your Referrals",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _openInviteBottomSheet();
                  },
                  child: Image.asset("assets/images/question.png", scale: 3),
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
            isLoading
                ? Container(
                  margin: EdgeInsets.all(8),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Container(
                          width: 60, // Placeholder width for text
                          height: 100, // Placeholder height for text
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                )
                : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Referral Stats", style: Styles.textBlackHeader),
                        SizedBox(height: 15),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First section - Total Referrals and Successful
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/total_ref.png",
                                        scale: 2.5,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Referrals",
                                              style: Styles.textStyleWhite14,
                                            ),
                                            Text(
                                              "${detailsReward["stats"]["totalReferrals"]}",
                                              style:
                                                  Styles.textStyleBlackMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/success.png",
                                        scale: 2.5,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Successful",
                                              style: Styles.textStyleWhite14,
                                            ),
                                            Text(
                                              "${detailsReward["stats"]["eligibleReferrals"]}",
                                              style: Styles.textStyleBlackMedium
                                                  .copyWith(
                                                    color: ColorAssets.green,
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

                            SizedBox(width: 20),

                            // Second section - Pending and Next Reward
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/pending.png",
                                        scale: 2.5,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Pending",
                                              style: Styles.textStyleWhite14,
                                            ),
                                            Text(
                                              "${detailsReward["stats"]["pendingReferrals"]}",
                                              style: Styles.textStyleBlackMedium
                                                  .copyWith(
                                                    color:
                                                        ColorAssets
                                                            .themeColorOrange,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/reward.png",
                                        scale: 2.5,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Next Reward",
                                              style: Styles.textStyleWhite14,
                                            ),
                                            Text(
                                              getRewardText(
                                                detailsReward["milestoneId"]["rewardType"],
                                              ),
                                              style:
                                                  Styles.textStyleBlackMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
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
                      ],
                    ),
                  ),
                ),
            isLoading ? Container() : SizedBox(height: 20),
            isLoading
                ? Container()
                : detailsReward["referredUsersMetCondition"].length != 0
                ? Text("Referred Friends", style: Styles.textBlackHeader)
                : Container(),
            SizedBox(height: 20),
            isLoading
                ? Container(
                  margin: EdgeInsets.all(8),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Container(
                          width: 60, // Placeholder width for text
                          height: 100, // Placeholder height for text
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: detailsReward["referredUsersMetCondition"].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    var item =
                        detailsReward["referredUsersMetCondition"][index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color:
                            item["isEligible"]
                                ? Color(0xffE8FFEC)
                                : Color(0xffFDF8EE),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              item["userId"]["profileImage"] != ""
                                  ? CircleAvatar(
                                    radius: Constant.size20,
                                    backgroundColor: ColorAssets.lightGrey,
                                    child: Image.network(
                                      item["userId"]["profileImage"],
                                      scale: 1,
                                    ),
                                  )
                                  : CircleAvatar(
                                    radius: Constant.size20,
                                    backgroundColor: ColorAssets.lightGrey,
                                    child: Icon(
                                      Icons.person,
                                      color: ColorAssets.themeColorOrange,
                                    ),
                                  ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["userId"]["firstname"],
                                    style: Styles.textStyleWhiteRegular
                                        .copyWith(color: ColorAssets.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

            SizedBox(height: 30),
            isLoading
                ? Container()
                : CommonButton(
                  label: "Invite More friends",
                  onClick: () {
                    final link = SharedPref.getString(PrefsKey.referralCode);

                    Share.share(
                      'Sign up using my referral link and get reward/benefit : https://sport-trending.softuvo.click/refer/$link',
                    );
                  },
                ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _openInviteBottomSheet() {
    final steps = [
      {
        "icon": "assets/images/chain.png",
        "title": "Step 1:",
        "subtitle": "Your friend signs up using your unique referral link",
      },
      {
        "icon": "assets/images/chain.png",
        "title": "Step 2:",
        "subtitle":
            "They complete their profile and meet the eligibility criteria",
      },
      {
        "icon": "assets/images/chain.png",
        "title": "Step 3:",
        "subtitle": "They stay active and engage with the app as required",
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "How are referrals tracked?",
                      style: Styles.buttonTextStyle18,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        "assets/images/cancel.png",
                        scale: 2.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Referrals are tracked when:",
                  style: Styles.textBlackHeader,
                ),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(step['icon']!, scale: 3),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step['title']!,
                                  style: Styles.textStyleBlackMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  step['subtitle']!,
                                  style: Styles.textStyleWhite14.copyWith(
                                    fontSize: 12,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.asset("assets/images/idea 1.png", scale: 2.2),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tip:",
                              style: Styles.textMetalHeader.copyWith(
                                color: ColorAssets.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "🚀 Once these steps are completed, your referral will be counted, and rewards will be added to your account! 🎉",
                              style: Styles.textStyleWhite14.copyWith(
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
