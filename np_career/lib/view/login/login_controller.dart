import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:np_career/company/home/home_company.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login_fb.dart';
import 'package:np_career/view/user/home/home_screen_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LoginFb _loginFb = Get.put(LoginFb());

  var isRemember = false.obs;

  var emailError = "".obs;
  var passwordError = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadRememberMe();

    // Lắng nghe sự thay đổi của email và password
    emailController.addListener(() {
      if (isRemember.value) {
        saveRememberMe(true); // Lưu lại thông tin khi email thay đổi
      }
    });

    passwordController.addListener(() {
      if (isRemember.value) {
        saveRememberMe(true); // Lưu lại thông tin khi password thay đổi
      }
    });
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

  void loginUser() async {
    try {
      String res = await _loginFb.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      UserModel userModel = await _loginFb.getUser();
      if (res == "success") {
        if (userModel.role == "user") {
          Get.to(HomeScreenUser());
        } else if (userModel.role == "company") {
          Get.to(HomeCompany());
        } else {
          Get.snackbar("Error", "Actor empty");
        }
      } else {
        Get.snackbar("Error", "Login Fail");
      }
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);
    isRemember.value = value;

    if (isRemember.value) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      print("Email saved: ${emailController.text}");
      print("Password saved: ${passwordController.text}");
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      print("Email and Password removed.");
    }
  }

  Future<void> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    isRemember.value = prefs.getBool('remember_me') ?? false;

    print("Remember me: $isRemember");

    if (isRemember.value) {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
