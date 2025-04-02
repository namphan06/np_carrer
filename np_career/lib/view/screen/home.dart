import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:np_career/view/login/login.dart';
import 'package:np_career/view/login/login_fb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LoginFb loginFb = LoginFb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Home"),
          ),
          ElevatedButton(
              onPressed: () {
                loginFb.signOut();
                Get.to(Login());
              },
              child: Text("Sign Out"))
        ],
      ),
    );
  }
}
