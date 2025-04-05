import 'package:flutter/material.dart';
import 'package:sports_trending/app/modules/home/views/challenges.dart';
import 'package:sports_trending/app/modules/profile/views/profile_view.dart';
import 'package:sports_trending/source/color_assets.dart';

import '../../../../widgets/common_bottom_navbar.dart';
import '../../chat_bot/views/chatbot_widget.dart';
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
