import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class AnimationButtonCheck extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const AnimationButtonCheck(
      {super.key, required this.value, required this.onChanged});

  @override
  State<AnimationButtonCheck> createState() => _AnimationButtonCheckState();
}

class _AnimationButtonCheckState extends State<AnimationButtonCheck> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 45,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.lightBackgroundColor,
          border: Border.all(color: AppColor.orangePrimaryColor, width: 2),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: widget.value ? 19 : 0, // Di chuyển trái/phải
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.orangePrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
