import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/screens/home/staff/widgets/room_assigned.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: 360.w,
        height: 800.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pics/nurse-1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 360.w,
                height: 320.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 150.h,
              right: 0,
              left: 0,
              child: RoomAssigned(),
            ),
            Positioned(
              top: 32.h,
              left: 24.w,
              child: Image.asset(
                "assets/pics/app_logo_2.png",
                width: 56.w,
                height: 81.h,
              ),
            ),
            Positioned(
              top: 360.h * 0.4,
              left: 24.w,
              child: Row(
                children: [
                  Container(
                    width: 360.w * 0.5,
                    margin: EdgeInsets.only(
                      top: 104.h,
                    ),
                    child: Text(
                      "Always By Your Side",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 127, 119, 245),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
