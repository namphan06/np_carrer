import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/login/login.dart';
import 'package:np_career/view/signup/signup_controller.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: Container(
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
                          Flexible(
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
                          Flexible(
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
                        TextField(
                          controller: controller.nameController,
                          decoration: InputDecoration(label: Text("Name")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: controller.nameController,
                          decoration: InputDecoration(label: Text("Email")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: controller.nameController,
                          decoration: InputDecoration(label: Text("Phone")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: controller.nameController,
                          decoration: InputDecoration(label: Text("Password")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: controller.nameController,
                          decoration:
                              InputDecoration(label: Text("Confirm Password")),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        onPressed: () {},
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
            ),
          )
        ],
      ),
    );
  }
}
