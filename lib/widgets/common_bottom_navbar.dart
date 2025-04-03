import 'package:flutter/material.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/utils/screen_util.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CommonBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Constant.size10),
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onItemSelected(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  Container(
                    width: Constant.size35,
                    height: Constant.size4,
                    decoration: BoxDecoration(
                      color: ColorAssets.themeColorOrange,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                  ),
                SizedBox(height: Constant.size10),
                Image.asset(
                  _getImage(index),
                  color:
                      index != 2
                          ? isSelected
                              ? ColorAssets.themeColorOrange
                              : Colors.grey
                          : null,
                  scale: 3,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _getImage(int index) {
    switch (index) {
      case 0:
        return ImageAssets.bottomNavHome;
      case 1:
        return ImageAssets.bottomNavSearch;
      case 2:
        return ImageAssets.bottomNavLogo;
      case 3:
        return ImageAssets.bottomNavChallenges;
      case 4:
        return ImageAssets.bottomNavProfile;
      default:
        return ImageAssets.bottomNavProfile;
    }
  }
}
