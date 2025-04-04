/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/views/challenges.dart';
import 'package:sports_trending/app/modules/profile/controllers/profile_controller.dart';
import 'package:sports_trending/app/modules/profile/views/profile_view.dart';
import 'package:sports_trending/source/color_assets.dart';

import '../../../../widgets/common_bottom_navbar.dart';
import '../../search/views/search_widget.dart';
import '../controllers/home_controller.dart';
import 'home_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        backgroundColor: ColorAssets.white,
        bottomNavigationBar: CommonBottomNavigationBar(
          selectedIndex: controller.currentIndex.value,
          onItemSelected: controller.setIndex,
        ),
        body: _getBody(controller.currentIndex.value),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return HomeWidget();
      case 1:
        return SearchWidget();
      case 2:
        return ChatBotWidget();
      case 3:
        return ChallengesWidget();
      case 4:
        return ProfileView();
    }
    return SizedBox();
  }
}

class ChatBotWidget extends StatelessWidget {
  const ChatBotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Center(child: Text("ChatBot screen"))],
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:sports_trending/app/modules/home/views/challenges.dart';
import 'package:sports_trending/app/modules/profile/views/profile_view.dart';
import 'package:sports_trending/source/color_assets.dart';

import '../../../../widgets/common_bottom_navbar.dart';
import '../../search/views/search_widget.dart';
import 'home_widget.dart';

class HomeView extends StatefulWidget {
  final int initialIndex;

  const HomeView({super.key, this.initialIndex = 0});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late int _currentIndex;

  final List<Widget> _screens = [
    HomeWidget(),
    SearchWidget(),
    ChatBotWidget(),
    ChallengesWidget(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      bottomNavigationBar: CommonBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _screens[_currentIndex],
    );
  }
}

class ChatBotWidget extends StatelessWidget {
  const ChatBotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("ChatBot screen"));
  }
}
