import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
import 'package:mate_project/screens/chat/widgets/first_chat.dart';

import 'package:mate_project/screens/subscription/room_details_screen.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/authentication/login_selection_screen.dart';
import 'package:mate_project/screens/authentication/start_screen.dart';
import 'package:mate_project/screens/authentication/verification_screen.dart';
import 'package:mate_project/screens/information/get_information_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Authenrepository authenrepository = Authenrepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(authenticationRepository: authenrepository))
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
          //home: const StartScreen(),
          home: const LoginSelectionScreen(),
          debugShowCheckedModeBanner: false,
        ),
        designSize: const Size(360, 800),
      ),
    );
  }
}
