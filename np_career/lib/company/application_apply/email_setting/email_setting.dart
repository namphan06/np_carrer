import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/company/application_apply/email_setting/email_setting_controller.dart';
import 'package:np_career/core/app_color.dart';

class EmailSetting extends StatefulWidget {
  const EmailSetting({super.key});

  @override
  State<EmailSetting> createState() => _EmailSettingState();
}

class _EmailSettingState extends State<EmailSetting> {
  final EmailSettingController controller = Get.put(EmailSettingController());

  @override
  Widget build(BuildContext context) {
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
            "Email Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Cho phép cuộn
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email Accept",
                style: TextStyle(
                    color: AppColor.orangePrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 10),
              // Phần chọn chế độ nhập liệu
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        value: false,
                        groupValue: controller.isFileSelected.value,
                        onChanged: (value) {
                          setState(() {
                            controller.isFileSelected.value = value!;
                          });
                        },
                        title: Text("Normal Input"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        value: true,
                        groupValue: controller.isFileSelected.value,
                        onChanged: (value) {
                          setState(() {
                            controller.isFileSelected.value = value!;
                          });
                        },
                        title: Text("Choose File"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              controller.isFileSelected.value
                  ? Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: controller.pickFileForAccept,
                          icon: Icon(Icons.file_copy, size: 40),
                        ),
                      ),
                    )
                  : TextField(
                      // Nếu nhập bình thường
                      controller: controller.emailAcceptController,
                      decoration: InputDecoration(
                        labelText: 'Email Accept',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                    ),
              SizedBox(height: 20),

              // Tiêu đề Email Reject
              Text(
                "Email Reject",
                style: TextStyle(
                    color: AppColor.orangePrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              // Phần chọn chế độ nhập liệu
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        value: false,
                        groupValue: controller.isFileSelected.value,
                        onChanged: (value) {
                          setState(() {
                            controller.isFileSelected.value = value!;
                          });
                        },
                        title: Text("Normal Input"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        value: true,
                        groupValue: controller.isFileSelected.value,
                        onChanged: (value) {
                          setState(() {
                            controller.isFileSelected.value = value!;
                          });
                        },
                        title: Text("Choose File"),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              controller.isFileSelected.value
                  ? Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: controller.pickFileForReject,
                          icon: Icon(Icons.file_copy, size: 40),
                        ),
                      ),
                    )
                  : TextField(
                      // Nếu nhập bình thường
                      controller: controller.emailRejectController,
                      decoration: InputDecoration(
                        labelText: 'Email Reject',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                    ),
              SizedBox(height: 20),

              // Nút Lưu
              ElevatedButton(
                onPressed: controller.saveEmails,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Lưu Cấu Hình", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
