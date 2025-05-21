import 'package:flutter/material.dart';
import 'package:np_career/model/cv_model_v3.dart';

class Cv3Output extends StatefulWidget {
  final CvModelV3 model;
  const Cv3Output({super.key, required this.model});

  @override
  State<Cv3Output> createState() => _Cv3OutputState();
}

class _Cv3OutputState extends State<Cv3Output> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Cv3"),
      ),
    );
  }
}
