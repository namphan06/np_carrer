import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/user/home/navbar/navbar_controller.dart';

class CustomerBottomNavbar extends StatelessWidget {
  CustomerBottomNavbar({required this.onTabSelected});
  final Function(int) onTabSelected;
  final NavbarController controller = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(color: AppColor.lightBackgroundColor),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColor.greenPrimaryColor,
                  width: 3,
                ),
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: onTabSelected,
              selectedItemColor: AppColor.greenPrimaryColor,
              unselectedItemColor: AppColor.lightTextColor,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
