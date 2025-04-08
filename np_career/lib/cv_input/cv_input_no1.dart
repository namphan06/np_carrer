import 'package:flutter/material.dart';
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
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Full Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
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
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Address",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
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
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TextField(
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Name")),
                                  onChanged: (value) =>
                                      controller.updateNameSkill(index, value),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Indicator")),
                                  onChanged: (value) => controller
                                      .updateIndicatorSkill(index, value),
                                ),
                              )
                            ],
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
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.45,
                                child: TextField(
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Company")),
                                  onChanged: (value) =>
                                      controller.updateCompanyWorkExperience(
                                          index, value),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.45,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Date")),
                                  onChanged: (value) => controller
                                      .updateDateKnowledge(index, value),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecoration(label: Text("Position")),
                            onChanged: (value) => controller
                                .updatePositionWorkExperience(index, value),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        (controller.listWorkExperience[index]
                                                ['list'] as List)
                                            .length;
                                    i++)
                                  Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            labelText: "Detail ${i + 1}"),
                                        controller: TextEditingController(
                                            text: controller.listWorkExperience[
                                                    index]['list'][i] ??
                                                ""),
                                        onChanged: (val) => controller
                                            .updateDetailInList(index, i, val),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
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
                                          child: Text(
                                            "ADD DETAIL",
                                            style: TextStyle(
                                                color: AppColor
                                                    .lightBackgroundColor,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ),
                              ],
                            ),
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
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.45,
                                child: TextField(
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("School")),
                                  onChanged: (value) => controller
                                      .updateSchoolKnowledge(index, value),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.45,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Date")),
                                  onChanged: (value) => controller
                                      .updateDateKnowledge(index, value),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        (controller.listKnowledge[index]['list']
                                                as List)
                                            .length;
                                    i++)
                                  Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            labelText: "Detail ${i + 1}"),
                                        controller: TextEditingController(
                                            text:
                                                controller.listKnowledge[index]
                                                        ['list'][i] ??
                                                    ""),
                                        onChanged: (val) => controller
                                            .updateDetailInListK(index, i, val),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                const SizedBox(height: 5),
                                Center(
                                  child: SizedBox(
                                      width: size.width * 0.5,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            controller.addDetailToListK(index);
                                          },
                                          child: Text(
                                            "ADD DETAIL",
                                            style: TextStyle(
                                                color: AppColor
                                                    .lightBackgroundColor,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ),
                              ],
                            ),
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
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.45,
                                child: TextField(
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Name")),
                                  onChanged: (value) => controller
                                      .updateNameActivities(index, value),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.45,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Date")),
                                  onChanged: (value) => controller
                                      .updateDateActivities(index, value),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecoration(label: Text("Position")),
                            onChanged: (value) => controller
                                .updatePositionActivities(index, value),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        (controller.listActivities[index]
                                                ['list'] as List)
                                            .length;
                                    i++)
                                  Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            labelText: "Detail ${i + 1}"),
                                        controller: TextEditingController(
                                            text:
                                                controller.listActivities[index]
                                                        ['list'][i] ??
                                                    ""),
                                        onChanged: (val) => controller
                                            .updateDetailInListA(index, i, val),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                const SizedBox(height: 5),
                                Center(
                                  child: SizedBox(
                                      width: size.width * 0.5,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            controller.addDetailToListA(index);
                                          },
                                          child: Text(
                                            "ADD DETAIL",
                                            style: TextStyle(
                                                color: AppColor
                                                    .lightBackgroundColor,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
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
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TextField(
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Name")),
                                  onChanged: (value) =>
                                      controller.updateNameAward(index, value),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Date")),
                                  onChanged: (value) =>
                                      controller.updateDateAward(index, value),
                                ),
                              )
                            ],
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
                SizedBox(
                  height: 20,
                ),
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
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TextField(
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Name")),
                                  onChanged: (value) => controller
                                      .updateNameCertificate(index, value),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(label: Text("Date")),
                                  onChanged: (value) => controller
                                      .updateDateCertificate(index, value),
                                ),
                              )
                            ],
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
                SizedBox(
                  height: 20,
                ),
                TextField(
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
