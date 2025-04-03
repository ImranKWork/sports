import 'package:flutter/material.dart';

import '../source/color_assets.dart';
import '../utils/screen_util.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height; // Add a height parameter

  const CommonAppBar({
    super.key,
    required this.child,
    this.height = 100, // Default height if not provided
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Uses the provided height
      child: Container(
        decoration: BoxDecoration(
          color: ColorAssets.purple,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constant.size10),
          child: Align(alignment: Alignment.bottomCenter, child: child),
        ),
      ),
    );
  }
}
