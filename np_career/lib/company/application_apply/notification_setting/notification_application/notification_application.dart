import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/company/application_apply/notification_setting/notification_application/notification_application_controller.dart';
import 'package:np_career/core/app_color.dart';

class NotificationApplication extends StatefulWidget {
  const NotificationApplication({super.key});

  @override
  State<NotificationApplication> createState() =>
      _NotificationApplicationState();
}

class _NotificationApplicationState extends State<NotificationApplication> {
  NotificationApplicationController controller =
      Get.put(NotificationApplicationController());

  final List<String> icons = [
    '🎉',
    '😢',
    '✅',
    '❌',
    '📝',
    '💼',
    '❤️',
    '👋',
    '👍',
    '👎',
    '🔥',
    '✨',
    '🥳',
    '📢',
    '📅',
    '🕒',
    '🚀',
    '🧡',
    '🤔',
    '💡'
  ];

  void insertIconToTextField(
      TextEditingController textController, String icon) {
    final text = textController.text;
    final selection = textController.selection;
    final newText = text.replaceRange(selection.start, selection.end, icon);
    textController.text = newText;
    textController.selection =
        TextSelection.collapsed(offset: selection.start + icon.length);
  }

  @override
  Widget build(BuildContext context) {
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
            "Notification Apply Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: "Notification Accept",
                controller: controller.notificationAcceptController,
                onPickFile: controller.pickFileForAccept,
              ),
              const SizedBox(height: 30),
              _buildSection(
                title: "Notification Reject",
                controller: controller.notificationRejectController,
                onPickFile: controller.pickFileForReject,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: controller.saveEmails,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child:
                    const Text("Save Setting", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required TextEditingController controller,
    required Function() onPickFile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: AppColor.orangePrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        const SizedBox(height: 10),
        _buildInputModeSelector(),
        const SizedBox(height: 20),
        this.controller.isFileSelected.value
            ? _buildFilePicker(onPickFile)
            : _buildTextInputWithIcons(controller),
      ],
    );
  }

  Widget _buildInputModeSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              title: const Text("Normal Input"),
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
              title: const Text("Choose File"),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker(Function() onPickFile) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: IconButton(
          onPressed: onPickFile,
          icon: const Icon(Icons.file_copy, size: 40),
        ),
      ),
    );
  }

  Widget _buildTextInputWithIcons(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: icons.length,
            itemBuilder: (context, index) {
              final icon = icons[index];
              return InkWell(
                onTap: () => insertIconToTextField(controller, icon),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.shade100,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Text(icon, style: const TextStyle(fontSize: 24)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Notification ',
            border: OutlineInputBorder(),
          ),
          maxLines: 10,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
