import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/helper.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/screens/home/staff/widgets/room_assigned.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  AttendanceRepo attendanceRepository = AttendanceRepo();
  String roomName = 'Loading';
  int roomNumber = 0;
  bool isAttended = true;

  Future<void> getAttendance() async {
    Staff? staff = await SharedPreferencesHelper.getStaff();
    DateTime date = DateTime.now();
    DateTime startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    List<Attendance> listAttendance =
        await attendanceRepository.GetAttendanceByDay(
            startDate: startDate, endDate: endDate, staffId: staff!.staffId);

    if (listAttendance.isEmpty) {
      setState(() {
        roomName = 'No';
        roomNumber = 0;
        isAttended = true;
      });
    } else {
      roomName = Helper.getRoomName(listAttendance.first.roomId);
      Set<int> uniqueIds = listAttendance.map((e) => e.roomId).toSet();
      roomNumber = uniqueIds.length;
      if (listAttendance.any((e) => e.status == 3)) {
        isAttended = false;
      } else {
        isAttended = true;
      }
      setState(() {
        roomName;
        isAttended;
        roomNumber;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAttendance();
  }

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
              child: RoomAssigned(
                roomNumber: roomNumber,
                roomName: roomName,
                isAttended: isAttended,
              ),
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
