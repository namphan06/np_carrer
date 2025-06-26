import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:np_career/core/app_theme.dart';
import 'package:np_career/firebase_options.dart';
import 'package:np_career/services/call_api.dart';
import 'package:np_career/tool/courses/providers/CategoryProvider.dart';
import 'package:np_career/tool/courses/providers/CourseProvider.dart';
import 'package:np_career/tool/courses/providers/FormulaProvider.dart';
import 'package:np_career/tool/courses/providers/MBTIProvider.dart';
import 'package:np_career/tool/courses/providers/MIProvider.dart';
import 'package:np_career/view/login/login.dart';
import 'package:np_career/view/signup/signup.dart';
import 'package:np_career/view/user/home/home_screen_user.dart';
import 'package:np_career/view/user/profile/profile_bilding.dart';
import 'package:np_career/view/user/profile/profile_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(apiService: AppService()),
        ),
        ChangeNotifierProvider(
          create: (_) => MiProvider(apiService: AppService()),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => CourseProvider(apiService: AppService()),
        // ),
        ChangeNotifierProvider(
          create: (_) => FormulaProvider(apiService: AppService()),
        ),
        ChangeNotifierProvider(
          create: (_) => MbtiQuestionProvider(apiService: AppService()),
        ),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightAppTheme,
        home: Login(),
        getPages: [
          GetPage(name: '/home_user', page: () => HomeScreenUser()),
          GetPage(
            name: '/profile',
            page: () => ProfileScreen(),
            binding: ProfileBinding(),
          ),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
//dsfdsfdsfsd
