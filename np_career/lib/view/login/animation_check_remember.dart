import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class AnimationCheckRemember extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AnimationCheckRemember(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _AnimationCheckRememberState createState() => _AnimationCheckRememberState();
}

class _AnimationCheckRememberState extends State<AnimationCheckRemember> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 30,
        height: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
          border: Border.all(color: AppColor.greenPrimaryColor, width: 2),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: widget.value ? 12 : 0, // Di chuyển trái/phải
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.greenPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
