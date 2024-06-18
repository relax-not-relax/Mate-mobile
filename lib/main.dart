import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/models/pack.dart';

import 'package:mate_project/screens/subscription/room_details_screen.dart';

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
        home: RoomDetailsScreen(
          pack: Pack(
            packId: 1,
            price: 1100,
            packName: "Gold Room",
            description:
                "Gold Room offers a premium living experience with comprehensive care services to cater to your refined needs. Amenities: Spacious and comfortable beds, In-room TV, Gourmet meals (2-3 meals/day), Regular diaper changing and acupressure massage, 24/7 online hotline, Special event organization assistance, Daily check-ins. Gold Room is the perfect choice for those seeking a life of comfort, convenience, and attentive care at our elderly care facility.",
            duration: 0,
            status: true,
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(360, 800),
    );
  }
}
