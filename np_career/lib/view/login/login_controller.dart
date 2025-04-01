import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isRemember = false.obs;

  var emailError = "".obs;
  var passwordError = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadRememberMe();
  }

  String validEmail(String value) {
    if (value.isEmpty) return "Email cannot be left empty.";
    if (!GetUtils.isEmail(value)) return "Invalid email.";
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

  bool validForm() {
    emailError.value = validEmail(emailController.text);
    passwordError.value = validPassword(passwordController.text);
    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    isRemember.value = prefs.getBool('remember_me') ?? false;

    if (isRemember.value) {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    }
  }

  Future<void> saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);
    isRemember.value = value;
    if (isRemember.value) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
