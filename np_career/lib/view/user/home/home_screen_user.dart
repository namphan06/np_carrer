import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/screen/home.dart';
import 'package:np_career/view/user/home/home_user_controller.dart';
import 'package:np_career/view/user/home/navbar/customer_bottom_navbar.dart';
import 'package:np_career/view/user/home/navbar/navbar_controller.dart';
import 'package:np_career/view/user/job_applied/job_applied.dart';

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
            return Home();
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
                        top: -8,
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
                                fontSize: 18,
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
                    image: DecorationImage(
                      image: AssetImage("assets/icon/icon1.png"),
                      fit: BoxFit.cover,
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
                    Column(
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
                            ],
                          ),
                        )
                      ],
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
