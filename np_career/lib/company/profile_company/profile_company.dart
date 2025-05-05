import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:np_career/view/user/profile/profile_screen.dart';
import 'profile_company_controller.dart';
import 'package:np_career/core/app_color.dart';

class ProfileCompany extends StatelessWidget {
  const ProfileCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileCompanyController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              Icon(Icons.arrow_back_ios, color: AppColor.lightBackgroundColor),
        ),
        title: Center(
          child: Text(
            "Profile Company",
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
                  "Would you like to save the Profile",
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
                        controller.saveProfile();
                        Get.back();
                        Get.back();
                        Get.back();
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
        padding: EdgeInsets.all(size.width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mục nhập thủ công không có upload file
              buildTextField(
                  'Website',
                  'assets/images/language_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
                  size,
                  controller.websiteController),
              const SizedBox(height: 15),
              buildTextField(
                  'Headcount',
                  'assets/images/groups_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
                  size,
                  controller.headcountController,
                  suffixText: 'employees'),
              const SizedBox(height: 15),
              buildTextField(
                  'Address',
                  'assets/images/pin_drop_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
                  size,
                  controller.addressController),
              const SizedBox(height: 20),
              TextField(
                controller: controller.facebookController,
                style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  label: Text("Facebook"),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(size.width * 0.025),
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.twitterController,
                style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  label: Text("Twitter"),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(size.width * 0.025),
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.linkedInController,
                style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  label: Text("LinkedIn"),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(size.width * 0.025),
                    child: Icon(
                      FontAwesomeIcons.linkedin,
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
              ),
              const SizedBox(height: 20),

              // Mục Preview - cho phép nhập thủ công hoặc chọn file
              const Text("Preview",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.orangePrimaryColor)),
              const SizedBox(height: 10),

              // Nút để chuyển chế độ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.4, // Chiều rộng nút tùy ý
                    child: ElevatedButton(
                      onPressed: () => controller.switchMode('manual'),
                      child: const Text("Manual Mode"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.4, // Chiều rộng nút tùy ý
                    child: ElevatedButton(
                      onPressed: () => controller.switchMode('file'),
                      child: const Text("File Mode"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Hiển thị theo chế độ
              Obx(() {
                return controller.mode.value == 'manual'
                    ? TextField(
                        controller: controller.inputController,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          label: Text("Preview"),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(size.width * 0.025),
                            child: SvgPicture.asset(
                              'assets/images/description_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
                              width: 20,
                              height: 20,
                              color: AppColor.greenPrimaryColor,
                            ),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 40, minHeight: 40),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: AppColor.greenPrimaryColor),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.upload_file,
                                  size: 30, color: AppColor.greenPrimaryColor),
                              onPressed: controller.pickAndReadFile,
                              tooltip: "Upload Word File",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(() => controller.inputText.value.isNotEmpty
                              ? Container(
                                  width: double.infinity, // Chiều rộng full
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppColor.greenPrimaryColor),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Preview:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppColor.greenPrimaryColor)),
                                      const SizedBox(height: 10),
                                      Container(
                                        width:
                                            size.width * 0.9, // Kéo dài ô Text
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Obx(
                                            () => Text(
                                              controller.inputText.value,
                                              style: TextStyle(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  fontWeight: FontWeight.w500),
                                              // maxLines:
                                              //     20, // Giới hạn số dòng hiển thị tối đa
                                              // overflow: TextOverflow
                                              //     .visible, // Không ẩn văn bản khi tràn
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const Text("No content extracted.")),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String iconPath, Size size,
      TextEditingController controller,
      {String? suffixText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: EdgeInsets.all(size.width * 0.025),
          child: SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            color: AppColor.greenPrimaryColor,
          ),
        ),
        suffixText: suffixText,
        prefixIconConstraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
      style: TextStyle(
          color: AppColor.greenPrimaryColor, fontWeight: FontWeight.bold),
    );
  }
}
