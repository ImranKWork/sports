import 'package:flutter/cupertino.dart';

class CommonImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;

  const CommonImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.color,
    this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      height: height,
      color: color,
      fit: boxFit ?? BoxFit.cover,
    );
  }
}
