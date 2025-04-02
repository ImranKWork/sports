import 'package:flutter/material.dart';

import '../source/color_assets.dart';
import '../utils/screen_util.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  const CommonAppBar({super.key, required this.child});

  @override
  Size get preferredSize => Size.fromHeight(Constant.size100); // Custom height

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorAssets.purple, // Background color set to purple
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), // Rounded bottom-left corner
          bottomRight: Radius.circular(20), // Rounded bottom-right corner
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.all( Constant.size10), // Padding to move child widget up
        child: Align(
          alignment: Alignment.bottomCenter, // Align child at the bottom of the AppBar
          child: child,
        ),
      ),
    );
  }
}