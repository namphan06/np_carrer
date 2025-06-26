import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/company/home/home_company_controller.dart';
import 'package:np_career/company/search/search_application/search_application.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/screen/home.dart';
import 'package:np_career/view/user/home/navbar/customer_bottom_navbar.dart';
import 'package:np_career/view/user/home/navbar/navbar_controller.dart';
import 'package:np_career/view/user/profile/profile_screen.dart';

class HomeCompany extends StatefulWidget {
  const HomeCompany({super.key});

  @override
  State<HomeCompany> createState() => _HomeCompanyState();
}

class _HomeCompanyState extends State<HomeCompany> {
  final HomeCompanyController controller = Get.put(HomeCompanyController());
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
            return SearchApplication(
              nameType: 'search',
            );
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
              // Padding(
              //   padding: EdgeInsets.only(right: 10),
              //   child: Stack(
              //     alignment: Alignment.topRight,
              //     children: [
              //       SvgPicture.asset(
              //         "assets/images/notifications_active.svg",
              //         width: 35,
              //         height: 35,
              //         color: AppColor.greenPrimaryColor,
              //       ),
              //       Positioned(
              //           top: -5,
              //           right: 0,
              //           child: Container(
              //             padding: EdgeInsets.all(4),
              //             decoration: BoxDecoration(
              //                 color: AppColor.orangeRedColor,
              //                 shape: BoxShape.circle),
              //             child: Text(
              //               "1",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ))
              //     ],
              //   ),
              // )
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
                          color: AppColor.greenPrimaryColor, fontSize: 20),
                    ),
                    Text(
                      controller.emailController.toString(),
                      style: TextStyle(
                          color: AppColor.greenPrimaryColor, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.lightBackgroundColor,
                border: Border(
                  top: BorderSide(color: AppColor.greenPrimaryColor, width: 3),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  spacing: 15,
                  runSpacing: 25,
                  children: controller.items.map((item) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 69) / 3,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: item['onTap'],
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greenPrimaryColor,
                                    width: 3),
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.orangePrimaryColor
                                    .withOpacity(0.66),
                              ),
                              padding: EdgeInsets.all(20),
                              child: SvgPicture.asset(
                                item['img'],
                                color: AppColor.greenPrimaryColor,
                                width: 45,
                                height: 45,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                item['text'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.greenPrimaryColor),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
