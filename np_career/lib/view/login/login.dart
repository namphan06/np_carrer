import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/login/animation_check_remember.dart';
import 'package:np_career/view/login/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.orangePrimaryColor,
              border: Border(
                  top: BorderSide(color: AppColor.greenPrimaryColor, width: 3)),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 60, left: 10),
            child: Text(
              "NP Carrer",
              style: TextStyle(
                  color: AppColor.greenPrimaryColor,
                  fontSize: 30,
                  fontFamily: "Tinos",
                  fontWeight: FontWeight.bold),
            )),
        Positioned(
          right: 20,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/icon/icon1.png"),
                      fit: BoxFit.cover,
                    ),
                    border:
                        Border.all(color: AppColor.greenPrimaryColor, width: 1),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 110),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
              ),
              border: Border(
                  top: BorderSide(color: AppColor.greenPrimaryColor, width: 3)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 30, left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: AppColor.greenPrimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Tinos"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          label: Text("Email"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          label: Text("Password"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(() => AnimationCheckRemember(
                                  value: controller.isRemember.value,
                                  onChanged: (val) =>
                                      controller.isRemember.value = val)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                    color: AppColor.greenPrimaryColor),
                              )
                            ],
                          ),
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.greenPrimaryColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColor.greenPrimaryColor,
                              thickness: 2,
                              endIndent: 10,
                              indent: 10,
                            ),
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(color: AppColor.greenPrimaryColor),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColor.greenPrimaryColor,
                              thickness: 2,
                              endIndent: 10,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/Google__G__logo.svg.webp",
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: AppColor.greenPrimaryColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: AppColor.orangeRedColor,
                                ),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
