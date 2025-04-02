import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final Function() onClick;

  final String? image;
  final FontWeight fontWeight;

  const CommonButton({super.key,
    required this.label,
    required this.onClick,
    this.image,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorAssets.themeColorOrange),
        minimumSize: WidgetStateProperty.all(Size(1, 54)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constant.size8)),
        ),
      ),
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(label, style:
        Styles.textStyleWhiteSemiBold.copyWith(fontSize: FontSize.s14),)],
      ),
    );
  }
}
