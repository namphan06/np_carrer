import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/user/profile/change_password/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

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
        title: Text(
          "Reset Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(45),
        child: Column(
          children: [
            Obx(() => _buildPasswordField(
                  label: "Current Password",
                  icon: Icons.lock_outline,
                  controller: controller.currentPassword,
                  errorText: controller.currentPasswordError.value,
                )),
            const SizedBox(height: 20),
            Obx(() => _buildPasswordField(
                  label: "New Password",
                  icon: Icons.lock_reset_outlined,
                  controller: controller.changePassword,
                  errorText: controller.newPasswordError.value,
                )),
            const SizedBox(height: 20),
            Obx(() => _buildPasswordField(
                  label: "Confirm Password",
                  icon: Icons.check_circle_outline,
                  controller: controller.confirmPassword,
                  errorText: controller.confirmPasswordError.value,
                )),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.orangePrimaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                bool isValid = await controller.validForm();
                if (isValid) {
                  await controller.updateUserPassword(
                      controller.changePassword.text.trim());
                }
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: AppColor.greenPrimaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.greenPrimaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColor.greenPrimaryColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            errorText: errorText.isNotEmpty ? errorText : null,
          ),
        ),
      ],
    );
  }
}
