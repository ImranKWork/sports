import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sports_trending/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/widgets/common_button.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  UserProfileView({super.key});

  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final profileImage = SharedPref.getString(PrefsKey.profilePhoto, "");
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Text(
                languageController.getLabel('user_profile'),
                style: Styles.textStyleWhiteBold.copyWith(
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                top: Constant.size15,
                bottom: Constant.size20,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Constant.size10,
                    left: Constant.size130,
                    right: Constant.size130,
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      child:
                          profileImage.isNotEmpty
                              ? ClipOval(
                                child: Image.network(
                                  profileImage,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                                // child: Image.network(
                                //   profileImage,
                                //   // width: Constant.size100,
                                //   // height: Constant.size100,
                                //   fit: BoxFit.contain,
                                // ),
                              )
                              : CircleAvatar(
                                radius: Constant.size50,
                                backgroundColor: ColorAssets.lightGrey,
                                child: Icon(
                                  Icons.person,
                                  color: ColorAssets.themeColorOrange,
                                ),
                              ),
                    ),
                  ),
                ),

                NameAndMemberSinceWidget(),

                CommonTileList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Constant.size15),
        child: CommonButton(
          label: languageController.getLabel('user_profile'),
          onClick: () {
            Get.to(() => EditProfileView());
          },
        ),
      ),
    );
  }
}

class CommonTileList extends StatelessWidget {
  CommonTileList({super.key});

  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final name =
        "${SharedPref.getString(PrefsKey.fName)} ${SharedPref.getString(PrefsKey.lName)}";
    return Column(
      children: [
        SizedBox(height: Constant.size10),
        CommonTile(
          text1: languageController.getLabel("name"),
          text2: name,
          iconPath: ImageAssets.user,
        ),

        CommonDivider(),

        CommonTile(
          text1: languageController.getLabel('stcoins_balance'),
          text2: "2510 Coins",
          iconPath: ImageAssets.coin,
        ),
        CommonDivider(),
        CommonTile(
          text1: languageController.getLabel('total_videos_watched'),
          text2: "240 Videos",
          iconPath: ImageAssets.videoSmall,
        ),
        CommonDivider(),
        CommonTile(
          text1: languageController.getLabel('comments_made'),
          text2: "240 Comments",
          iconPath: ImageAssets.comments,
        ),
        CommonDivider(),
        CommonTile(
          text1: languageController.getLabel('likes_given'),
          text2: "212 Likes",
          iconPath: ImageAssets.like,
        ),
        CommonDivider(),
        CommonTile(
          text1: languageController.getLabel('challenges_completed'),
          text2: "212 Challenges",
          iconPath: ImageAssets.challenges,
        ),
      ],
    );
  }
}

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constant.size15,
        vertical: Constant.size5,
      ),
      child: Divider(color: ColorAssets.lightGrey),
    );
  }
}

class CommonTile extends StatelessWidget {
  final String iconPath;
  final String text1, text2;

  const CommonTile({
    super.key,
    required this.iconPath,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constant.size15,
        vertical: Constant.size10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            iconPath,
            height: Constant.size32,
            width: Constant.size32,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Constant.size7,
              top: Constant.size0_5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: Styles.textStyleBlackMedium.copyWith(
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(
                  text2,
                  style: Styles.textStyleBlackMedium.copyWith(
                    fontSize: FontSize.s18,
                    color: ColorAssets.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NameAndMemberSinceWidget extends StatelessWidget {
  const NameAndMemberSinceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final memberSince = SharedPref.getString(PrefsKey.memberSince);
    final name =
        "${SharedPref.getString(PrefsKey.fName)} ${SharedPref.getString(PrefsKey.lName)}";

    return Column(
      children: [
        Text(
          name,
          style: Styles.textStyleBlackMedium.copyWith(fontSize: FontSize.s18),
        ),
        Text(
          "Member since: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(memberSince))}",
          style: Styles.textStyleBlackMedium.copyWith(
            fontSize: FontSize.s15,
            color: ColorAssets.darkGrey,
          ),
        ),
      ],
    );
  }
}
