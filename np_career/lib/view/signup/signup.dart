import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/login/login.dart';
import 'package:np_career/view/signup/signup_controller.dart';
import 'package:np_career/view/signup/signup_fb.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignupController controller = Get.put(SignupController());
  final SignupFb signupFb = Get.put(SignupFb());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Sign up",
                style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: AppColor.greenPrimaryColor, width: 3)),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(50))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.checkChoice.value = "user";
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.checkChoice.value ==
                                                  "company"
                                              ? AppColor.lightBackgroundColor
                                              : AppColor.orangePrimaryColor,
                                      minimumSize: Size.fromHeight(50)),
                                  child: Text(
                                    "User",
                                    style: TextStyle(
                                        color: AppColor.greenPrimaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.checkChoice.value = "company";
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.checkChoice.value == "user"
                                              ? AppColor.lightBackgroundColor
                                              : AppColor.orangePrimaryColor,
                                      minimumSize: Size.fromHeight(50)),
                                  child: Text(
                                    "Company",
                                    style: TextStyle(
                                        color: AppColor.greenPrimaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: Column(
                      children: [
                        Obx(
                          () => TextField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                                label: Text("Name"),
                                errorText: controller.nameError.isEmpty
                                    ? null
                                    : controller.nameError.value),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                                label: Text("Email"),
                                errorText: controller.emailError.isEmpty
                                    ? null
                                    : controller.emailError.value),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextField(
                            controller: controller.phoneController,
                            decoration: InputDecoration(
                                label: Text("Phone"),
                                errorText: controller.phoneError.isEmpty
                                    ? null
                                    : controller.phoneError.value),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                                label: Text("Password"),
                                errorText: controller.passwordError.isEmpty
                                    ? null
                                    : controller.passwordError.value),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextField(
                            controller: controller.confirmController,
                            decoration: InputDecoration(
                                label: Text("Confirm Password"),
                                errorText: controller
                                        .confirmpasswordError.isEmpty
                                    ? null
                                    : controller.confirmpasswordError.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller.validForm()) {
                            signupFb.signUp(
                              email: controller.emailController.text,
                              password: controller.passwordController.text,
                              username: controller.nameController.text,
                              phone: controller.phoneController.text,
                              role: controller.checkChoice.value,
                            );
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: AppColor.lightBackgroundColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(color: AppColor.greenPrimaryColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(Login());
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: AppColor.orangeRedColor,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
