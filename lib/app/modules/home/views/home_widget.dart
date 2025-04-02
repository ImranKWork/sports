import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_trending/app/modules/challenges_details/views/challenges_details.dart';
import 'package:sports_trending/app/modules/home/views/video_player_screen.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../controllers/home_controller.dart';
import 'imgae_pageindicator.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<String> categories = ["All", "Basketball", "Football", "Tennis"];
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(ImageAssets.headerLogo),
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
                  children: [
                    Image.asset(ImageAssets.star),
                    Text("250.0", style: Styles.textStyleWhiteMedium),
                  ],
                ),
              ),
            ],
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
                Text("View All", style: Styles.textBlueHeader),
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
                Text("View All", style: Styles.textBlueHeader),
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
                    Text("View All", style: Styles.textBlueHeader),
                    SizedBox(width: Constant.size5),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none, // Allow overflow
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

                Text("Winner", style: Styles.textStyleWhite16),

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
                Text("View All", style: Styles.textBlueHeader),
                SizedBox(width: Constant.size10),
              ],
            ),
            SizedBox(height: Constant.size15),

            Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/playing_football.jpg",
                          width: double.infinity, // Full width
                          height: 200, // Fixed height
                          fit: BoxFit.cover, // Cover full space
                        ),
                      ),

                      /// 🎯 Grey Overlay (Semi-Transparent)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Colors.black54, // Semi-transparent black overlay
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      /// 🎯 Lock Image (Centered)
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/lock.png",
                                width: 80, // Adjust lock size
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
                    Image.asset(
                      "assets/images/like2.png",
                      height: 35,
                      width: 35,
                    ),
                    SizedBox(height: Constant.size5),

                    Text("124 K", style: Styles.textBlackHeader),
                  ],
                ),
                SizedBox(width: Constant.size10),

                Column(
                  children: [
                    Image.asset(
                      "assets/images/chat2.png",
                      height: 35,
                      width: 35,
                    ),
                    SizedBox(height: Constant.size5),

                    Text("124 K", style: Styles.textBlackHeader),
                  ],
                ),
                SizedBox(width: Constant.size15),

                Column(
                  children: [
                    Image.asset(
                      "assets/images/share.png",
                      height: 35,
                      width: 35,
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

      // Setting default category on load
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

      return SizedBox(
        height: 540,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.videos.length,
          itemBuilder: (context, index) {
            var video = controller.videos[index];

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
                      image: DecorationImage(
                        image: NetworkImage(
                          video['thumbnails']['maxres']['url'] ?? ''.toString(),
                        ),
                        fit: BoxFit.cover,
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
                              color: Colors.white24, // Button background color
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

                          Text(
                            (video['videoContent']['snippet']['tags']
                                        as List<dynamic>?)
                                    ?.map((tag) => '#$tag ')
                                    .join(' ') ??
                                'No Tags',
                            style: Styles.textStyleWhiteNormal.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                      Text("View 10 Comments", style: Styles.textBlueHeader),
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

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../source/styles.dart';

class ShortsPlayerScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allVideos;
  final int initialIndex;

  const ShortsPlayerScreen({
    super.key,
    required this.allVideos,
    required this.initialIndex,
  });

  @override
  _ShortsPlayerScreenState createState() => _ShortsPlayerScreenState();
}

class _ShortsPlayerScreenState extends State<ShortsPlayerScreen> {
  late PageController _pageController;
  YoutubePlayerController? _controller;
  int currentIndex = 0;
  bool isScrolling = false;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
    });
  }

  void _initializePlayer(String videoUrl) {
    final String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      _controller?.dispose();
      _controller = null;
      setState(() {});

      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;

        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            forceHD: true,
            loop: false,
            enableCaption: false,
            isLive: false,
          ),
        )..addListener(() {
          if (!mounted) return;

          setState(() {
            isPlaying = _controller!.value.isPlaying;
          });

          if (_controller!.value.playerState == PlayerState.ended) {
            _scrollToNextVideo();
          }
        });

        setState(() {});
        _controller?.play();
      });
    }
  }

  void _scrollToNextVideo() {
    if (isScrolling || currentIndex >= widget.allVideos.length - 1) return;

    isScrolling = true;
    currentIndex++;

    _pageController
        .animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {
          isScrolling = false;
          _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
        });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.allVideos.length,
        onPageChanged: (index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
              _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
            });
          }
        },
        itemBuilder: (context, index) {
          final videoData = widget.allVideos[index];

          return Stack(
            children: [
              if (_controller != null)
                YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller!,
                    aspectRatio: 9 / 16,
                  ),
                  builder: (context, player) {
                    return Center(child: player);
                  },
                )
              else
                const Center(child: CircularProgressIndicator()),

              /// Back Button
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              /// Video Details (Left Bottom)
              Positioned(
                bottom: 100,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 1.7,

                      child: Text(
                        (videoData['videoContent']['snippet']['tags']
                                    as List<dynamic>?)
                                ?.map((tag) => '#$tag ')
                                .join(' ') ??
                            'No Tags',
                        style: Styles.textStyleWhiteNormal.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: Get.width / 1.7,
                      child: Text(
                        videoData['title'] ?? 'No Title',
                        style: Styles.textStyleWhiteSemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              Positioned(
                bottom: 100,
                right: 10,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/like.png",
                      height: 22,
                      width: 22,
                    ),
                    Text(
                      videoData['appLikes']?.toString() ?? '0',
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/chat.png",
                      height: 22,
                      width: 22,
                    ),
                    Text(
                      videoData['appComments']?.toString() ?? '0',
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/share.png",
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      videoData['appShares']?.toString() ?? '0',
                      style: Styles.textStyleWhiteMedium,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/
/*import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../source/styles.dart';

class ShortsPlayerScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allVideos;
  final int initialIndex;

  const ShortsPlayerScreen({
    super.key,
    required this.allVideos,
    required this.initialIndex,
  });

  @override
  _ShortsPlayerScreenState createState() => _ShortsPlayerScreenState();
}

class _ShortsPlayerScreenState extends State<ShortsPlayerScreen> {
  late PageController _pageController;
  BetterPlayerController? _playerController;
  int currentIndex = 0;
  bool isScrolling = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
    });
  }

  void _initializePlayer(String videoUrl) {
    _playerController?.dispose(); // Previous player dispose
    _playerController = null;
    setState(() {}); // Reset UI

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoUrl,
      );

      _playerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControls: false,
          ),
        ),
        betterPlayerDataSource: dataSource,
      );

      setState(() {});
    });
  }

  void _scrollToNextVideo() {
    if (isScrolling || currentIndex >= widget.allVideos.length - 1) return;

    isScrolling = true;
    currentIndex++;

    _pageController
        .animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {
          isScrolling = false;
          _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
        });
  }

  @override
  void dispose() {
    _playerController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.allVideos.length,
        onPageChanged: (index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
              _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
            });
          }
        },
        itemBuilder: (context, index) {
          final videoData = widget.allVideos[index];

          return Stack(
            children: [
              if (_playerController != null)
                Center(child: BetterPlayer(controller: _playerController!))
              else
                const Center(child: CircularProgressIndicator()),

              /// Back Button
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              /// Video Details (Left Bottom)
              Positioned(
                bottom: 100,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 1.7,
                      child: Text(
                        (videoData['videoContent']['snippet']['tags']
                                    as List<dynamic>?)
                                ?.map((tag) => '#$tag ')
                                .join(' ') ??
                            'No Tags',
                        style: Styles.textStyleWhiteNormal.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: Get.width / 1.7,
                      child: Text(
                        videoData['title'] ?? 'No Title',
                        style: Styles.textStyleWhiteSemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              Positioned(
                bottom: 100,
                right: 10,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/like.png",
                      height: 22,
                      width: 22,
                    ),
                    Text(
                      videoData['appLikes']?.toString() ?? '0',
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/chat.png",
                      height: 22,
                      width: 22,
                    ),
                    Text(
                      videoData['appComments']?.toString() ?? '0',
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/share.png",
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      videoData['appShares']?.toString() ?? '0',
                      style: Styles.textStyleWhiteMedium,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/
