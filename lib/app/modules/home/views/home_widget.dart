import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_trending/app/modules/challenges_details/views/challenges_details.dart';
import 'package:sports_trending/app/modules/home/views/premium_videos.dart';
import 'package:sports_trending/app/modules/home/views/video_player_screen.dart';
import 'package:sports_trending/app/modules/home/views/view_winner.dart';
import 'package:sports_trending/app/modules/search/views/comment_list.dart';
import 'package:sports_trending/app/modules/wallet/views/wallet_page.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';
import '../controllers/home_controller.dart';
import 'challenges.dart';
import 'imgae_pageindicator.dart';
import 'leader_board.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final RxString selectedCategory = ''.obs;

  final HomeController controller = Get.put(HomeController());

  final List<String> images = [
    "assets/images/world_cup.png",
    "assets/images/world_cup.png",
  ];
  final List<String> imageList = [
    "assets/images/playing_football.jpg",
    "assets/images/playing_football.jpg",
    "assets/images/playing_football.jpg",
  ];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
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
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constant.size10),
            Row(
              children: [
                SizedBox(width: Constant.size10),

                Text("Viral Videos", style: Styles.buttonTextStyle18),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ShortsPlayerScreen(
                        allVideos: controller.videos,
                        initialIndex: 0,
                      ),
                    );
                  },
                  child: Text("View All", style: Styles.textBlueHeader),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size12),
            _buildCategoryList(),
            SizedBox(height: Constant.size15),
            _buildHorizontalImageList(),
            SizedBox(height: Constant.size10),
            Row(
              children: [
                SizedBox(width: Constant.size10),

                Text("Challenges", style: Styles.buttonTextStyle18),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChallengesWidget());
                  },
                  child: Text("View All", style: Styles.textBlueHeader),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size10),

            Column(
              children: [
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(imageList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 250,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: Constant.size90),
                              Text(
                                "🔥 Like 10 Videos Today!",
                                style: Styles.textStyleWhiteSemiBold.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "🎁 Earn 50 STCoins + Unlock an Exclusive\nVideo",
                                style: Styles.textStyleWhiteSemiBold.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => ChallengesDetails());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: Text(
                                  "Join Challenge",
                                  style: Styles.textStyleWhiteSemiBold.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: Constant.size5),

                ImagePageIndicator(
                  controller: _pageController,
                  count: imageList.length,
                ),
                SizedBox(height: Constant.size15),
                Row(
                  children: [
                    SizedBox(width: Constant.size5),

                    Text("Leaderboards", style: Styles.buttonTextStyle18),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LeaderBoard());
                      },
                      child: Text("View All", style: Styles.textBlueHeader),
                    ),
                    SizedBox(width: Constant.size5),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/crown.png",
                          height: 30,
                        ), // Crown Image
                        SizedBox(height: Constant.size5),

                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorAssets.themeColorOrange,
                              width: 3,
                            ), // Border color
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/icons/user.jpg",
                              height: 80, // Adjust size
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      bottom: -7, // Shift badge slightly downward
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorAssets.themeColorOrange,
                        ),
                        child: Center(
                          child: Text("1", style: Styles.textStyleWhiteMedium),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Constant.size15),

                GestureDetector(
                  onTap: () {
                    Get.to(() => ViewWinner());
                  },
                  child: Text("Winner", style: Styles.textStyleWhite16),
                ),

                Text("Cristofer Vetrovs", style: Styles.textStyleBlackMedium),
                SizedBox(height: Constant.size5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/like2.png",
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(height: Constant.size5),

                        Text("124 K", style: Styles.textBlackHeader),
                      ],
                    ),
                    SizedBox(width: Constant.size20),

                    Column(
                      children: [
                        Image.asset(
                          "assets/images/chat2.png",
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(height: Constant.size5),

                        Text("14 K", style: Styles.textBlackHeader),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Constant.size15),

            ListView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // If inside another scrollable widget
              itemCount: 5, // Number of items
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                  ), // Space between items
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    color:
                        index == 2
                            ? ColorAssets.textColorSea
                            : ColorAssets.grey2, // Change 3rd item color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text("${index + 2}", style: Styles.textStyleBlackMedium),
                      SizedBox(width: Constant.size8),

                      Image.asset(
                        "assets/images/user2.png",
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: Constant.size8),
                      Text(
                        index == 2 ? "You" : "Marsha Fisher",
                        style: Styles.textStyleBlackMedium,
                      ),
                      Spacer(),
                      Text(
                        "${(index + 1) * 10} pts",
                        style: Styles.textStyleBlackMedium,
                      ),
                      SizedBox(width: Constant.size8),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: Constant.size15),
            Row(
              children: [
                SizedBox(width: Constant.size10),

                Text("Exclusive for you", style: Styles.buttonTextStyle18),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => PremiumVideos());
                  },
                  child: Text("View All", style: Styles.textBlueHeader),
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size15),
            GestureDetector(
              onTap: () {
                _showVideoDialog();
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/playing_football.jpg",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black54, // Semi-transparent black overlay
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Constant.size5,
                        horizontal: Constant.size5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constant.size30),
                        color: Colors.white24,
                      ),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Minimum required space
                        children: [
                          Image.asset(ImageAssets.star, scale: 3),
                          SizedBox(width: 3),
                          Text(
                            "250.0",
                            style: Styles.textStyleBlackSemiBold.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/lock.png",
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          Text("250.0", style: Styles.textMetalHeader),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Constant.size15),

            Row(
              children: [
                SizedBox(width: Constant.size10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Constant.size10),

                    Text(
                      "FIFA Behind-the-Scenes",
                      style: Styles.textBlackHeader.copyWith(fontSize: 22),
                    ),
                    SizedBox(height: Constant.size5),

                    Text(
                      "#NBA #UCL #WorldCup",
                      style: Styles.textStyleBlackRegular.copyWith(
                        color: ColorAssets.darkGrey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showVideoDialog();
                      },
                      child: Image.asset(
                        "assets/images/like2.png",
                        height: 35,
                        width: 35,
                      ),
                    ),
                    SizedBox(height: Constant.size5),

                    Text("124 K", style: Styles.textBlackHeader),
                  ],
                ),
                SizedBox(width: Constant.size10),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showVideoDialog();
                      },
                      child: Image.asset(
                        "assets/images/chat2.png",
                        height: 35,
                        width: 35,
                      ),
                    ),
                    SizedBox(height: Constant.size5),

                    Text("124 K", style: Styles.textBlackHeader),
                  ],
                ),
                SizedBox(width: Constant.size15),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showVideoDialog();
                      },
                      child: Image.asset(
                        "assets/images/share.png",
                        height: 35,
                        width: 35,
                      ),
                    ),
                    SizedBox(height: Constant.size5),

                    Text("124 K", style: Styles.textBlackHeader),
                  ],
                ),
                SizedBox(width: Constant.size10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(46),
                  ),
                  child: Center(
                    child: Container(
                      width: 60, // Placeholder width for text
                      height: 16, // Placeholder height for text
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      if (selectedCategory.value.isEmpty && controller.categories.isNotEmpty) {
        selectedCategory.value = controller.categories[0]['name'];
        controller.fetchVideos(controller.categories[0]['_id']);
      }

      return SizedBox(
        height: 45,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index]['name'];
            final categoryId =
                controller.categories[index]['_id']; // Category ID
            bool isSelected = selectedCategory.value == category;

            return GestureDetector(
              onTap: () {
                selectedCategory.value = category; // Set the selected category
                controller.fetchVideos(
                  categoryId,
                ); // Fetch videos based on the category
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? ColorAssets
                              .themeColorOrange // Selected color
                          : ColorAssets.grey1, // Unselected color
                  borderRadius: BorderRadius.circular(46),
                ),
                child: Center(
                  child: Text(
                    category,
                    style:
                        isSelected
                            ? Styles
                                .textStyleWhiteMedium // Style for selected
                            : Styles.textStyleWhite14, // Style for unselected
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildHorizontalImageList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return SizedBox(
          height: 540,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.37),
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        );
      }

      if (controller.videos.isEmpty) {
        return Center(child: Text("No Videos found with selected category"));
      }

      return SizedBox(
        height: 540,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.videos.length,
          itemBuilder: (context, index) {
            var video = controller.videos[index];
            String thumbnailUrl = video['thumbnails']?['maxres']?['url'] ?? '';

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => ShortsPlayerScreen(
                    allVideos: controller.videos,
                    initialIndex: index,
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width / 1.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.37),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.37),
                      child: Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        width: Get.width / 1.4,
                        height: 540,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Image loaded successfully
                          }
                          return SizedBox(
                            width: Get.width / 1.4,
                            height: 540,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorAssets.themeColorOrange,
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/world_cup.png',
                            fit: BoxFit.cover,
                            width: Get.width / 1.4,
                            height: 540,
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "FIFA World Cup",
                              style: Styles.textStyleWhiteSemiBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: Constant.size8),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              video['title'] ?? 'No Title',
                              style: Styles.textStyleWhiteSemiBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: Constant.size8),
                          /*Text(
                            (video['videoContent']?['snippet']?['tags']
                                        as List<dynamic>?)
                                    ?.map((tag) => '#$tag ')
                                    .join(' ') ??
                                '',
                            style: Styles.textStyleWhiteNormal.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),*/
                          (() {
                            final tags =
                                (video['videoContent']?['snippet']?['tags']
                                        as List<dynamic>?)
                                    ?.map((tag) => '#$tag')
                                    .join(' ');

                            if (tags != null && tags.isNotEmpty) {
                              return Text(
                                tags,
                                style: Styles.textStyleWhiteNormal.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            } else {
                              return SizedBox(); // No tags, return empty widget
                            }
                          })(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/like.png",
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(height: Constant.size5),
                        Text(
                          video['appLikes']?.toString() ?? '0',
                          style: Styles.textStyleWhiteMedium,
                        ),
                        SizedBox(height: Constant.size10),
                        GestureDetector(
                          onTap: () => _showCommentSection(context),
                          child: Image.asset(
                            "assets/images/chat.png",
                            height: 22,
                            width: 22,
                          ),
                        ),
                        SizedBox(height: Constant.size5),
                        Text(
                          video['appComments']?.toString() ?? '0',
                          style: Styles.textStyleWhiteMedium,
                        ),
                        SizedBox(height: Constant.size10),
                        Image.asset(
                          "assets/images/chat.png",
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(height: Constant.size5),
                        Text(
                          video['appShares']?.toString() ?? '0',
                          style: Styles.textStyleWhiteMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  void _showVideoDialog() {
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
              Image.asset(ImageAssets.balance, scale: 3),
              SizedBox(height: 5),

              Text("Balance low", style: Styles.textStyleBlackMedium),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min, // Minimum required space
                children: [
                  Image.asset(ImageAssets.star, scale: 3),
                  SizedBox(width: 3),
                  Text(
                    "20",
                    style: Styles.textStyleBlackNormal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Constant.size10),

              Text(
                "For unlimited of joy for watching the shorties! You have to use ST Coins or join challenges",
                style: Styles.textStyleWhite14.copyWith(fontSize: 12),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Constant.size20),
              Padding(
                padding: const EdgeInsets.only(left: 38.0, right: 38),
                child: CommonButton(
                  label: 'Unlock Now',
                  onClick: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void _showCommentSection(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                /// **Drag Indicator**
                Container(
                  height: 4,
                  width: 73,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffA6A6A6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                /// **Header Row**
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Image.asset(
                          "assets/images/back.png",
                          scale: 2.8,
                          color: ColorAssets.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Comments", style: Styles.buttonTextStyle18),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CommentList());
                        },
                        child: Text(
                          "View 10 Comments",
                          style: Styles.textBlueHeader,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// **Comment List (Scrollable)**
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: 10, // Replace with actual comment count
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(ImageAssets.img6),
                        title: Text(
                          "John Deo | 21 h",
                          style: Styles.textMetalHeader.copyWith(
                            color: ColorAssets.black,
                          ),
                        ),
                        subtitle: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          style: Styles.textStyleWhite16.copyWith(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),

                /// **TextField for Writing Comments**
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
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
                            hintStyle: Styles.textStyleWhite16.copyWith(
                              fontSize: 12,
                            ),

                            filled: true,
                            fillColor:
                                Colors.white, // ✅ **Pure White Background**
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),

                            // ✅ Border with Color
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400, // **Border Color**
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color:
                                    ColorAssets
                                        .themeColorOrange, // **Border color when active**
                                width: 1.5,
                              ),
                            ),

                            // ✅ Send Button & Emoji Inside TextField with Divider
                            suffixIcon: Row(
                              mainAxisSize:
                                  MainAxisSize.min, // ✅ Keeps it compact
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImageAssets.smile,
                                    scale: 3,
                                  ),
                                ),

                                // ✅ **Vertical Divider**
                                Container(
                                  height: 20,
                                  width: 1.5, // Thin Divider
                                  color: Colors.grey.shade400,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                ),

                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    ImageAssets.send,
                                    scale: 3,
                                  ),
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
              ],
            );
          },
        ),
      );
    },
  );
}
