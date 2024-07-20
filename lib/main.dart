import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/chat/admin/messages_list_screen.dart';
import 'package:mate_project/screens/home/admin/admin_home_screen.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
import 'package:mate_project/screens/chat/widgets/first_chat.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/introduction/onboard_screen.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/screens/management/staff/staff_schedule_screen.dart';
import 'package:mate_project/screens/profile_management/staff/staff_account_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCd7uxVtQ2st-PDKfLT70pLQNxgHlD98sg',
              appId: '1:262021364783:android:ba6e8e177f7b02ca6ddada',
              messagingSenderId: '262021364783',
              storageBucket: 'mate-ccd5e.appspot.com',
              projectId: 'mate-ccd5e'),
        )
      : await Firebase.initializeApp();
  Rememberme? rememberme = await SharedPreferencesHelper.getRememberMe();
  if (rememberme != null) {
    Authenrepository authenrepository = Authenrepository();
    try {
      CustomerResponse customerResponse = await authenrepository.authenCustomer(
          email: rememberme.email, password: rememberme.password, fcm: "");
      runApp(MyApp(customer: customerResponse));
    } catch (error) {
      runApp(MyApp(customer: null));
    }
  } else {
    runApp(MyApp(
      customer: null,
    ));
  }
}

class MyApp extends StatelessWidget {
  final Authenrepository authenrepository = Authenrepository();
  final CustomerRepository customerRepository = CustomerRepository();
  final CustomerResponse? customer;

  MyApp({super.key, required this.customer});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(authenticationRepository: authenrepository),
        ),
        BlocProvider(
          create: (context) =>
              CustomerBloc(customerRepository: customerRepository),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 84, 110, 255),
            ),
            useMaterial3: true,
          ),
          home: customer == null
              ? const OnboardScreen(
                  index: 0,
                )
              : const MainScreen(
                  inputScreen: HomeScreen(),
                  screenIndex: 0,
                ),

          // home: AdminMainScreen(
          //   inputScreen: AdminHomeScreen(),
          //   screenIndex: 0,
          // ),
          debugShowCheckedModeBanner: false,
        ),
        designSize: const Size(360, 800),
      ),
    );
  }
}
