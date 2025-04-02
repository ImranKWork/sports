import 'package:flutter/material.dart';

class ImagePageIndicator extends StatefulWidget {
  final PageController controller;
  final int count;

  ImagePageIndicator({required this.controller, required this.count});

  @override
  _ImagePageIndicatorState createState() => _ImagePageIndicatorState();
}

class _ImagePageIndicatorState extends State<ImagePageIndicator> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        currentPage = widget.controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count, (index) {
        bool isActive = index == currentPage;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 18 : 10,
          height: isActive ? 18 : 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.transparent : Colors.grey.shade400,
            image:
                isActive
                    ? DecorationImage(
                      image: AssetImage("assets/images/circle.png"),
                      fit: BoxFit.cover,
                    )
                    : null,
          ),
        );
      }),
    );
  }
}
