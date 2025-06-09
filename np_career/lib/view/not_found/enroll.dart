import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Enroll extends StatelessWidget {
  const Enroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/eroll.json',
          width: 200,
          repeat: false,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
