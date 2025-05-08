import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:np_career/company/profile_company/profile_company.dart';
import 'package:np_career/company/profile_company/profile_company_controller.dart';
import 'package:np_career/core/app_color.dart';

class ProfileCompanyData extends StatefulWidget {
  const ProfileCompanyData({super.key});

  @override
  State<ProfileCompanyData> createState() => _ProfileCompanyDataState();
}

class _ProfileCompanyDataState extends State<ProfileCompanyData> {
  final ProfileCompanyController controller =
      Get.put(ProfileCompanyController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double circleRadius = size.width * 0.15;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.04, horizontal: size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.checkGet
                  ? Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => Get.to(ProfileCompany()),
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            color: AppColor.greenPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: circleRadius,
                        height: circleRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/images/corporate_fare_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
                          color: AppColor.greenPrimaryColor,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          width: size.height * 0.2,
                          height: size.width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.greenPrimaryColor, width: 2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                      width: size.width * 0.75,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.greenPrimaryColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/language_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                                    width: 25,
                                    height: 25,
                                    color: AppColor.greenPrimaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                          controller.profileData['website'] ??
                                              '')),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/groups_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                                    width: 25,
                                    height: 25,
                                    color: AppColor.greenPrimaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                          "${controller.profileData['headcount'] ?? ''} employees")),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/pin_drop_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                                    width: 25,
                                    height: 25,
                                    color: AppColor.greenPrimaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Text(
                                          controller.profileData['address'] ??
                                              '')),
                                ],
                              ),
                            ],
                          ))),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Container(
                    width: size.width * 0.12,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.greenPrimaryColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(FontAwesomeIcons.facebookF,
                            color: AppColor.greenPrimaryColor),
                        SizedBox(height: 10),
                        Icon(FontAwesomeIcons.twitter,
                            color: AppColor.greenPrimaryColor),
                        SizedBox(height: 10),
                        Icon(FontAwesomeIcons.linkedinIn,
                            color: AppColor.greenPrimaryColor),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Introduce",
                style: TextStyle(
                    color: AppColor.orangePrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.greenPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:
                      Obx(() => Text(controller.profileData['preview'] ?? '')))
            ],
          ),
        ),
      ),
    );
  }
}
