import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_education_level.dart';
import 'package:np_career/enum/enum_nationality.dart';
import 'package:np_career/enum/enum_sex.dart';
import 'package:np_career/enum/enum_type_job.dart';
import 'package:np_career/main.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final MyProfileController controller = Get.put(MyProfileController());
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
        padding: const EdgeInsets.all(15),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                TextField(
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
                                        print(e.name);
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
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "",
                          style: TextStyle(color: AppColor.greenPrimaryColor),
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
                                        print(e.label);
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
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "",
                          style: TextStyle(color: AppColor.greenPrimaryColor),
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
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(8),
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
                                      width: size.width * 0.42,
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
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.42,
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greenPrimaryColor)),
                  height: 200,
                  width: double.infinity,
                  child: Text("Wait"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Security settigns",
                  style: TextStyle(
                      color: AppColor.orangePrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Column(
                  children: [
                    RadioListTile<bool>(
                      activeColor: AppColor.greenPrimaryColor,
                      value: true,
                      groupValue: controller.isSharing,
                      onChanged: (value) {
                        setState(() {
                          controller.isSharing = value;
                        });
                      },
                      title: Text('Share my profile'),
                      subtitle: Text(
                        'Employers can view my profile and contact me about potential job opportunities.',
                      ),
                    ),
                    RadioListTile<bool>(
                      activeColor: AppColor.greenPrimaryColor,
                      value: false,
                      groupValue: controller.isSharing,
                      onChanged: (value) {
                        setState(() {
                          controller.isSharing = value;
                        });
                      },
                      title: Text('Do not share my profile'),
                      subtitle: Text(
                        'My profile is only visible to employers when I apply for jobs directly.',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: Text("Resume"),
                  ),
                  maxLines: 5,
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
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
                              onPressed: () {},
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
