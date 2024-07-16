import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/chat/admin/messages_list_screen.dart';
import 'package:mate_project/screens/home/admin/admin_home_screen.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
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
