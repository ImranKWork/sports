import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_header.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/video_player_screen.dart';
import '../../search/views/comment_list.dart';

class MyVideos extends StatefulWidget {
  const MyVideos({super.key});

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  final HomeController controller = Get.put(HomeController());
  final RxString selectedCategory = ''.obs;

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
                  "My Videos",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
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
          children: [
            SizedBox(height: Constant.size8),
            _buildCategoryList(),
            SizedBox(height: Constant.size8),

            _buildHorizontalImageList(),
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
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                height: 398,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      }

      if (controller.videos.isEmpty) {
        return Center(child: Text("No Videos found with selected category"));
      }

      return ListView.builder(
        itemCount: controller.videos.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              height: 398,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(
                      thumbnailUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorAssets.themeColorOrange,
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/world_cup.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 398,
                        );
                      },
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // Bottom Left Text
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "FIFA World Cup",
                            style: Styles.textStyleWhiteSemiBold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          video['title'] ?? 'No Title',
                          style: Styles.textStyleWhiteSemiBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6),
                        (() {
                          final tags =
                              (video['videoContent']?['snippet']?['tags']
                                      as List<dynamic>?)
                                  ?.map((tag) => '#$tag')
                                  .join(' ');
                          return tags != null && tags.isNotEmpty
                              ? Text(
                                tags,
                                style: Styles.textStyleWhiteNormal.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                              : SizedBox();
                        })(),
                      ],
                    ),
                  ),

                  // Bottom Right Icons
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
                        SizedBox(height: 5),
                        Text(
                          video['appLikes']?.toString() ?? '0',
                          style: Styles.textStyleWhiteMedium,
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _showCommentSection(context),
                          child: Image.asset(
                            "assets/images/chat.png",
                            height: 22,
                            width: 22,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          video['appComments']?.toString() ?? '0',
                          style: Styles.textStyleWhiteMedium,
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          "assets/images/chat.png",
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(height: 5),
                        Text(
                          video['appShares']?.toString() ?? '0',
                          style: Styles.textStyleWhiteMedium,
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
