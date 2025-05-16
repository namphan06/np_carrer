import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final currentPassword = TextEditingController();
  final changePassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final currentPasswordError = ''.obs;
  final newPasswordError = ''.obs;
  final confirmPasswordError = ''.obs;

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Email address is required.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Success",
        "Password reset email sent to $email. Please check your inbox (and spam folder).",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 5), // Tăng thời gian hiển thị
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An unknown error occurred.";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      // Thêm các mã lỗi khác nếu cần
      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
          "Error", "Failed to send password reset email: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<bool> validForm() async {
    currentPasswordError.value = ''; // Xóa lỗi cũ
    newPasswordError.value = '';
    confirmPasswordError.value = '';
    bool isValid = true;

    // Không cần kiểm tra currentPassword ở đây vì nó sẽ được xác thực riêng
    // hoặc nếu người dùng chọn "Forgot current password"

    if (changePassword.text.isEmpty) {
      newPasswordError.value = 'New password is required';
      isValid = false;
    } else if (changePassword.text.length < 6) {
      newPasswordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (confirmPassword.text.isEmpty) {
      confirmPasswordError.value = 'Confirm password is required';
      isValid = false;
    } else if (confirmPassword.text != changePassword.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  // Cập nhật hàm này để yêu cầu mật khẩu hiện tại
  Future<void> updateUserPassword(
      String currentPasswordValue, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar("Error", "No user logged in.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (user.email == null) {
      Get.snackbar("Error", "User email not found.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Bước 1: Xác thực lại người dùng bằng mật khẩu hiện tại
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPasswordValue,
    );

    try {
      // Xác thực lại
      await user.reauthenticateWithCredential(credential);

      // Bước 2: Nếu xác thực thành công, cập nhật mật khẩu
      await user.updatePassword(newPassword);
      Get.snackbar("Success", "Password updated successfully.",
          backgroundColor: Colors.green, colorText: Colors.white);
      // Xóa các trường sau khi thành công
      currentPassword.clear();
      changePassword.clear();
      confirmPassword.clear();
      Get.back(); // Quay lại màn hình trước đó
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        currentPasswordError.value = 'Incorrect current password.';
        Get.snackbar("Error", "Incorrect current password.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == 'weak-password') {
        newPasswordError.value = 'The new password is too weak.';
        Get.snackbar("Error", "The new password is too weak.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "An error occurred: ${e.message}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update password: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
