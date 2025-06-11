import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CVWebView extends StatefulWidget {
  @override
  _CVWebViewState createState() => _CVWebViewState();
}

class _CVWebViewState extends State<CVWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse(
          'https://www.topcv.vn/huong-dan-viet-cv-chi-tiet-theo-nganh'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            "Resume Writing Guide",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
