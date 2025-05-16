import 'package:firebase_auth/firebase_auth.dart'; // Thêm import này
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
          "Reset Password", // Hoặc "Change Password" tùy ngữ cảnh
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
                  isCurrentPassword: true, // Thêm cờ này
                )),
            // Thêm nút "Forgot Current Password?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  final currentUserEmail =
                      FirebaseAuth.instance.currentUser?.email;
                  if (currentUserEmail != null && currentUserEmail.isNotEmpty) {
                    controller.sendPasswordResetEmail(currentUserEmail);
                  } else {
                    Get.snackbar(
                      "Error",
                      "Could not retrieve your email. Please log in again.",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(
                  "Forgot Current Password?",
                  style: TextStyle(
                    color: AppColor.orangePrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Điều chỉnh khoảng cách nếu cần
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
                minimumSize:
                    const Size(double.infinity, 50), // Làm nút rộng hơn
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                // Sửa đổi: Cần xác thực mật khẩu hiện tại trước khi cho phép cập nhật
                // Điều này cần logic phía controller để kiểm tra mật khẩu hiện tại với Firebase Auth
                // Hiện tại, `validForm` chỉ kiểm tra mật khẩu mới và xác nhận.
                // Để đơn giản, chúng ta tạm bỏ qua việc xác thực currentPassword ở đây
                // vì mục tiêu là thêm chức năng gửi email.
                // Trong thực tế, bạn sẽ cần xác thực `currentPassword` trước.
                bool isValidNewPasswords = await controller.validForm();
                if (isValidNewPasswords) {
                  // Nếu bạn muốn xác thực mật khẩu hiện tại, bạn cần thêm logic vào đây
                  // và vào controller. Ví dụ:
                  // bool isCurrentPasswordValid = await controller.validateCurrentPassword(controller.currentPassword.text.trim());
                  // if (isCurrentPasswordValid) {
                  //    await controller.updateUserPassword(controller.changePassword.text.trim());
                  // }
                  // Còn hiện tại, ta sẽ giả định nó hợp lệ nếu form mới hợp lệ
                  if (controller.currentPassword.text.isEmpty) {
                    controller.currentPasswordError.value =
                        "Current password is required to change.";
                    return;
                  }
                  controller.currentPasswordError.value = ""; // Xóa lỗi nếu có
                  await controller.updateUserPassword(
                      controller.currentPassword.text
                          .trim(), // Cần mật khẩu hiện tại
                      controller.changePassword.text.trim());
                }
              },
              child: const Text(
                "Change Password", // Đổi tên nút cho rõ ràng hơn
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
    bool isCurrentPassword = false, // Mặc định là false
  }) {
    // Sử dụng RxBool để quản lý trạng thái hiển thị mật khẩu
    final RxBool obscureTextState = true.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => TextFormField(
              // Bọc TextFormField bằng Obx để cập nhật UI khi obscureTextState thay đổi
              controller: controller,
              obscureText: obscureTextState.value,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(icon, color: AppColor.greenPrimaryColor),
                suffixIcon: IconButton(
                  // Thêm icon để ẩn/hiện mật khẩu
                  icon: Icon(
                    obscureTextState.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.greenPrimaryColor,
                  ),
                  onPressed: () {
                    obscureTextState.value = !obscureTextState.value;
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.greenPrimaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.greenPrimaryColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  // Thêm style cho viền lỗi
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  // Thêm style cho viền lỗi khi focus
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText: errorText.isNotEmpty ? errorText : null,
              ),
            )),
      ],
    );
  }
}
