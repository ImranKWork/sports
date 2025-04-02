import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSvgImages extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final Function()? onTap;

  const CommonSvgImages({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.color,
    this.boxFit, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        image,
        width: width,
        height: height,

        fit: boxFit ?? BoxFit.none,
      ),
    );
  }
}
