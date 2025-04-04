import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/utils/screen_util.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../widgets/common_header.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  State<CommentList> createState() => _SearchBackState();
}

class _SearchBackState extends State<CommentList> {
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
                  "Back",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 3),
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(ImageAssets.img6, scale: 3),
            title: Text(
              "John Deo | 21 h",
              style: Styles.textMetalHeader.copyWith(color: ColorAssets.black),
            ),
            subtitle: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              style: Styles.textStyleWhite16.copyWith(fontSize: 12),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Row(
            children: [
              Image.asset(ImageAssets.img6, height: 40, width: 40),
              SizedBox(width: Constant.size5),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Add a Comment....",
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
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(ImageAssets.smile, scale: 3),
                        ),
                        Container(
                          height: 20,
                          width: 1.5,
                          color: Colors.grey.shade400,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(ImageAssets.send, scale: 3),
                        ),
                        SizedBox(width: Constant.size10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
