import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/company/create_job_post/create_job_post_controller.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_city.dart';
import 'package:np_career/enum/enum_currency_unit.dart';
import 'package:np_career/enum/enum_experience.dart';

class CreateJobPost extends StatefulWidget {
  const CreateJobPost({super.key});

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  final CreateJobPostController controller = Get.put(CreateJobPostController());
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
            "Create Job Post",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                    label: Text(
                  "Name",
                )),
                style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Salary",
                style: TextStyle(
                    color: AppColor.orangePrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(label: Text("Min")),
                      style: TextStyle(
                          color: AppColor.greenPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: size.width * 0.3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(label: Text("Max")),
                      style: TextStyle(
                          color: AppColor.greenPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Currency Unit",
                                style: TextStyle(
                                    color: AppColor.greenPrimaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: EnumCurrencyUnit.values.length,
                                  separatorBuilder: (_, __) =>
                                      Divider(color: Colors.grey[300]),
                                  itemBuilder: (context, index) {
                                    final e = EnumCurrencyUnit.values[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.selectCurrencyUnit.value =
                                            e.label;
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
                      ));
                    },
                    child: Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: size.width * 0.26,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.greenPrimaryColor, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.selectCurrencyUnit.value,
                              style: TextStyle(
                                  color: AppColor.greenPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: AppColor.greenPrimaryColor,
                            ),
                          ],
                        ),
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
                  Get.dialog(Dialog(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "City",
                            style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: EnumCity.values.length,
                              separatorBuilder: (_, __) =>
                                  Divider(color: Colors.grey[300]),
                              itemBuilder: (context, index) {
                                final e = EnumCity.values[index];
                                return InkWell(
                                  onTap: () {
                                    controller.selectCity.value = e.label;
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
                  ));
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.greenPrimaryColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectCity.isEmpty
                              ? "City"
                              : controller.selectCity.value,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(Dialog(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "Experience",
                            style: TextStyle(
                                color: AppColor.greenPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: EnumExperience.values.length,
                              separatorBuilder: (_, __) =>
                                  Divider(color: Colors.grey[300]),
                              itemBuilder: (context, index) {
                                final e = EnumExperience.values[index];
                                return InkWell(
                                  onTap: () {
                                    controller.selectExperience.value = e.label;
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
                  ));
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.greenPrimaryColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectExperience.isEmpty
                              ? "Experience"
                              : controller.selectExperience.value,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.greenPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Job Description",
                style: TextStyle(
                  color: AppColor.orangePrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listJobDescription.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: TextEditingController(
                            text: controller.listJobDescription[index].value,
                          ),
                          onChanged: (value) {
                            controller.listJobDescription[index].value = value;
                          },
                          onSubmitted: (_) {
                            if (index ==
                                    controller.listJobDescription.length - 1 &&
                                controller.listJobDescription[index].value
                                    .trim()
                                    .isNotEmpty) {
                              controller.listJobDescription.add(("".obs));
                            }
                          },
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Description ${index + 1}",
                            border: OutlineInputBorder(),
                            isDense: true,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                if (controller.listJobDescription.length > 1) {
                                  controller.listJobDescription.removeAt(index);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Required Application",
                style: TextStyle(
                  color: AppColor.orangePrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listRequiredApplication.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: TextEditingController(
                            text:
                                controller.listRequiredApplication[index].value,
                          ),
                          onChanged: (value) {
                            controller.listRequiredApplication[index].value =
                                value;
                          },
                          onSubmitted: (_) {
                            if (index ==
                                    controller.listRequiredApplication.length -
                                        1 &&
                                controller.listRequiredApplication[index].value
                                    .trim()
                                    .isNotEmpty) {
                              controller.listRequiredApplication.add(("".obs));
                            }
                          },
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Required ${index + 1}",
                            border: OutlineInputBorder(),
                            isDense: true,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                if (controller.listRequiredApplication.length >
                                    1) {
                                  controller.listRequiredApplication
                                      .removeAt(index);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Benefits",
                style: TextStyle(
                  color: AppColor.orangePrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listBenefit.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: TextEditingController(
                            text: controller.listBenefit[index].value,
                          ),
                          onChanged: (value) {
                            controller.listBenefit[index].value = value;
                          },
                          onSubmitted: (_) {
                            if (index == controller.listBenefit.length - 1 &&
                                controller.listBenefit[index].value
                                    .trim()
                                    .isNotEmpty) {
                              controller.listBenefit.add(("".obs));
                            }
                          },
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Benefit ${index + 1}",
                            border: OutlineInputBorder(),
                            isDense: true,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                if (controller.listBenefit.length > 1) {
                                  controller.listBenefit.removeAt(index);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Work Location",
                style: TextStyle(
                  color: AppColor.orangePrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listWorkLocation.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: TextEditingController(
                            text: controller.listWorkLocation[index].value,
                          ),
                          onChanged: (value) {
                            controller.listWorkLocation[index].value = value;
                          },
                          onSubmitted: (_) {
                            if (index ==
                                    controller.listWorkLocation.length - 1 &&
                                controller.listWorkLocation[index].value
                                    .trim()
                                    .isNotEmpty) {
                              controller.listWorkLocation.add(("".obs));
                            }
                          },
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Location ${index + 1}",
                            border: OutlineInputBorder(),
                            isDense: true,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                if (controller.listWorkLocation.length > 1) {
                                  controller.listWorkLocation.removeAt(index);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.applicationDeadlineController,
                decoration: InputDecoration(
                    label: Text(
                  "Application deadline",
                )),
                style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
