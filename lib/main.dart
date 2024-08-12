import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/blocs/staff_bloc.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/admin.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/screens/home/admin/admin_home_screen.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/staff/staff_home_screen.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/introduction/onboard_screen.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/screens/subscription/room_subscription_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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
  await Firebase.initializeApp();
  var customerResponse = await SharedPreferencesHelper.getCustomer();
  var staff = await SharedPreferencesHelper.getStaff();
  var admin = await SharedPreferencesHelper.getAdmin();


  runApp(MyApp(
    customer: customerResponse,
    admin: admin,
    staff: staff,
  ));
}

class MyApp extends StatelessWidget {
  final Authenrepository authenrepository = Authenrepository();
  final CustomerRepository customerRepository = CustomerRepository();
  final AttendanceRepo attendanceRepo = AttendanceRepo();
  final StaffRepository staffRepository = StaffRepository();
  final CustomerResponse? customer;
  final Staff? staff;
  final Admin? admin;

  MyApp({super.key, required this.customer, this.staff, this.admin});

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
          create: (context) => StaffBloc(
              attendanceRepository: attendanceRepo,
              staffRepository: staffRepository),
        ),
        BlocProvider(
          create: (context) => CustomerBloc(
              staffRepository: staffRepository,
              customer: customer,
              customerRepository: customerRepository,
              attendanceRepository: attendanceRepo),
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
          initialRoute: '/',
          routes: {
            '/paymentdone': (context) => MainScreen(
                  customerResponse: customer!,
                  inputScreen: const HomeScreen(),
                  screenIndex: 0,
                ), // Trang đích sau khi thanh toán thành công
            '/paymentcancel': (context) => RoomSubscriptionScreen(
                  customer: customer!,
                ), // Trang đích sau khi thanh toán bị hủy
          },
          home: (customer == null && admin == null && staff == null)
              ? const OnboardScreen(
                  index: 0,
                )
              : (customer != null)
                  ? (customer!.packs.isEmpty
                      ? RoomSubscriptionScreen(
                          customer: customer!,
                        )
                      : MainScreen(
                          customerResponse: customer!,
                          inputScreen: const HomeScreen(),
                          screenIndex: 0,
                        ))
                  : (admin != null)
                      ? const AdminMainScreen(
                          inputScreen: AdminHomeScreen(),
                          screenIndex: 0,
                        )
                      : const StaffMainScreen(
                          inputScreen: StaffHomeScreen(),
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
