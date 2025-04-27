import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_city.dart';
import 'package:np_career/enum/enum_education_level.dart';
import 'package:np_career/enum/enum_nationality.dart';
import 'package:np_career/enum/enum_sex.dart';
import 'package:np_career/enum/enum_type_job.dart';
import 'package:np_career/enum/enum_type_job_category.dart';
import 'package:np_career/main.dart';
import 'package:np_career/resume_management/resume_management_controller.dart';
import 'package:np_career/resume_management/resume_management_fb.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_controller.dart';
import 'package:np_career/view/user/profile/profile_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final MyProfileController controller = Get.put(MyProfileController());

  final ResumeManagementController controllerRs =
      Get.put(ResumeManagementController());
  final ResumeManagementFb controllerFb = Get.put(ResumeManagementFb());

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
            )),
        title: Center(
          child: Text(
            "Create Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.lightBackgroundColor),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.02),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                ),
                TextField(
                  controller: controller.fullName,
                  decoration: InputDecoration(
                    label: Text("Full name"),
                  ),
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.phoneNumber,
                  decoration: InputDecoration(
                    label: Text("Phone number"),
                  ),
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "City",
                  style: TextStyle(
                      color: AppColor.orangePrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: AppColor.lightBackgroundColor,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.greenPrimaryColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextField(
                                onChanged: (value) => controller
                                    .searchQuery.value = value.toLowerCase(),
                                decoration: InputDecoration(
                                  hintText: 'Search city...',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Expanded(
                                child: Obx(() {
                                  final filteredList = EnumCity.values
                                      .where((e) => e.label
                                          .toLowerCase()
                                          .contains(
                                              controller.searchQueryC.value))
                                      .toList();
                                  return ListView.separated(
                                    itemCount: filteredList.length,
                                    separatorBuilder: (_, __) =>
                                        Divider(color: Colors.grey[300]),
                                    itemBuilder: (context, index) {
                                      final e = filteredList[index];

                                      return Obx(() {
                                        final isSelectedC = controller.list_city
                                            .contains(e.label);
                                        return InkWell(
                                          onTap: () {
                                            if (isSelectedC) {
                                              controller.list_city
                                                  .remove(e.label);
                                            } else {
                                              controller.list_city.add(e.label);
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: isSelectedC
                                                  ? Colors.orange
                                                      .withOpacity(0.3)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              e.label,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: isSelectedC
                                                    ? Colors.orange
                                                    : Colors.black87,
                                                fontWeight: isSelectedC
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                }),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: AppColor.lightBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.greenPrimaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: controller.list_city
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greenPrimaryColor,
                                    width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: AppColor.greyColor.withOpacity(0.5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  e,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.list_city.remove(e);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                          ),
                        )
                        .toList()),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.address,
                  decoration: InputDecoration(
                    label: Text("Address"),
                  ),
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: AppColor.lightBackgroundColor,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Nationality',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.greenPrimaryColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: EnumNationality.values.length,
                                  separatorBuilder: (_, __) =>
                                      Divider(color: Colors.grey[300]),
                                  itemBuilder: (context, index) {
                                    final e = EnumNationality.values[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.selectedNationality.value =
                                            e.name;
                                        Get.back();
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          e.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedNationality.isNotEmpty
                              ? controller.selectedNationality.value
                              : "Select Nationality",
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: AppColor.lightBackgroundColor,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Education Level',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.greenPrimaryColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: EnumEducationLevel.values.length,
                                  separatorBuilder: (_, __) =>
                                      Divider(color: Colors.grey[300]),
                                  itemBuilder: (context, index) {
                                    final e = EnumEducationLevel.values[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.selectedEducationLevel
                                            .value = e.label;
                                        Get.back();
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          e.label,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedEducationLevel.isNotEmpty
                              ? controller.selectedEducationLevel.value
                              : "Select Education Level",
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    controller.pickDate(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greenPrimaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Text(
                          controller.selectDate.value != null
                              ? controller.selectDate.value!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]
                              : "Date Of Birth",
                          style: TextStyle(
                            color: AppColor.greenPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.choiceSex.value =
                            !controller.choiceSex.value;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.greenPrimaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Text(
                              controller.selectSex.value.isEmpty
                                  ? "Sex"
                                  : controller.selectSex.value,
                              style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              controller.choiceSex.value
                                  ? Icons.arrow_drop_up_outlined
                                  : Icons.arrow_drop_down_outlined,
                              color: AppColor.greenPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    controller.choiceSex.value
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: EnumSex.values.map((EnumSex sex) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectSex.value = sex.name;
                                    controller.choiceSex.value =
                                        !controller.choiceSex.value;
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.greyColor),
                                      ),
                                    ),
                                    child: Text(
                                      sex.name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.hiringReason,
                  decoration: InputDecoration(
                    label: Text("Hiring Reason"),
                  ),
                  maxLines: 5,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
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
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listWorkExperience.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
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
                  height: 10,
                ),
                Text(
                  "Preferred job type",
                  style: TextStyle(
                      color: AppColor.orangePrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: EnumTypeJob.values
                        .map((e) => GestureDetector(
                              onTap: () {
                                if (controller.list_type_job
                                    .contains(e.label)) {
                                  controller.list_type_job.remove(e.label);
                                } else {
                                  controller.list_type_job.add(e.label);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.greenPrimaryColor,
                                      width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color:
                                      controller.list_type_job.contains(e.label)
                                          ? AppColor.orangePrimaryColor
                                          : AppColor.greyColor,
                                ),
                                child: Text(
                                  e.label,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor),
                                ),
                              ),
                            ))
                        .toList()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Job Interests",
                  style: TextStyle(
                      color: AppColor.orangePrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: AppColor.lightBackgroundColor,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Job Interests',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.greenPrimaryColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextField(
                                onChanged: (value) => controller
                                    .searchQuery.value = value.toLowerCase(),
                                decoration: InputDecoration(
                                  hintText: 'Search job category...',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Expanded(
                                child: Obx(() {
                                  final filteredList = EnumTypeJobCategory
                                      .values
                                      .where((e) => e.label
                                          .toLowerCase()
                                          .contains(
                                              controller.searchQuery.value))
                                      .toList();
                                  return ListView.separated(
                                    itemCount: filteredList.length,
                                    separatorBuilder: (_, __) =>
                                        Divider(color: Colors.grey[300]),
                                    itemBuilder: (context, index) {
                                      final e = filteredList[index];

                                      return Obx(() {
                                        final isSelected = controller
                                            .list_type_job_category
                                            .contains(e.label);
                                        return InkWell(
                                          onTap: () {
                                            if (isSelected) {
                                              controller.list_type_job_category
                                                  .remove(e.label);
                                            } else {
                                              controller.list_type_job_category
                                                  .add(e.label);
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Colors.orange
                                                      .withOpacity(0.3)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              e.label,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: isSelected
                                                    ? Colors.orange
                                                    : Colors.black87,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                }),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: AppColor.lightBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.greenPrimaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: controller.list_type_job_category
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greenPrimaryColor,
                                    width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: AppColor.greyColor.withOpacity(0.5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  e,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.list_type_job_category
                                          .remove(e);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                          ),
                        )
                        .toList()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Security settings",
                  style: TextStyle(
                      color: AppColor.orangePrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Column(
                  children: [
                    Obx(
                      () => RadioListTile<bool>(
                        activeColor: AppColor.greenPrimaryColor,
                        value: true,
                        groupValue: controller.isSharing.value,
                        onChanged: (value) {
                          controller.isSharing.value = value;
                        },
                        title: Text('Share my profile'),
                        subtitle: Text(
                          'Employers can view my profile and contact me about potential job opportunities.',
                        ),
                      ),
                    ),
                    Obx(
                      () => RadioListTile<bool>(
                        activeColor: AppColor.greenPrimaryColor,
                        value: false,
                        groupValue: controller.isSharing.value,
                        onChanged: (value) {
                          controller.isSharing.value = value;
                        },
                        title: Text('Do not share my profile'),
                        subtitle: Text(
                          'My profile is only visible to employers when I apply for jobs directly.',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
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
                                      return Text("No CVs found");
                                    }

                                    var data = snapshot.data!.data()
                                        as Map<String, dynamic>;
                                    var cvs = data["cvs"];

                                    if (cvs == null || !(cvs is List)) {
                                      return Text("No CVs available");
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
                                            separatorBuilder:
                                                (context, index) => Divider(
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
                                                  controller.typeCv.value =
                                                      cv['type'];
                                                  controller.idCv.value =
                                                      cv['id'];
                                                  Get.back();
                                                },
                                                child: Card(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  elevation: 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis, // Đảm bảo không bị tràn chữ
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
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
                        border: Border.all(
                            color: AppColor.greenPrimaryColor, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Resume",
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor, fontSize: 20),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (controller.selectedPosition.isNotEmpty)
                  Obx(
                    () => InkWell(
                      onTap: () => controllerRs.getCv(
                          controller.idCv.value, controller.typeCv.value),
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.assignment_ind,
                                color: AppColor.greenPrimaryColor,
                                size: 30,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  controller.selectedPosition.value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: AppColor.greenPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: AppColor.lightBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                      SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.createMyProfile();
                                Get.to(ProfileScreen());
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(
                                    color: AppColor.lightBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
