import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../source/color_assets.dart';
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
                Center(
                  child: CircularProgressIndicator(
                    color: ColorAssets.themeColorOrange,
                  ),
                ),

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
