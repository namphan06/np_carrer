import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/company/create_job_post/create_job_post_controller.dart';
import 'package:np_career/company/home/home_company.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_city.dart';
import 'package:np_career/enum/enum_currency_unit.dart';
import 'package:np_career/enum/enum_experience.dart';
import 'package:np_career/enum/enum_type_job_category.dart';

class CreateJobPost extends StatefulWidget {
  final String nameCompany;
  const CreateJobPost({super.key, required this.nameCompany});

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
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text(
                  "Would you like to save the jop post",
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
                      onPressed: () {
                        if (controller.optionAction == 'save') {
                          controller.createJobPost(widget.nameCompany);
                        } else if (controller.optionAction == 'update') {
                          controller.updateJobPost(widget.nameCompany);
                        } else {
                          print("Don't have option action");
                        }
                        Get.offAll(HomeCompany());
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
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
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
                        controller: controller.minSalary,
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
                      width: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      child: TextField(
                        controller: controller.maxSalary,
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
                      width: 10,
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
                          width: size.width * 0.27,
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
                                      controller.selectExperience.value =
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
                              controller.listJobDescription[index].value =
                                  value;
                            },
                            onSubmitted: (_) {
                              if (index ==
                                      controller.listJobDescription.length -
                                          1 &&
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
                                  if (controller.listJobDescription.length >
                                      1) {
                                    controller.listJobDescription
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
                              text: controller
                                  .listRequiredApplication[index].value,
                            ),
                            onChanged: (value) {
                              controller.listRequiredApplication[index].value =
                                  value;
                            },
                            onSubmitted: (_) {
                              if (index ==
                                      controller
                                              .listRequiredApplication.length -
                                          1 &&
                                  controller
                                      .listRequiredApplication[index].value
                                      .trim()
                                      .isNotEmpty) {
                                controller.listRequiredApplication
                                    .add(("".obs));
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
                                  if (controller
                                          .listRequiredApplication.length >
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
                TextField(
                  controller: controller.timeWorkController,
                  decoration: InputDecoration(
                      label: Text(
                    "Time Work",
                  )),
                  style: TextStyle(
                      color: AppColor.greenPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
