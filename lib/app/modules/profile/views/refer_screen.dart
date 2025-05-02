import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/profile/views/your_refer.dart';
import 'package:sports_trending/widgets/common_button.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  final TextEditingController _inviteLinkController = TextEditingController(
    text: "https://sportstrending.com/invite/ih/ukjs21...",
  );
  double progressValue = 0.4;
  double progressValue2 = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Adjust height as needed
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: ColorAssets.purple),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ), // handle status bar
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 15),

                  Row(
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
                      Spacer(),
                      Text(
                        "Referral Program",
                        style: Styles.textStyleBlackMedium.copyWith(
                          color: ColorAssets.white,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _openInviteBottomSheet();
                        },
                        child: Image.asset(
                          "assets/images/question.png",
                          scale: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.2,
          child: Stack(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFC99A), Color(0xFFE67E22)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          // top: 40,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/blue_shade.png",
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.contain,
                                ),

                                Image.asset(
                                  "assets/images/gift.png",
                                  scale: 2.5,
                                ),
                              ],
                            ),

                            Text(
                              "Refer your Friends &\nEarn 100 ST Points",
                              style: Styles.buttonTextStyle18,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Invite friends & earn rewards!",
                              style: Styles.textStyleWhite14.copyWith(
                                color: ColorAssets.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 270,
                left: 8,
                right: 8,
                child: _buildReferralContainer(),
              ),
              Positioned(
                top: 495,
                left: 16,
                right: 8,
                child: Text("Your Rewards", style: Styles.buttonTextStyle18),
              ),

              Positioned(
                top: 525,
                left: 8,
                right: 8,
                child: Container(
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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/refer2.png", scale: 3),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Refer 1 friend",
                                      style: Styles.textStyleBlackMedium,
                                    ),
                                    Text(
                                      "InProgress",
                                      style: Styles.textBlueHeader.copyWith(
                                        color: ColorAssets.themeColorOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Refer a friend and enjoy 1 month of Premium Access for free!",
                                  style: Styles.textStyleWhite14.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Color(0xffF0F0F0),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorAssets.themeColorBlue,
                        ),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            "1/3 Referred",
                            style: Styles.textStyleWhite14.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "1 Month Premium Membership",
                            style: Styles.textStyleBlackRegular,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      CommonButton(
                        label: "Track Referral",
                        onClick: () {
                          Get.to(() => YourRefer());
                        },
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 720,
                left: 8,
                right: 8,
                child: Container(
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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/refer2.png", scale: 3),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Refer 1 friend",
                                      style: Styles.textStyleBlackMedium,
                                    ),
                                    Text(
                                      "InProgress",
                                      style: Styles.textBlueHeader.copyWith(
                                        color: ColorAssets.themeColorOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Refer a friend and enjoy 1 month of Premium Access for free!",
                                  style: Styles.textStyleWhite14.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      LinearProgressIndicator(
                        value: progressValue2,
                        backgroundColor: Color(0xffF0F0F0),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorAssets.themeColorBlue,
                        ),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            "1/3 Referred",
                            style: Styles.textStyleWhite14.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "1 Month Premium Membership",
                            style: Styles.textStyleBlackRegular,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      CommonButton(
                        label: "Track Referral",
                        onClick: () {
                          Get.to(() => YourRefer());
                        },
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReferralContainer() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Unique Referral Link",
            style: Styles.textMetalHeader.copyWith(color: ColorAssets.black),
          ),
          const SizedBox(height: 8),
          Text(
            "Share your link & earn exciting rewards!",
            style: Styles.textStyleWhite14.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              style: Styles.textStyleBlackMedium.copyWith(
                color: Colors.black,
              ), // ensure visible text
              readOnly: true,
              controller: _inviteLinkController,
              decoration: InputDecoration(
                hintText: "https://sportstrending.com/invite/ih/ukjs21...",
                hintStyle: Styles.textStyleWhite14.copyWith(
                  fontSize: 12,
                  color: Colors.grey, // lighter hint text
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: _inviteLinkController.text),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Link copied to clipboard')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Copy",
                          style: Styles.textStyleBlackRegular.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorAssets.themeColorOrange,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset("assets/images/copy.png", scale: 2.2),
                      ],
                    ),
                  ),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
          ),

          const SizedBox(height: 16),
          CommonButton(label: 'Share invite code', onClick: () {}),
        ],
      ),
    );
  }

  void _openInviteBottomSheet() {
    final steps = [
      {
        "icon": "assets/images/chain.png",
        "title": "Invite Your Friends",
        "subtitle":
            "Share your unique referral code with friends via WhatsApp, social media, email, or SMS.",
      },
      {
        "icon": "assets/images/chain.png",
        "title": "Friends Sign Up",
        "subtitle":
            "Your friends must use your referral link when signing up. They must complete their profile and meet the eligibility criteria.",
      },
      {
        "icon": "assets/images/chain.png",
        "title": "Earn Rewards",
        "subtitle":
            "Earn rewards for every referral, unlock milestone bonuses, and track your progress in the Referral Dashboard!",
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
                    Text("How it Works?", style: Styles.buttonTextStyle18),
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
                const SizedBox(height: 10),
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
                              "Invite more friends to reach exclusive milestones and unlock higher rewards! 🎁",
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
                const SizedBox(height: 8),

                CommonButton(
                  label: "Got It!",
                  onClick: () {
                    Get.off(() => YourRefer());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
