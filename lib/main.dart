import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
import 'package:mate_project/screens/chat/widgets/first_chat.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/management/customer/attendance_history_screen.dart';
import 'package:mate_project/screens/management/customer/care_history_screen.dart';
import 'package:mate_project/screens/management/customer/my_room_screen.dart';
import 'package:mate_project/screens/management/staff/staff_schedule_screen.dart';
import 'package:mate_project/screens/notification/staff_notification_screen.dart';
import 'package:mate_project/screens/profile_management/customer/account_main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_address_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_favorite_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_language_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_password_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_profile_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/introduction/onboard_screen.dart';

import 'package:mate_project/screens/subscription/room_details_screen.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/authentication/login_selection_screen.dart';
import 'package:mate_project/screens/authentication/start_screen.dart';
import 'package:mate_project/screens/authentication/verification_screen.dart';
import 'package:mate_project/screens/information/get_information_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          // home: customer == null
          //     ? const OnboardScreen(
          //         index: 0,
          //       )
          //     : const MainScreen(
          //         inputScreen: HomeScreen(),
          //         screenIndex: 0,
          //       ),

          home: StaffMainScreen(
            inputScreen: StaffScheduleScreen(),
            screenIndex: 2,
          ),
          debugShowCheckedModeBanner: false,
        ),
        designSize: const Size(360, 800),
      ),
    );
  }
}
