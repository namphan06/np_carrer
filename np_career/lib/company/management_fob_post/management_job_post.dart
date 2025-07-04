import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/company/application_apply/application_apply_screen.dart';
import 'package:np_career/company/create_job_post/create_job_post.dart';
import 'package:np_career/company/management_fob_post/management_job_post_controller.dart';
import 'package:np_career/company/management_fob_post/management_job_post_fb.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/not_found/enroll.dart';
import 'package:np_career/view/not_found/not_found.dart';

class ManagementJobPost extends StatefulWidget {
  final String nameCompany;
  const ManagementJobPost({super.key, required this.nameCompany});

  @override
  State<ManagementJobPost> createState() => _ManagementJobPostState();
}

class _ManagementJobPostState extends State<ManagementJobPost> {
  final ManagementJobPostFb _fb = Get.put(ManagementJobPostFb());
  final ManagementJobPostController controller =
      Get.put(ManagementJobPostController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Management Job Post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColor.lightBackgroundColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.90,
            child: Column(
              children: [
                Positioned(
                  top: 0, // hoặc bất kỳ giá trị nào bạn cần
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: AppColor.greenPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.greenPrimaryColor,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColor.greenPrimaryColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                        ),
                        style: TextStyle(
                          color: AppColor.greenPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        onChanged: (value) {
                          controller.inputSearch.value = value;
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.70,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: _fb.getListJobPost(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Enroll());
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Center(child: NoFoundWidget());
                      }

                      final data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      final jobPosts = data['jps'] as List<dynamic>? ?? [];

                      if (jobPosts.isEmpty) {
                        return Center(child: NoFoundWidget());
                      }

                      return Obx(() {
                        final filteredJobs = jobPosts.where((job) {
                          final title =
                              job['name']?.toString().toLowerCase() ?? '';
                          final query =
                              controller.inputSearch.value.toLowerCase();
                          return title.contains(query);
                        }).toList();
                        return ListView.builder(
                          itemCount: filteredJobs.length,
                          itemBuilder: (context, index) {
                            final job =
                                filteredJobs[index] as Map<String, dynamic>;
                            final name = job['name'] ?? 'No name';
                            final companyName =
                                job['nameCompany'] ?? 'No company';
                            final minSalary = job['minSalary'];
                            final maxSalary = job['maxSalary'];
                            final currency = job['currencyUnit'] ?? '';
                            final jobId = job['id'];
                            String salary;
                            final List<RxBool> isExpandedList =
                                controller.createExpandedList(jobPosts.length);

                            if (minSalary == null && maxSalary == null) {
                              salary = "Negotiable";
                            } else if (minSalary != null && maxSalary != null) {
                              salary = "$minSalary - $maxSalary $currency";
                            } else if (minSalary != null) {
                              salary = "$minSalary $currency";
                            } else {
                              salary = "$maxSalary $currency";
                            }

                            final city = job['city'] as List<dynamic>? ?? [];
                            String cityText = '';

                            if (city.isNotEmpty) {
                              if (city.length > 1) {
                                cityText = '${city[0]} +${city.length - 1}';
                              } else {
                                cityText = city.join(', ');
                              }
                            }

                            return Obx(
                              () => AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColor.orangePrimaryColor
                                      .withOpacity(0.66),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(0, 4),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColor.greenPrimaryColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Company: $companyName",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: AppColor.greyColor
                                                        .withOpacity(0.8),
                                                  ),
                                                  child: Text(
                                                    salary,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor
                                                          .greenPrimaryColor
                                                          .withOpacity(0.9),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: AppColor.greyColor
                                                        .withOpacity(0.8),
                                                  ),
                                                  child: Text(
                                                    cityText,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor
                                                          .greenPrimaryColor
                                                          .withOpacity(0.9),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        height: isExpandedList[index].value
                                            ? 160
                                            : 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: AppColor.greenPrimaryColor,
                                              width: 2),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: isExpandedList[index].value
                                              ? [
                                                  Expanded(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      onPressed: () {
                                                        Get.defaultDialog(
                                                          title:
                                                              "Delete Confirmation",
                                                          titleStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                          middleText:
                                                              "Are you sure you want to delete this job post?",
                                                          middleTextStyle:
                                                              TextStyle(
                                                                  fontSize: 16),
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          textConfirm:
                                                              "Yes, delete",
                                                          textCancel: "Cancel",
                                                          confirmTextColor:
                                                              Colors.white,
                                                          buttonColor:
                                                              Colors.redAccent,
                                                          cancelTextColor:
                                                              Colors.grey[700],
                                                          onConfirm: () async {
                                                            Get.back();
                                                            await _fb
                                                                .deleteJobPost(
                                                                    jobId);
                                                          },
                                                          onCancel: () {},
                                                          content: Column(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .warning_amber_rounded,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 48),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                "This action cannot be undone.",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: Colors.orange,
                                                      ),
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      onPressed: () {
                                                        Get.to(
                                                            CreateJobPost(
                                                                nameCompany:
                                                                    companyName),
                                                            arguments: {
                                                              'type': 'update',
                                                              'jobId': jobId,
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconButton(
                                                      icon: Icon(Icons.person,
                                                          color: Colors.blue),
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      onPressed: () {
                                                        Get.to(
                                                            ApplicationApplyScreen(
                                                          jobId: job['id'],
                                                          jobName: job['name'],
                                                        ));
                                                        isExpandedList[index]
                                                            .value = false;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        isExpandedList[index]
                                                            .value = false;
                                                      },
                                                      child: Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                            color: AppColor
                                                                .greenPrimaryColor,
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                              : [
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        isExpandedList[index]
                                                            .value = true;
                                                      },
                                                      child: Container(
                                                        width: 15,
                                                        height: 15,
                                                        color: AppColor
                                                            .greenPrimaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 25,
            child: GestureDetector(
              onTap: () => Get.to(
                  CreateJobPost(nameCompany: widget.nameCompany),
                  arguments: {'type': 'save'}),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: AppColor.greenPrimaryColor, width: 2),
                  color: AppColor.orangePrimaryColor.withOpacity(0.66),
                ),
                child: Icon(
                  Icons.add,
                  color: AppColor.greenPrimaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
