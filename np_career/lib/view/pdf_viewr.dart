import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewrScreen extends StatelessWidget {
  final String pdfLink;
  final String position;
  const PdfViewrScreen({
    super.key,
    required this.pdfLink,
    required this.position,
  });

  String getFixedGoogleDriveLink(String url) {
    final regex = RegExp(r'/d/([^/]+)');
    final match = regex.firstMatch(url);
    if (match != null) {
      final id = match.group(1);
      return 'https://drive.google.com/uc?export=download&id=$id';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final fixedLink = getFixedGoogleDriveLink(pdfLink);

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
            position,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: SfPdfViewer.network(
        fixedLink,
        onDocumentLoadFailed: (details) {
          print('PDF Load Failed: ${details.description}');
        },
      ),
    );
  }
}
