import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/company/search/search_application/search_application_controller.dart';
import 'package:np_career/company/search/search_application/search_application_fb.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_city.dart';
import 'package:np_career/enum/enum_experience.dart';
import 'package:np_career/enum/enum_type_job_category.dart';
import 'package:np_career/view/not_found/enroll.dart';
import 'package:np_career/view/not_found/job_not_found.dart';
import 'package:np_career/view/not_found/not_found.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_data.dart';

class Recommend extends StatefulWidget {
  const Recommend({super.key});

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  SearchApplicationController controller =
      Get.put(SearchApplicationController());
  SearchApplicationFb _fb = Get.put(SearchApplicationFb());

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
            "Recommend",
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
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<List<String>>(
                        stream: _fb.getMatchingProfileIdsStream(),
                        builder: (context, streamSnapshot) {
                          if (streamSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (streamSnapshot.hasError) {
                            return Center(child: Enroll());
                          }

                          final profileIds = streamSnapshot.data ?? [];

                          if (profileIds.isEmpty) {
                            return Center(child: NoFoundWidget());
                          }

                          return FutureBuilder<List<Map<String, dynamic>>>(
                            future: _fb.getProfilesByIds(profileIds),
                            builder: (context, futureSnapshot) {
                              if (futureSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (futureSnapshot.hasError) {
                                return Center(
                                  child: Text(
                                    '❌ Đã xảy ra lỗi khi tải hồ sơ!',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              }

                              final profiles = futureSnapshot.data ?? [];

                              if (profiles.isEmpty) {
                                return Center(child: NoFoundWidget());
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: profiles.length,
                                itemBuilder: (context, index) {
                                  final job = profiles[index];
                                  final name = job['fullName'] ?? 'No name';
                                  final educationLevel =
                                      job['educationLevel'] ??
                                          'No education level';

                                  final city =
                                      job['city'] as List<dynamic>? ?? [];
                                  String cityText = '';
                                  if (city.isNotEmpty) {
                                    cityText = city.length > 1
                                        ? '${city[0]} +${city.length - 1}'
                                        : city.join(', ');
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(MyProfileData(userID: job['id']));
                                    },
                                    child: AnimatedContainer(
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
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: Offset(0, 4),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    color: AppColor
                                                        .greenPrimaryColor,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Education Level: $educationLevel",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: AppColor
                                                            .greyColor
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
                                          Obx(() => Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.greyColor
                                                      .withOpacity(0.5),
                                                ),
                                                child: controller
                                                                .savedApplicationStatusList
                                                                .length >
                                                            index &&
                                                        controller.savedApplicationStatusList[
                                                                index] ==
                                                            false
                                                    ? IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .toggleSavedApplicationStatus(
                                                                  index,
                                                                  job['id']);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .bookmark_border_outlined,
                                                          size: 30,
                                                          color: AppColor
                                                              .greenPrimaryColor,
                                                        ),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .toggleSavedApplicationStatus(
                                                                  index,
                                                                  job['id']);
                                                        },
                                                        icon: Icon(
                                                          Icons.bookmark,
                                                          size: 30,
                                                          color: AppColor
                                                              .greenPrimaryColor,
                                                        ),
                                                      ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
