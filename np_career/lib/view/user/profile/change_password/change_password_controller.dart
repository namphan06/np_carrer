import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController changePassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentPasswordError = "".obs;
  var newPasswordError = "".obs;
  var confirmPasswordError = "".obs;

  // Validate mật khẩu mới
  String validPassword(String value) {
    if (value.isEmpty) return "Password cannot be left empty.";
    if (value.length < 8) return "Password must be at least 8 characters long.";
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number.";
    }
    if (!RegExp(r'[!@#$%^&*(),.?\":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character.";
    }
    return "";
  }

  // Validate confirm password
  String validConfirmPassword(String value) {
    if (value.isEmpty) return "Confirm password cannot be left empty.";
    if (value != changePassword.text) {
      return "Passwords do not match. Please try again.";
    }
    return "";
  }

  // Kiểm tra mật khẩu hiện tại
  Future<String> checkCurrentPasswordValid(String currentPassword) async {
    try {
      final user = _auth.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);
      return "";
    } catch (e) {
      return "Incorrect Password";
    }
  }

  // Validate toàn bộ form (bất đồng bộ)
  Future<bool> validForm() async {
    currentPasswordError.value =
        await checkCurrentPasswordValid(currentPassword.text.trim());
    newPasswordError.value = validPassword(changePassword.text.trim());
    confirmPasswordError.value =
        validConfirmPassword(confirmPassword.text.trim());

    return currentPasswordError.value.isEmpty &&
        newPasswordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty;
  }

  // Đổi mật khẩu
  Future<void> updateUserPassword(String newPassword) async {
    try {
      final user = _auth.currentUser!;
      await user.updatePassword(newPassword);
      Get.snackbar("Success", "Password changed successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
