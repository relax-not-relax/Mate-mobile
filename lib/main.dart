import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/authentication/start_screen.dart';
import 'package:mate_project/screens/authentication/verification_screen.dart';
import 'package:mate_project/screens/home/admin/admin_home_screen.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/home/staff/staff_home_screen.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/information/get_information_screen.dart';
import 'package:mate_project/screens/subscription/room_subscription_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 84, 110, 255),
          ),
          useMaterial3: true,
        ),
        //home: const StartScreen(),
        home: RoomSubscriptionScreen(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(360, 800),
    );
  }
}
