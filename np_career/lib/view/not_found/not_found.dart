import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoFoundWidget extends StatelessWidget {
  const NoFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/no_data.json',
          width: 200,
          repeat: false,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
