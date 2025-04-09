import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/cv_input/cv_input_no1_controller.dart';
import 'package:np_career/enum/enum_sex.dart';

class CvInputNo1 extends StatefulWidget {
  const CvInputNo1({super.key});

  @override
  State<CvInputNo1> createState() => _CvInputNo1State();
}

class _CvInputNo1State extends State<CvInputNo1> {
  final CvInputNo1Controller controller = Get.put(CvInputNo1Controller());

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
        actions: [
          IconButton(
            onPressed: () {},
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
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.greenPrimaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppColor.greenPrimaryColor,
                      size: 50,
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
                const SizedBox(height: 10),
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
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: EnumSex.values.map((EnumSex sex) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectSex.value = sex.name;
                                      controller.choiceSex.value =
                                          !controller.choiceSex.value;
                                    },
                                    child: Container(
                                      width: 100,
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
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
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
                            "SKILLS",
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
                        itemCount: controller.listSkill.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.greenPrimaryColor,
                                        width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.47,
                                      child: TextField(
                                        controller: controller.listSkill[index]
                                            ['name'] as TextEditingController,
                                        style: TextStyle(
                                          color: AppColor.greenPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            label: Text("Name")),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: size.width * 0.21,
                                      child: TextField(
                                        controller: controller.listSkill[index]
                                                ['indicator']
                                            as TextEditingController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: AppColor.greenPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            label: Text("Index")),
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
                                  controller.addRowSkill();
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
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.orangePrimaryColor, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => controller.removeRowKnowledge(index),
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
                                  controller: controller.listKnowledge[index]
                                      ['school'] as TextEditingController,
                                  style: TextStyle(
                                    color: AppColor.greenPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration:
                                      InputDecoration(label: Text("School")),
                                ),
                              ),
                              SizedBox(width: 15),
                              SizedBox(
                                width: size.width * 0.42,
                                child: TextField(
                                  controller: controller.listKnowledge[index]
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
                                        (controller.listKnowledge[index]['list']
                                                as RxList<
                                                    TextEditingController>)
                                            .length;
                                    i++)
                                  Column(
                                    children: [
                                      TextField(
                                        controller: controller
                                            .listKnowledge[index]['list'][i],
                                        decoration: InputDecoration(
                                          labelText: "Detail ${i + 1}",
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              controller
                                                  .removeDetailFromKnowledge(
                                                      index, i);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
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
                                      onPressed: () =>
                                          controller.addDetailToListK(index),
                                      child: Text(
                                        "ADD DETAIL",
                                        style: TextStyle(
                                          color: AppColor.lightBackgroundColor,
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
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.orangePrimaryColor, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () =>
                                  controller.removeRowActivities(index),
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
                                  controller: controller.listActivities[index]
                                      ['name'] as TextEditingController,
                                  style: TextStyle(
                                    color: AppColor.greenPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration:
                                      InputDecoration(label: Text("Name")),
                                ),
                              ),
                              SizedBox(width: 15),
                              SizedBox(
                                width: size.width * 0.42,
                                child: TextField(
                                  controller: controller.listActivities[index]
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
                                        controller: controller
                                            .listActivities[index]['list'][i],
                                        decoration: InputDecoration(
                                          labelText: "Detail ${i + 1}",
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              controller
                                                  .removeDetailFromActivities(
                                                      index, i);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
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
                                      onPressed: () =>
                                          controller.addDetailToListA(index),
                                      child: Text(
                                        "ADD DETAIL",
                                        style: TextStyle(
                                          color: AppColor.lightBackgroundColor,
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
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.greenPrimaryColor,
                                        width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.47,
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
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: size.width * 0.21,
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
                                        width: size.width * 0.47,
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
                                      SizedBox(width: 8),
                                      SizedBox(
                                        width: size.width * 0.21,
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
