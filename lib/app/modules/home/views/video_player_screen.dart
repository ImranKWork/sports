import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../search/views/comment_list.dart';

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
          // Manual Play

          setState(() {
            isPlaying = _controller!.value.isPlaying;
          });

          if (_controller!.value.playerState == PlayerState.ended) {
            _scrollToNextVideo();
          }
        });
        _controller!.cue(videoId);
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

  String formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
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
                    showVideoProgressIndicator: false,
                    bottomActions: const [],
                  ),
                  builder: (context, player) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: player,
                    );
                  },
                )
              else
                Center(
                  child: CircularProgressIndicator(
                    color: ColorAssets.themeColorOrange,
                  ),
                ),

              /// Back Button
              Positioned(
                top: 30,
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

              Positioned(
                bottom: 15,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 1.7,

                      child:
                          (() {
                            final tags =
                                (videoData['videoContent']['snippet']['tags']
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
                              return SizedBox();
                            }
                          })(),
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
                bottom: 15,
                right: 10,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/like.png",
                      height: 22,
                      width: 22,
                    ),
                    Text(
                      formatNumber(
                        int.tryParse(videoData['sourceLikes'].toString()) ?? 0,
                      ),
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _showCommentSection(context),
                      child: Image.asset(
                        "assets/images/chat.png",
                        height: 22,
                        width: 22,
                      ),
                    ),
                    Text(
                      formatNumber(
                        int.tryParse(videoData['sourceComments'].toString()) ??
                            0,
                      ),
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/share.png",
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      formatNumber(
                        int.tryParse(videoData['sourceSharess'].toString()) ??
                            0,
                      ),
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
                    itemCount: 10,
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
