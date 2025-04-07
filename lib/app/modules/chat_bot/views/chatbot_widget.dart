import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../wallet/views/wallet_page.dart';

class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({super.key});

  @override
  State<ChatBotWidget> createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
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
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: Constant.size5),

                Image.asset(ImageAssets.img6, height: 40, width: 40),
                SizedBox(width: Constant.size10),
                Text("You", style: Styles.textStyleBlackMedium),
              ],
            ),
            SizedBox(height: Constant.size10),
            Text(
              "Tell me the story of a student who was going to school and some interesting things happened to her on the way.",
              style: Styles.textStyleWhite14,
              maxLines: 2,
            ),
            SizedBox(height: Constant.size10),
            Divider(color: Color(0xffD6D6D6)),
            SizedBox(height: Constant.size10),
            Row(
              children: [
                SizedBox(width: Constant.size5),

                Image.asset(ImageAssets.bottomNavLogo, height: 40, width: 40),
                SizedBox(width: Constant.size10),
                Text("AI Assistant", style: Styles.textStyleBlackMedium),
              ],
            ),
            SizedBox(height: Constant.size10),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages.  It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages.",
              style: Styles.textStyleWhite14,
              maxLines: 15,
            ),
            SizedBox(height: Constant.size10),
            Divider(color: Color(0xffD6D6D6)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                  hintStyle: Styles.textStyleWhite16.copyWith(fontSize: 12),
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
    );
  }
}
