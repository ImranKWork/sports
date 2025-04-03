import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/language/views/language_view.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/app/modules/user_profile/views/user_profile_view.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/image_picker_controller.dart';

import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../../../widgets/common_svg_images.dart';
import '../../help_support/views/help_support_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final ImageController imageController = Get.put(ImageController());
  final LanguageController languageController = Get.find();

  final ProfileController profileController = Get.put(ProfileController());
  final EditProfileController editProfileController = Get.put(
    EditProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(ImageAssets.headerLogo, scale: 3),
                Container(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () =>
                profileController.isLoading.value
                    ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorAssets.themeColorOrange,
                          ),
                        ),
                      ),
                    )
                    : Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          vertical: Constant.size15,
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              profileController.showEditProfileDialog();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: Constant.size10),
                              child: Obx(() {
                                return editProfileController.isLoading.value
                                    ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              ColorAssets.themeColorOrange,
                                            ),
                                      ),
                                    )
                                    : Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child:
                                              editProfileController
                                                      .profileImage
                                                      .value
                                                      .isNotEmpty
                                                  ? ClipOval(
                                                    child: Image.network(
                                                      editProfileController
                                                          .profileImage
                                                          .value,
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                  : CircleAvatar(
                                                    radius: Constant.size50,
                                                    backgroundColor:
                                                        ColorAssets.lightGrey,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            Constant.size50,
                                                          ),

                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            ColorAssets
                                                                .themeColorOrange,
                                                      ),
                                                    ),
                                                  ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right:
                                              -MediaQuery.sizeOf(
                                                context,
                                              ).width *
                                              0.18,
                                          left: 0,

                                          child: CommonSvgImages(
                                            image: ImageAssets.edit,
                                          ),
                                        ),
                                      ],
                                    );
                              }),
                            ),
                          ),

                          NameAndMemberSinceWidget(),
                          WalletAndChallengesCountWidget(),

                          CommonTileList(),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class CommonTileList extends StatelessWidget {
  CommonTileList({super.key});
  final LanguageController languageController = Get.find();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTile(
          onTap: () {
            Get.to(() => UserProfileView());
          },
          text: languageController.getLabel("my_profile_title"),
          iconPath: ImageAssets.user,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("change_password"),
          iconPath: ImageAssets.lock,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("leaderboard_label"),
          iconPath: ImageAssets.leaderboard,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("challenges_history"),
          iconPath: ImageAssets.trophy,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("stcoins_wallet"),
          iconPath: ImageAssets.coinSt,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("notification"),
          iconPath: ImageAssets.notification,
        ),
        CommonTile(
          onTap: () {
            Get.to(
              () => LanguageView(
                firstName: '',
                lastName: '',
                email: '',
                accessToken: '',
              ),
            );
          },
          text: languageController.getLabel("languages"),
          iconPath: ImageAssets.languages,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("notification_preferences_label"),
          iconPath: ImageAssets.notificationPreference,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => HelpSupportView());
          },
          text: languageController.getLabel("term_policies"),
          iconPath: ImageAssets.termsPolicy,
        ),

        CommonTile(
          onTap: () {
            // FirebaseAuth.instance.signOut();
            // await GoogleSignIn().signOut();
            // await FacebookAuth.instance.logOut(); //
            // SharedPref.clearData();
            //
            // Get.offAllNamed('/login');
            loginController.logout();
          },
          text: languageController.getLabel("logout"),
          iconPath: ImageAssets.logout,
        ),
      ],
    );
  }
}

class CommonTile extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  const CommonTile({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constant.size15,
          vertical: Constant.size15,
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              scale: 2.5,
              // height: Constant.size30,
              // width: Constant.size30,
              color: ColorAssets.darkGrey,
            ),
            Padding(
              padding: EdgeInsets.only(left: Constant.size7),
              child: Text(
                text,
                style: Styles.textStyleBlackMedium.copyWith(
                  color: ColorAssets.darkGrey,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletAndChallengesCountWidget extends StatelessWidget {
  WalletAndChallengesCountWidget({super.key});

  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Constant.size15,
        horizontal: Constant.size64,
      ),
      margin: EdgeInsets.symmetric(vertical: Constant.size30),
      color: ColorAssets.lightOrange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "140.00",
                style: Styles.textStyleBlackMedium.copyWith(
                  fontSize: FontSize.s22,
                ),
              ),
              Text(
                languageController.getLabel('wallet'),
                style: Styles.textStyleBlackMedium.copyWith(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w400,
                  color: ColorAssets.darkGrey,
                ),
              ),
            ],
          ),
          Container(
            height: Constant.size52,
            width: Constant.size2,
            color: ColorAssets.darkGrey,
          ),
          Column(
            children: [
              Text(
                "123",
                style: Styles.textStyleBlackMedium.copyWith(
                  fontSize: FontSize.s22,
                ),
              ),
              Text(
                languageController.getLabel('challenges_played'),
                style: Styles.textStyleBlackMedium.copyWith(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w400,
                  color: ColorAssets.darkGrey,
                ),
              ),
            ],
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
    final fName = SharedPref.getString(PrefsKey.fName);
    final lName = SharedPref.getString(PrefsKey.lName);
    final phone = SharedPref.getString(PrefsKey.phoneNo);
    final email = SharedPref.getString(PrefsKey.email);
    return Column(
      children: [
        Text(
          "$fName $lName",
          style: Styles.textStyleBlackMedium.copyWith(fontSize: FontSize.s18),
        ),
        Text(
          email.isNotEmpty ? email : phone,
          style: Styles.textStyleBlackMedium.copyWith(
            fontSize: FontSize.s14,
            color: ColorAssets.darkGrey,
          ),
        ),
      ],
    );
  }
}
