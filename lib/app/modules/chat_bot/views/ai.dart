import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../wallet/views/wallet_page.dart';

class AI extends StatefulWidget {
  const AI({super.key});

  @override
  State<AI> createState() => _AIState();
}

class _AIState extends State<AI> {
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Constant.size10),
                    Center(
                      child: Text(
                        "How can I help you my friend? 😊️",
                        style: Styles.textStyleBlackMedium,
                      ),
                    ),
                    SizedBox(height: Constant.size20),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff776F6947)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Recommend me trending sports video",
                                      style: Styles.textStyleBlackNormal
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            height: 1.5,
                                            letterSpacing: 0.5,
                                          ),
                                    ),
                                    SizedBox(height: Constant.size10),
                                    Text(
                                      "Lorem Ipsum is simply dummy text of the printing\nand typesetting industry",
                                      style: Styles.textStyleBlackRegular
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                            letterSpacing: 0.5,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: Constant.size10),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Image.asset(ImageAssets.arrow2, scale: 2.5),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Ask me anything...",
                        hintStyle: Styles.textStyleWhite16.copyWith(
                          fontSize: 12,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: ColorAssets.themeColorOrange,
                            width: 1.5,
                          ),
                        ),

                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Image.asset(ImageAssets.photo, scale: 3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Constant.size10),

                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(ImageAssets.send2, scale: 3.3),
                  ),
                  SizedBox(width: Constant.size10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
