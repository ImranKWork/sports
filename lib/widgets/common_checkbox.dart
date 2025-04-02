import 'package:flutter/material.dart';
import 'package:sports_trending/utils/screen_util.dart';

/// Displaying checkbox only
class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onChanged(!value);
        },
        child: Container(
          height: Constant.size20,
          width:  Constant.size20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
               4
              ),
            ),
            border: Border.all(
              width: 1,
              color: value
                  ? Colors.white
                  : Colors.white,
            ),
          ),
          child: Checkbox(
            checkColor: Colors.orange,
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue);
            },
          ),
        ),
      ),
    );
  }
}