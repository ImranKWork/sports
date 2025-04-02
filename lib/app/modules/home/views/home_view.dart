import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class ChallengesWidget extends StatelessWidget {
  const ChallengesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Center(child: Text("Challenges screen"))],
    );
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
