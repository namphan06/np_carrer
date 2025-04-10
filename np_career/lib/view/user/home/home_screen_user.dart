import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/test/cv1_output_no1_test.dart';
import 'package:np_career/view/screen/home.dart';
import 'package:np_career/view/user/build_your_resume/by_style/resume_by_style.dart';
import 'package:np_career/view/user/home/home_user_controller.dart';
import 'package:np_career/view/user/home/navbar/customer_bottom_navbar.dart';
import 'package:np_career/view/user/home/navbar/navbar_controller.dart';
import 'package:np_career/view/user/job_applied/job_applied.dart';
import 'package:np_career/view/user/profile/profile_screen.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({super.key});

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  final HomeUserController controller = Get.put(HomeUserController());
  final NavbarController navbarController = Get.put(NavbarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.orangePrimaryColor,
      body: Obx(() {
        switch (navbarController.currentIndex.value) {
          case 0:
            return _buildHomeScree();
          case 1:
            return Home();
          case 2:
            return ProfileScreen();
          default:
            return _buildHomeScree();
        }
      }),
      bottomNavigationBar: CustomerBottomNavbar(onTabSelected: (index) {
        navbarController.changeTab(index);
      }),
    );
  }

  Widget _buildHomeScree() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "NP Careers",
                    style: TextStyle(
                        color: AppColor.greenPrimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SvgPicture.asset(
                      "assets/images/notifications_active.svg",
                      width: 35,
                      height: 35,
                      color: AppColor.greenPrimaryColor,
                    ),
                    Positioned(
                        top: -5,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: AppColor.orangeRedColor,
                              shape: BoxShape.circle),
                          child: Text(
                            "1",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/images/profile-round-1342-svgrepo-com.svg',
                      height: 10,
                      width: 10,
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.nameController.toString(),
                      style: TextStyle(
                          color: AppColor.greenPrimaryColor, fontSize: 15),
                    ),
                    Text(
                      controller.emailController.toString(),
                      style: TextStyle(
                          color: AppColor.greenPrimaryColor, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.lightBackgroundColor,
                border: Border(
                    top: BorderSide(
                        color: AppColor.greenPrimaryColor, width: 3)),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Job",
                            style: TextStyle(
                                color: AppColor.orangePrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/file-info-paper-person-profile-svgrepo-com.svg",
                                    lableContainer: "Jobs Applied",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/save-add-svgrepo-com.svg",
                                    lableContainer: "Saved Jobs",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/recommended-svgrepo-com.svg",
                                    lableContainer: "Relevant Jobs",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/industry-svgrepo-com.svg",
                                    lableContainer: "Jobs by Specialty",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/company-svgrepo-com.svg",
                                    lableContainer: "Top Company",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Profile & Resume",
                            style: TextStyle(
                                color: AppColor.orangePrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/pen-file-svgrepo-com.svg",
                                    lableContainer: "Build Your Resume",
                                    selectedContainer: () {
                                      Get.to(ResumeByStyle());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/manage-dashboard-analytic-svgrepo-com.svg",
                                    lableContainer: "Resume Management",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/profile-image-round-1326-svgrepo-com.svg",
                                    lableContainer: "CV Profile",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/brain-svgrepo-com.svg",
                                    lableContainer: "Resume Writing Guide",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/bug_report_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                                    lableContainer: "Testing",
                                    selectedContainer: () {
                                      Get.to(ButtonTrigger());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Tool",
                            style: TextStyle(
                                color: AppColor.orangePrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/test-svgrepo-com.svg",
                                    lableContainer: "MBTI Personality Test",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/test-svgrepo-com (1).svg",
                                    lableContainer: "MI Test",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/scales-3-svgrepo-com.svg",
                                    lableContainer:
                                        "Gross-Net Salary Calculation",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/marketing-hand-give-bar-chart-statistic-svgrepo-com.svg",
                                    lableContainer: "Income Tax Calculation",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/shield-xmark-svgrepo-com.svg",
                                    lableContainer:
                                        "Unemployment Insurance Calculation",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/shield-check-svgrepo-com.svg",
                                    lableContainer:
                                        "One-Time Social Insurance Calculation",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/money-bag-svgrepo-com.svg",
                                    lableContainer:
                                        "Compound Interest Calculation",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                                CustomerContainer(
                                    svgPicture:
                                        "assets/images/money-recive-svgrepo-com.svg",
                                    lableContainer: "Savings Plan",
                                    selectedContainer: () {
                                      Get.to(JobApplied());
                                    }),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerContainer extends StatelessWidget {
  CustomerContainer(
      {required this.svgPicture,
      required this.lableContainer,
      required this.selectedContainer});
  final String svgPicture;
  final String lableContainer;
  final Function selectedContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            selectedContainer();
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.greenPrimaryColor, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: SvgPicture.asset(
                svgPicture,
                color: AppColor.greenPrimaryColor,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 30,
          width: 60,
          child: Center(
            child: Text(
              lableContainer,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColor.greenPrimaryColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        )
      ],
    );
  }
}
