import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/cv_no1/cv_input_no2/cv_input_no2_controller.dart';
import 'package:np_career/cv_template/cv2/cv2_output.dart';
import 'package:np_career/cv_template/cv_setting/cv_setting_no1.dart';
import 'package:np_career/model/cv_model_v2.dart';
// import 'package:np_career/resume_management/resume_management_screen.dart';
import 'package:np_career/view/user/build_your_resume/by_style/resume_by_style.dart';
import 'package:np_career/view/user/resume_management/resume_management_screen.dart';

class CvInputNo2 extends StatefulWidget {
  const CvInputNo2({super.key});

  @override
  State<CvInputNo2> createState() => _CvInputNo2State();
}

class _CvInputNo2State extends State<CvInputNo2> {
  final CvInputNo2Controller controller = Get.put(CvInputNo2Controller());
  final CvSettingNo1 cvSettingNo1 = Get.put(CvSettingNo1());

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
            controller.choiceType.value.toUpperCase(),
            style: TextStyle(color: AppColor.greenPrimaryColor),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text(
                  "Would you like to save the CV",
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: AppColor.lightBackgroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        print(
                            "===> optionAction: '${controller.optionAction.value}'");

                        if (controller.optionAction.value == 'save') {
                          print("===> Save block");
                          await controller.addCv(
                              controller.choiceType.value, 'no2');
                          Get.back();
                          Get.off(ResumeByStyle());
                        } else if (controller.optionAction.value == 'update') {
                          print("===> Update block");
                          await controller
                              .updateCv(controller.choiceType.value);
                          Get.back();
                          Get.back();
                          Get.off(ResumeManagementScreen());
                        } else {
                          print(
                              "===> Unknown option: ${controller.optionAction.value}");
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: AppColor.lightBackgroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ));
            },
            icon: SvgPicture.asset(
              "assets/icon/download.svg",
              width: 30,
              height: 30,
              color: AppColor.lightBackgroundColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.02),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      await controller.uploadFile(result);
                    } else {
                      print("No file selected.");
                    }
                  },

                  //  Get.dialog(AlertDialog(
                  //   backgroundColor: AppColor.lightBackgroundColor,
                  //   title: Text(
                  //     "Enter image link",
                  //     style: TextStyle(
                  //         color: AppColor.orangePrimaryColor,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  //   content: TextField(
                  //     controller: controller.linkImgController,
                  //     style: TextStyle(
                  //         color: AppColor.greenPrimaryColor,
                  //         fontWeight: FontWeight.bold),
                  //     decoration: InputDecoration(label: Text("Link")),
                  //   ),
                  //   actions: [
                  //     SizedBox(
                  //       width: 100,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           Get.back();
                  //         },
                  //         child: Text(
                  //           "Cancel",
                  //           style: TextStyle(
                  //               color: AppColor.lightBackgroundColor,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 100,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           controller.imageUrl.value =
                  //               controller.linkImgController.text;
                  //           Get.back();
                  //         },
                  //         child: Text(
                  //           "Submit",
                  //           style: TextStyle(
                  //               color: AppColor.lightBackgroundColor,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greenPrimaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: controller.imageUrl.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.add,
                              color: AppColor.greenPrimaryColor,
                              size: 50,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              cvSettingNo1
                                  .getImageUrl(controller.imageUrl.value),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.fullNameController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Full Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.positionController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(labelText: "Position"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.phoneNumberController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.emailController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.addressController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Address",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.websiteController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Website",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.occupationalGoalsController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Occupational goals",
                  ),
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.tasteController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Taste",
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "SKILL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.orangePrimaryColor,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.addRowSkill();
                              },
                              child: Text(
                                "ADD ROW",
                                style: TextStyle(
                                    color: AppColor.lightBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listSkill.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(size.width * 0.02),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.orangePrimaryColor,
                                    width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.removeRowSkill(index),
                                    child: Container(
                                      margin: EdgeInsets.all(size.width * 0.02),
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.orangeRedColor),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: AppColor.lightBackgroundColor,
                                        weight: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextField(
                                    controller: controller.listSkill[index]
                                        ['name'] as TextEditingController,
                                    style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration:
                                        InputDecoration(label: Text("Name")),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      for (int i = 0;
                                          i <
                                              (controller.listSkill[index]
                                                      ['list'] as RxList)
                                                  .length;
                                          i++)
                                        Column(
                                          children: [
                                            TextField(
                                              controller: controller
                                                  .listSkill[index]['list'][i],
                                              decoration: InputDecoration(
                                                labelText: "Detail ${i + 1}",
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .removeDetailFromSkill(
                                                            index, i);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey[300],
                                                    ),
                                                    child: const Icon(
                                                        Icons.close,
                                                        size: 20),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (val) => controller
                                                  .updateDetailInListS(
                                                      index, i, val),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      const SizedBox(height: 5),
                                      Center(
                                        child: SizedBox(
                                          width: size.width * 0.5,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller
                                                  .addDetailToListS(index);
                                            },
                                            child: const Text(
                                              "ADD DETAIL",
                                              style: TextStyle(
                                                color: AppColor
                                                    .lightBackgroundColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "WORK EXPERIENCE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.orangePrimaryColor,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.addRowWorkExperience();
                              },
                              child: Text(
                                "ADD ROW",
                                style: TextStyle(
                                    color: AppColor.lightBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listWorkExperience.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(size.width * 0.02),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.orangePrimaryColor,
                                    width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () => controller
                                        .removeRowWorkExperience(index),
                                    child: Container(
                                      margin: EdgeInsets.all(size.width * 0.02),
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.orangeRedColor),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: AppColor.lightBackgroundColor,
                                        weight: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.435,
                                      child: TextField(
                                        controller:
                                            controller.listWorkExperience[index]
                                                    ['company']
                                                as TextEditingController,
                                        style: TextStyle(
                                          color: AppColor.greenPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            label: Text("Company")),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.435,
                                      child: TextField(
                                        controller: controller
                                                .listWorkExperience[index]
                                            ['date'] as TextEditingController,
                                        style: TextStyle(
                                          color: AppColor.greenPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            label: Text("Date")),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: TextField(
                                    controller: controller
                                            .listWorkExperience[index]
                                        ['position'] as TextEditingController,
                                    style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                        label: Text("Position")),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      for (int i = 0;
                                          i <
                                              (controller.listWorkExperience[
                                                      index]['list'] as RxList)
                                                  .length;
                                          i++)
                                        Column(
                                          children: [
                                            TextField(
                                              controller: controller
                                                      .listWorkExperience[index]
                                                  ['list'][i],
                                              decoration: InputDecoration(
                                                labelText: "Detail ${i + 1}",
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .removeDetailFromWorkExperience(
                                                            index, i);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey[300],
                                                    ),
                                                    child: const Icon(
                                                        Icons.close,
                                                        size: 20),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (val) =>
                                                  controller.updateDetailInList(
                                                      index, i, val),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      const SizedBox(height: 5),
                                      Center(
                                        child: SizedBox(
                                          width: size.width * 0.5,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.addDetailToList(index);
                                            },
                                            child: const Text(
                                              "ADD DETAIL",
                                              style: TextStyle(
                                                color: AppColor
                                                    .lightBackgroundColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "KNOWLEDGE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.orangePrimaryColor,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.addRowKnowledge();
                              },
                              child: Text(
                                "ADD ROW",
                                style: TextStyle(
                                    color: AppColor.lightBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.listKnowledge.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(size.width * 0.02),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.orangePrimaryColor, width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () =>
                                      controller.removeRowKnowledge(index),
                                  child: Container(
                                    margin: EdgeInsets.all(size.width * 0.02),
                                    padding: EdgeInsets.all(size.width * 0.02),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.orangeRedColor),
                                    child: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: AppColor.lightBackgroundColor,
                                      weight: 5,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: TextField(
                                  controller: controller.listKnowledge[index]
                                      ['name'] as TextEditingController,
                                  style: TextStyle(
                                    color: AppColor.greenPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration:
                                      InputDecoration(label: Text("Name")),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.435,
                                    child: TextField(
                                      controller: controller
                                              .listKnowledge[index]['school']
                                          as TextEditingController,
                                      style: TextStyle(
                                        color: AppColor.greenPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                          label: Text("School")),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  SizedBox(
                                    width: size.width * 0.435,
                                    child: TextField(
                                      controller:
                                          controller.listKnowledge[index]
                                              ['date'] as TextEditingController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: AppColor.greenPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration:
                                          InputDecoration(label: Text("Date")),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Obx(
                                () => Column(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            (controller.listKnowledge[index]
                                                        ['list']
                                                    as RxList<
                                                        TextEditingController>)
                                                .length;
                                        i++)
                                      Column(
                                        children: [
                                          TextField(
                                            controller:
                                                controller.listKnowledge[index]
                                                    ['list'][i],
                                            decoration: InputDecoration(
                                              labelText: "Detail ${i + 1}",
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .removeDetailFromKnowledge(
                                                          index, i);
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: const Icon(Icons.close,
                                                      size: 20),
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) =>
                                                controller.updateDetailInListK(
                                              index,
                                              i,
                                              val,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: SizedBox(
                                        width: size.width * 0.5,
                                        child: ElevatedButton(
                                          onPressed: () => controller
                                              .addDetailToListK(index),
                                          child: Text(
                                            "ADD DETAIL",
                                            style: TextStyle(
                                              color:
                                                  AppColor.lightBackgroundColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ACTIVITIES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.orangePrimaryColor,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.addRowActivities();
                              },
                              child: Text(
                                "ADD ROW",
                                style: TextStyle(
                                    color: AppColor.lightBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.listActivities.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(size.width * 0.02),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.orangePrimaryColor, width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () =>
                                      controller.removeRowActivities(index),
                                  child: Container(
                                    margin: EdgeInsets.all(size.width * 0.02),
                                    padding: EdgeInsets.all(size.width * 0.02),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.orangeRedColor),
                                    child: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: AppColor.lightBackgroundColor,
                                      weight: 5,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.435,
                                    child: TextField(
                                      controller:
                                          controller.listActivities[index]
                                              ['name'] as TextEditingController,
                                      style: TextStyle(
                                        color: AppColor.greenPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration:
                                          InputDecoration(label: Text("Name")),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  SizedBox(
                                    width: size.width * 0.435,
                                    child: TextField(
                                      controller:
                                          controller.listActivities[index]
                                              ['date'] as TextEditingController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: AppColor.greenPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration:
                                          InputDecoration(label: Text("Date")),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: controller.listActivities[index]
                                    ['position'] as TextEditingController,
                                style: TextStyle(
                                  color: AppColor.greenPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  label: Text("Position"),
                                ),
                              ),
                              SizedBox(height: 10),
                              Obx(
                                () => Column(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            (controller.listActivities[index]
                                                        ['list']
                                                    as RxList<
                                                        TextEditingController>)
                                                .length;
                                        i++)
                                      Column(
                                        children: [
                                          TextField(
                                            controller:
                                                controller.listActivities[index]
                                                    ['list'][i],
                                            decoration: InputDecoration(
                                              labelText: "Detail ${i + 1}",
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .removeDetailFromActivities(
                                                          index, i);
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: const Icon(Icons.close,
                                                      size: 20),
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) =>
                                                controller.updateDetailInListA(
                                              index,
                                              i,
                                              val,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: SizedBox(
                                        width: size.width * 0.5,
                                        child: ElevatedButton(
                                          onPressed: () => controller
                                              .addDetailToListA(index),
                                          child: Text(
                                            "ADD DETAIL",
                                            style: TextStyle(
                                              color:
                                                  AppColor.lightBackgroundColor,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.orangePrimaryColor, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Award",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColor.orangePrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.listAward.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(size.width * 0.02),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.greenPrimaryColor,
                                        width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.46,
                                      child: TextField(
                                        controller: controller.listAward[index]
                                            ['name'] as TextEditingController,
                                        style: TextStyle(
                                          color: AppColor.greenPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            label: Text("Name")),
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    SizedBox(
                                      width: size.width * 0.22,
                                      child: TextField(
                                        controller: controller.listAward[index]
                                            ['date'] as TextEditingController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: AppColor.greenPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            label: Text("Date")),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () =>
                                            controller.removeRowAward(index),
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColor.orangeRedColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: const Icon(
                                            Icons.close,
                                            size: 20,
                                            color:
                                                AppColor.lightBackgroundColor,
                                            weight: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                            width: size.width * 0.5,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.addRowAward();
                                },
                                child: Text(
                                  "ADD ROW",
                                  style: TextStyle(
                                      color: AppColor.lightBackgroundColor,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.all(size.width * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.orangePrimaryColor, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Certificate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColor.orangePrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.listCertificate.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.greenPrimaryColor,
                                          width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.46,
                                        child: TextField(
                                          controller: controller
                                                  .listCertificate[index]
                                              ['name'] as TextEditingController,
                                          style: TextStyle(
                                            color: AppColor.greenPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                              label: Text("Name")),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      SizedBox(
                                        width: size.width * 0.22,
                                        child: TextField(
                                          controller: controller
                                                  .listCertificate[index]
                                              ['date'] as TextEditingController,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            color: AppColor.greenPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                              label: Text("Date")),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () => controller
                                              .removeRowCertificate(index),
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: AppColor.orangeRedColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: const Icon(
                                              Icons.close,
                                              size: 20,
                                              color:
                                                  AppColor.lightBackgroundColor,
                                              weight: 5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SizedBox(
                              width: size.width * 0.5,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.addRowCertificate();
                                  },
                                  child: Text(
                                    "ADD ROW",
                                    style: TextStyle(
                                        color: AppColor.lightBackgroundColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.moreInformationController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "More Information",
                  ),
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.introducerController,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Introducer",
                  ),
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      CvModelV2 cv = await controller
                          .getCvModel(controller.choiceType.value);
                      Get.to(Cv2Output(model: cv));
                    },
                    child: Text(
                      "Preview Cv",
                      style: TextStyle(
                          color: AppColor.lightBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
