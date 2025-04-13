import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/resume_management/resume_management_controller.dart';
import 'package:np_career/resume_management/resume_management_fb.dart';

class ResumeManagementScreen extends StatefulWidget {
  const ResumeManagementScreen({super.key});

  @override
  State<ResumeManagementScreen> createState() => _ResumeManagementScreenState();
}

class _ResumeManagementScreenState extends State<ResumeManagementScreen> {
  final ResumeManagementController controller =
      Get.put(ResumeManagementController());
  final ResumeManagementFb controllerFb = Get.put(ResumeManagementFb());
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
            )),
        title: Center(
          child: Text(
            "Resume Management",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.lightBackgroundColor),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColor.greenPrimaryColor, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search ...",
                    style: TextStyle(
                        color: AppColor.greenPrimaryColor, fontSize: 20),
                  ),
                  Icon(
                    Icons.search,
                    color: AppColor.greenPrimaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Obx(() {
              return Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.selectChoice.value = "np";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: controller.selectChoice.value == "np"
                                        ? AppColor.greenPrimaryColor
                                        : AppColor.greyColor,
                                    width: 2))),
                        child: Text(
                          "CV NP Careers",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: controller.selectChoice.value == "np"
                                  ? AppColor.greenPrimaryColor
                                  : AppColor.greyColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        controller.selectChoice.value = "upload";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: controller.selectChoice.value ==
                                            "upload"
                                        ? AppColor.greenPrimaryColor
                                        : AppColor.greyColor,
                                    width: 2))),
                        child: Text(
                          "CV Upload",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: controller.selectChoice.value == "upload"
                                  ? AppColor.greenPrimaryColor
                                  : AppColor.greyColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ],
              );
            }),
            SizedBox(
              height: 15,
            ),
            Obx(() => controller.selectChoice.value == "np"
                ? build_np_careers()
                : build_upload())
          ],
        ),
      ),
    );
  }

  Widget build_np_careers() {
    return Column(
      children: [
        StreamBuilder<DocumentSnapshot>(
          stream: controllerFb.getListCv(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text("No CVs found");
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            var cvs = data["cvs"];

            if (cvs == null || !(cvs is List)) {
              return Text("No CVs available");
            }

            var filteredCvs = cvs.where((e) => e["type"] != "upload").toList();

            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: filteredCvs
                    .map<Widget>((e) => GestureDetector(
                          onTap: () => controller.getCv(e['id'], e['type']),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greenPrimaryColor,
                                    width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: AppColor.orangePrimaryColor
                                    .withOpacity(0.66)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Position : ${e["position"] ?? ''}",
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Type : ${e["type"] ?? ''}",
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${e["id"] ?? ''}",
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    AppColor.greenPrimaryColor,
                                                width: 3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: AppColor.greyColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                                color:
                                                    AppColor.greenPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    AppColor.greenPrimaryColor,
                                                width: 3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.redAccent),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: AppColor
                                                    .lightBackgroundColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          },
        )
      ],
    );
  }

  Widget build_upload() {
    return Center(
      child: Text("Upload"),
    );
  }
}
