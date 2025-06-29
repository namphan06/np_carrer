import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/cv_no1/cv_input_no1/cv_input_no1.dart';
import 'package:np_career/enum/enum_cv_input.dart';
import 'package:np_career/model/cv_model.dart';
// import 'package:np_career/resume_management/resume_management_controller.dart';
// import 'package:np_career/resume_management/resume_management_fb.dart';
import 'package:np_career/utils/image_uploader.dart';
import 'package:np_career/view/not_found/not_found.dart';
import 'package:np_career/view/pdf_viewr.dart';
import 'package:np_career/view/user/resume_management/resume_management_controller.dart';
import 'package:np_career/view/user/resume_management/resume_management_fb.dart';

class ResumeManagementScreen extends StatefulWidget {
  const ResumeManagementScreen({super.key});

  @override
  State<ResumeManagementScreen> createState() => _ResumeManagementScreenState();
}

class _ResumeManagementScreenState extends State<ResumeManagementScreen> {
  final ResumeManagementController controller =
      Get.put(ResumeManagementController());
  final ResumeManagementFb controllerFb = Get.put(ResumeManagementFb());

  // final handler = GoogleDriveHandler();

  // void onUploadButtonPressed(BuildContext context) async {
  //   final imageLink = await handler.pickImageFromGoogleDrive(context);
  //   if (imageLink != null && imageLink.isNotEmpty) {
  //     print('Đường dẫn ảnh đã chọn: $imageLink');
  //     // Xử lý tiếp với đường dẫn ảnh ở đây
  //   } else {
  //     print('Người dùng chưa chọn ảnh hoặc hủy.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            "Resume Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(Padding(
                  padding: const EdgeInsets.only(top: 145),
                  child: Dialog(
                    insetPadding: EdgeInsets.zero,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select cv",
                              style: TextStyle(
                                  color: AppColor.greenPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (value) => controller
                                  .searchQuery.value = value.toLowerCase(),
                              decoration: InputDecoration(
                                hintText: 'Search cv...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: controllerFb.getListCv(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Center(
                                    child: NoFoundWidget(),
                                  );
                                }

                                var data = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                var cvs = data["cvs"];

                                if (cvs == null || !(cvs is List)) {
                                  return Center(
                                    child: NoFoundWidget(),
                                  );
                                }

                                return Obx(() {
                                  var filteredCvs = cvs.where((e) {
                                    var cv = e as Map<String, dynamic>;
                                    var position = (cv["position"] ?? "")
                                        .toString()
                                        .toLowerCase();
                                    var query = controller.searchQuery.value
                                        .toLowerCase();
                                    return cv["type"] != "upload" &&
                                        position.contains(query);
                                  }).toList();
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      height: size.height * 0.45,
                                      child: ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        itemCount: filteredCvs.length,
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          thickness: 1,
                                          color: AppColor.lightTextColor
                                              .withOpacity(0.5),
                                          indent: 15,
                                          endIndent: 15,
                                        ),
                                        itemBuilder: (context, index) {
                                          var cv = filteredCvs[index];
                                          return InkWell(
                                            onTap: () {
                                              controller.selectedPosition
                                                  .value = cv["position"];
                                              Get.back();
                                            },
                                            child: Card(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              elevation: 5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Row(
                                                  children: [
                                                    // Thêm một biểu tượng nếu cần
                                                    Icon(
                                                      Icons
                                                          .assignment_ind, // Biểu tượng CV
                                                      color: AppColor
                                                          .greenPrimaryColor,
                                                      size: 30,
                                                    ),
                                                    SizedBox(width: 12),
                                                    Expanded(
                                                      child: Text(
                                                        cv["position"] ??
                                                            "Unnamed CV",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis, // Đảm bảo không bị tràn chữ
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: AppColor
                                                          .greenPrimaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
              },
              child: Container(
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
                : build_upload(size))
          ],
        ),
      ),
    );
  }

  Widget build_np_careers() {
    return Expanded(
      child: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
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

            return Obx(() {
              var filteredCvs = cvs.where((e) {
                var cv = e as Map<String, dynamic>;
                var position = (cv["position"] ?? "").toString().toLowerCase();
                var query = controller.selectedPosition.value.toLowerCase();
                return cv["type"] != "upload" && position.contains(query);
              }).toList();

              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: filteredCvs.map<Widget>((e) {
                    return GestureDetector(
                      onTap: () => controller.getCv(e['id'], e['type']),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.greenPrimaryColor, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: AppColor.orangePrimaryColor.withOpacity(0.66),
                        ),
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
                                  GestureDetector(
                                    onTap: () async {
                                      var model = await controllerFb.getCvModel(
                                          e['id'], e['type']);
                                      // if (e['typeInput'] == 'no1') {
                                      //   Get.to(CvInputNo1(), arguments: {
                                      //     'model': model,
                                      //     'type': e['type'],
                                      //     'option': 'update'
                                      //   });
                                      // }
                                      EnumCvInput.cv_input.run(e['typeInput'],
                                          e['type'], 'update', model);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.greenPrimaryColor,
                                              width: 3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: AppColor.greyColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              color: AppColor.greenPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () => Get.defaultDialog(
                                      title: "Delete Confirmation",
                                      titleStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      middleText:
                                          "Are you sure you want to delete this job post?",
                                      middleTextStyle: TextStyle(fontSize: 16),
                                      backgroundColor: Colors.white,
                                      radius: 10,
                                      textConfirm: "Yes, delete",
                                      textCancel: "Cancel",
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors.redAccent,
                                      cancelTextColor: Colors.grey[700],
                                      onConfirm: () async {
                                        Get.back();
                                        await controllerFb.deleteCvNo1(
                                            e['id'], e['type']);
                                      },
                                      onCancel: () {},
                                      content: Column(
                                        children: [
                                          Icon(Icons.warning_amber_rounded,
                                              color: Colors.red, size: 48),
                                          const SizedBox(height: 10),
                                          Text(
                                            "This action cannot be undone.",
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.greenPrimaryColor,
                                              width: 3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.redAccent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              color:
                                                  AppColor.lightBackgroundColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget build_upload(Size size) {
    return Expanded(
      child: Column(
        children: [
          // Vùng cuộn nội dung
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: controllerFb.getListCv(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text("No CVs found"));
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;
                var cvs = data["cvs"];

                if (cvs == null || !(cvs is List)) {
                  return Center(child: Text("No CVs available"));
                }

                return FutureBuilder<List<Map<String, dynamic>>>(
                  // Dữ liệu bất đồng bộ, lấy link cho mỗi CV
                  future: controller.getCvsWithLinks(cvs),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!futureSnapshot.hasData ||
                        futureSnapshot.data!.isEmpty) {
                      return Center(child: Text("No matching CVs found"));
                    }

                    var filteredCvs = futureSnapshot.data!;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: filteredCvs.map<Widget>((e) {
                          return GestureDetector(
                            onTap: () => Get.to(PdfViewrScreen(
                                pdfLink: e['link'], position: e["position"])),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greenPrimaryColor,
                                    width: 3),
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.orangePrimaryColor
                                    .withOpacity(0.66),
                              ),
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
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: AppColor.greyColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: AppColor.lightBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Center(
                        child: Text(
                          "Enter Image Link",
                          style: TextStyle(
                            color: AppColor.orangePrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: controller.linkController,
                              style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                labelText: "Image Link",
                                labelStyle: TextStyle(
                                    color: AppColor.greenPrimaryColor),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: controller.positionController,
                              style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                labelText: "Position",
                                labelStyle: TextStyle(
                                    color: AppColor.greenPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actionsPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Get.back(),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: AppColor.lightBackgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.greenPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              controller.uploadCv();
                              Get.back();
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: AppColor.lightBackgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.greenPrimaryColor),
                  child: Icon(
                    Icons.upload_file,
                    color: AppColor.orangePrimaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
