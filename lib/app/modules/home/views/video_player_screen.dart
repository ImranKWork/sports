import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/controllers/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/shared_preference.dart';
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
  final HomeController controller = Get.put(HomeController());

  YoutubePlayerController? _controller;
  int currentIndex = 0;
  bool isScrolling = false;
  bool isPlaying = true;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 1.0, // Ensure full screen per page
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer(widget.allVideos[currentIndex]['videoUrl']);
    });
  }

  void _initializePlayer(String videoUrl) {
    final String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId != null) {
      _disposeVideoControllers();
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          forceHD: true,
          hideControls: true,
          disableDragSeek: true,
          enableCaption: false,
        ),
      )..addListener(() {
        setState(() {
          isPlaying = _controller!.value.isPlaying;
        });

        if (_controller!.value.playerState == PlayerState.ended) {
          _scrollToNextVideo();
        }
      });

      _controller!.play();
      setState(() {});
    } else {
      _disposeYoutubeController();
      _videoController = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: true,
            looping: false,
            allowMuting: true,
            showControls: false,
          );
          setState(() {});
        });

      _videoController!.addListener(() {
        if (_videoController!.value.position >=
                _videoController!.value.duration &&
            !_videoController!.value.isPlaying) {
          _scrollToNextVideo();
        }
      });
    }
  }

  void _disposeYoutubeController() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  void _disposeVideoControllers() {
    _chewieController?.pause();
    _chewieController?.dispose();
    _videoController?.dispose();
    _chewieController = null;
    _videoController = null;
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
    _disposeYoutubeController();
    _disposeVideoControllers();
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
          controller.viewVideos(widget.allVideos[currentIndex]['_id']);
        },
        itemBuilder: (context, index) {
          final videoData = widget.allVideos[index];

          return Stack(
            children: [
              if (_controller != null)
                GestureDetector(
                  onTap: () {}, // prevent redirection on tap
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: false,
                    ),
                    builder:
                        (context, player) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: player,
                        ),
                  ),
                )
              else if (_chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized)
                SizedBox.expand(child: Chewie(controller: _chewieController!))
              else
                Container(
                  color: Colors.black, // fallback background
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorAssets.themeColorOrange,
                    ),
                  ),
                ),
              // Back Button
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

              // Left Bottom Info
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
                            if (videoData['type'] == "tik-tok") {
                              return const SizedBox();
                            } else {
                              final tags =
                                  (videoData['videoContent']['snippet']['tags']
                                          as List<dynamic>?)
                                      ?.map((tag) => '#$tag')
                                      .join(' ') ??
                                  '';
                              return tags.isNotEmpty
                                  ? Text(
                                    tags,
                                    style: Styles.textStyleWhiteNormal.copyWith(
                                      fontSize: 12,
                                    ),
                                  )
                                  : const SizedBox();
                            }
                          })(),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: Get.width / 1.7,
                      child: Text(
                        videoData['title'] ?? '',
                        style: Styles.textStyleWhiteSemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // Right Bottom Icons
              Positioned(
                bottom: 15,
                right: 10,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (videoData['isLiked'] == false) {
                          videoData['isLiked'] = true;
                          setState(() {});
                        } else {
                          videoData['isLiked'] = false;
                          setState(() {});
                        }
                        var res = await controller.likeVideos(videoData['_id']);
                      },
                      child: Image.asset(
                        videoData['isLiked']
                            ? "assets/images/mdi_heart.png"
                            : "assets/images/like.png",
                        height: 22,
                        width: 22,
                      ),
                    ),
                    Text(
                      formatNumber(
                        int.tryParse(videoData['sourceLikes'].toString()) ?? 0,
                      ),
                      style: Styles.textStyleWhiteMedium,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap:
                          () => _showCommentSection(
                            context,
                            controller,
                            videoData['_id'],
                          ),
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

void _showCommentSection(
  BuildContext context,
  HomeController controller,
  String id,
) {
  TextEditingController commentController = TextEditingController();
  final String currentUserId = SharedPref.getString(PrefsKey.userId, "");

  controller.fetchComments(id);

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
                Container(
                  height: 4,
                  width: 73,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xffA6A6A6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
                      const SizedBox(width: 10),
                      Text("Comments", style: Styles.buttonTextStyle18),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.to(() => CommentList(id: id)),
                        child: Obx(() {
                          return Text(
                            "View Comments (${controller.commentsList.length})",
                            style: Styles.textBlueHeader,
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorAssets.themeColorOrange,
                        ),
                      );
                    }

                    if (controller.errorMessage.value.isNotEmpty) {
                      return Center(child: Text(controller.errorMessage.value));
                    }

                    if (controller.commentsList.isEmpty) {
                      return Center(
                        child: Text(
                          "No comments yet",
                          style: Styles.textMetalHeader.copyWith(
                            color: ColorAssets.black,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: controller.commentsList.length,
                      itemBuilder: (context, index) {
                        final item = controller.commentsList[index];
                        String commentId = item["comment_id"] ?? "";
                        String existingCommentText = item["commentText"] ?? "";
                        String commentUserId = item["user_id"] ?? "";

                        return ListTile(
                          leading: Image.asset(ImageAssets.img6),
                          title: Row(
                            children: [
                              Text(
                                "${item["username"]} | ${timeago.format(DateTime.parse(item["created_at"]))}",
                                style: Styles.textMetalHeader.copyWith(
                                  color: ColorAssets.black,
                                ),
                              ),
                              const Spacer(),
                              if (commentUserId == currentUserId) ...[
                                InkWell(
                                  onTap: () {
                                    _showEditCommentDialog(
                                      context,
                                      controller,
                                      id,
                                      commentId,
                                      existingCommentText,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () async {
                                    final userId = SharedPref.getString(
                                      PrefsKey.userId,
                                      "",
                                    );
                                    if (userId == item["user_id"]) {
                                      await controller.deleteComment(
                                        id, // videoId
                                        item["comment_id"],
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          subtitle: Text(
                            item["commentText"],
                            style: Styles.textStyleWhite16.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(ImageAssets.img6, height: 40, width: 40),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: "Add a Comment....",
                            hintStyle: Styles.textStyleWhite16.copyWith(
                              fontSize: 12,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorAssets.themeColorOrange,
                                width: 1.5,
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () async {
                                await controller.commentVideos(
                                  id,
                                  commentController.text.trim(),
                                );
                                commentController.clear();
                                scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(ImageAssets.send, scale: 3),
                              ),
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

void _showEditCommentDialog(
  BuildContext context,
  HomeController controller,
  String videoId,
  String commentId,
  String currentComment,
) {
  final TextEditingController editController = TextEditingController(
    text: currentComment,
  );

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit Comment", style: Styles.buttonTextStyle18),
              const SizedBox(height: 12),
              TextField(
                controller: editController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Edit your comment",
                  hintStyle: Styles.textStyleWhite16.copyWith(fontSize: 12),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
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
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAssets.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: Styles.textMetalHeader.copyWith(
                        color: ColorAssets.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  ElevatedButton(
                    onPressed: () async {
                      await controller.editComment(
                        videoId,
                        commentId,
                        editController.text.trim(),
                      );
                      Navigator.pop(context); // close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAssets.themeColorOrange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: Styles.textMetalHeader.copyWith(
                        color: ColorAssets.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
