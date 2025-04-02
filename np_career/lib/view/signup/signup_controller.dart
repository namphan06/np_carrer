import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';

class SignupController extends GetxController {
  var checkChoice = "user".obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  var nameError = "".obs;
  var emailError = "".obs;
  var phoneError = "".obs;
  var passwordError = "".obs;
  var confirmpasswordError = "".obs;

  bool validForm() {
    nameError.value = validName(nameController.text);
    emailError.value = validEmail(emailController.text);
    phoneError.value = validPhone(phoneController.text);
    passwordError.value = validPassword(passwordController.text);
    confirmpasswordError.value = validConfirmPassword(confirmController.text);
    if (emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        nameError.value.isEmpty &&
        phoneError.value.isEmpty &&
        confirmpasswordError.isEmpty) {
      return true;
    }
    return false;
  }

  String validName(String value) {
    if (value.isEmpty) return "Name cannot be left empty.";
    return "";
  }

  String validEmail(String value) {
    if (value.isEmpty) return "Email cannot be left empty.";
    if (!GetUtils.isEmail(value)) return "Invalid email.";
    return "";
  }

  String validPhone(String value) {
    if (value.isEmpty) return "Phone cannot be left empty.";
    if (!RegExp(r'^(?:\+84|0)(9[0-9]{8})$').hasMatch(value))
      return "Invalid phone.";
    return "";
  }

  String validPassword(String value) {
    if (value.isEmpty) return "Password cannot be left empty.";
    if (value.length < 8) return "Password must be at least 8 characters long.";
    if (!RegExp(r'[A-Z]').hasMatch(value))
      return "Password must contain at least one uppercase letter.";
    if (!RegExp(r'[0-9]').hasMatch(value))
      return "Password must contain at least one number.";
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value))
      return "Password must contain at least one special character.";
    return "";
  }

  String validConfirmPassword(String value) {
    if (value.isEmpty) return "Confirm password cannot be left empty";
    if (value != passwordController.text)
      return "Passwords do not match. Please try again.";
    return "";
  }

  @override
  void onInit() {
    super.onInit();
  }
}
