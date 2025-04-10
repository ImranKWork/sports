import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:sports_trending/app/modules/home/views/challenges.dart';
import 'package:sports_trending/app/modules/home/views/leader_board.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/language/views/language_view.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/app/modules/profile/views/notification_pref.dart';
import 'package:sports_trending/app/modules/profile/views/refer_your_friends.dart';
import 'package:sports_trending/app/modules/user_profile/views/user_profile_view.dart';
import 'package:sports_trending/app/modules/wallet/views/st_coins.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/image_picker_controller.dart';

import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';
import '../../../../widgets/common_svg_images.dart';
import '../../help_support/views/help_support_view.dart';
import '../../login/views/login_view.dart';
import '../../wallet/views/wallet_page.dart';
import '../controllers/profile_controller.dart';
import 'change_passwd.dart';
import 'my_videos.dart';
import 'notification.dart';

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
          onTap: () {
            Get.to(() => ChangePasswd());
          },
          text: languageController.getLabel("change_password"),
          iconPath: ImageAssets.lock,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => LeaderBoard());
          },
          text: languageController.getLabel("leaderboard_label"),
          iconPath: ImageAssets.leaderboard,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => ChallengesWidget());
          },
          text: languageController.getLabel("challenges_history"),
          iconPath: ImageAssets.trophy,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => MyVideos());
          },
          text: languageController.getLabel("my_videos"),
          iconPath: ImageAssets.myVideos,
        ),
        CommonTile(
          onTap: () {},
          text: languageController.getLabel("sub_plans"),
          iconPath: ImageAssets.subs,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => StCoins());
          },
          text: languageController.getLabel("stCoins_wallet"),
          iconPath: ImageAssets.coinSt,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => ReferYourFriends());
          },
          text: languageController.getLabel("refer_earn"),
          iconPath: ImageAssets.refer,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => NotificationPage());
          },
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
                fromSignup: false,
              ),
            );
          },
          text: languageController.getLabel("languages"),
          iconPath: ImageAssets.languages,
        ),
        CommonTile(
          onTap: () {
            Get.to(() => NotificationPref());
          },
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
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: ColorAssets.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(ImageAssets.logouts, scale: 3),
                      SizedBox(height: 5),

                      Text(
                        "Are you sure you want to logout?",
                        style: Styles.textStyleBlackMedium,
                      ),

                      SizedBox(height: Constant.size10),

                      // Text(
                      //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                      //   style: Styles.textStyleWhite14.copyWith(fontSize: 12),
                      //   maxLines: 3,
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: Constant.size20),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: CommonButton(
                              label: languageController.getLabel("logout"),
                              onClick: () {
                                loginController.logout();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: OutlinedButton(
                              onPressed: () {
                                Get.back(); // Close the dialog
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: ColorAssets.themeColorOrange,
                                ), // Border color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                languageController.getLabel("cancel"),
                                style: Styles.textStyleWhiteSemiBold.copyWith(
                                  fontSize: FontSize.s14,
                                  color: ColorAssets.themeColorOrange,
                                ), // Text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },

          text: languageController.getLabel("logout"),
          iconPath: ImageAssets.logout,
        ),
        CommonTile(
          onTap: () async {
            try {
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                await user.delete();

                await SharedPref.clearData();

                Get.offAll(() => LoginView());

                Get.snackbar(
                  languageController.getLabel("account_deleted"),
                  languageController.getLabel("deleted_successfully"),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: ColorAssets.themeColorOrange,
                  colorText: Colors.white,
                );
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'requires-recent-login') {
                Get.snackbar(
                  languageController.getLabel("re-authentication_required"),
                  languageController.getLabel("log _in _again_delete_account."),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  languageController.getLabel("error"),
                  e.message ??
                      languageController.getLabel("failed_to_delete_account"),

                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            }
          },
          text: languageController.getLabel("delete_account"),
          iconPath: ImageAssets.delete,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Constant.size24,
              width: Constant.size24,
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
                color: ColorAssets.darkGrey,
              ),
            ),
            SizedBox(width: Constant.size15),
            Expanded(
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
