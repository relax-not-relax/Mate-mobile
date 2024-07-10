import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/attendance_type.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/management/staff/staff_schedule_screen.dart';
import 'package:mate_project/screens/management/staff/widgets/attendance_of_day.dart';
import 'package:mate_project/screens/management/staff/widgets/attendance_selection.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class RoomAttendanceScreen extends StatefulWidget {
  const RoomAttendanceScreen({
    super.key,
    required this.attendance,
  });

  final Attendance attendance;

  @override
  State<RoomAttendanceScreen> createState() => _RoomAttendanceScreenState();
}

class _RoomAttendanceScreenState extends State<RoomAttendanceScreen> {
  // Lấy dữ liệu về phòng, loại gói và người ở trong phòng
  late Room room;
  late Customer customer;
  late Pack pack;

  bool isSelecting = false;
  late AttendanceType type;
  String attendStatus = "";

  @override
  void initState() {
    super.initState();
    // Test data, gọi API lấy dữ liệu về room, pack của widget.attendance.customerId
    room = Room(
      roomId: 1,
      managerId: 1,
      roomName: '“Sunflower” Room',
    );
    customer = Customer(
      customerId: 1,
      email: "test@gmail.com",
      fullName: "Lorem ispum",
      avatar: "assets/pics/user_test.png",
    );
    pack = Pack(
      packId: 1,
      price: 200.0,
      packName: "Gold",
      description: "",
      duration: 1,
      status: true,
    );

    type = ProjectData.attendanceType[0];
  }

  void waitingForSelection() {
    setState(() {
      isSelecting = true;
    });
  }

  void finishedSelection() {
    setState(() {
      isSelecting = false;
    });
  }

  void onSelectAttendanceSession(AttendanceType aType) {
    waitingForSelection();
    setState(() {
      type = aType;
      attendStatus = "";
    });
    finishedSelection();
  }

  void onSelectAttendance(String aStatus) {
    waitingForSelection();
    // Lưu ý: Xử lý trường hợp đã điểm danh thì không setState
    setState(() {
      attendStatus = aStatus;
    });
    finishedSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 41, 45, 50),
      appBar: TNormalAppBar(
        title: room.roomName,
        isBordered: false,
        isBack: true,
        bgColor: const Color.fromARGB(255, 41, 45, 50),
        titleColor: Colors.white,
        back: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const StaffMainScreen(
                  inputScreen: StaffScheduleScreen(),
                  screenIndex: 2,
                );
              },
            ),
            (route) => false,
          );
        },
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 24.w,
            right: 24.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24.w,
                      backgroundImage: AssetImage(customer.avatar!),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.fullName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${pack.packName} Membership",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                AttendanceOfDay(
                  aType: type,
                  onChoose: onSelectAttendanceSession,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 360.w,
              height: 800.h * 0.65,
              padding: EdgeInsets.fromLTRB(
                24.w,
                24.w,
                24.w,
                32.h,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Take attendance",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 35, 38, 47),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AttendanceSelection(
                        status: attendStatus,
                        sessionType: type.session,
                        onSelect: onSelectAttendance,
                      ),
                    ],
                  ),

                  // Xử lý nút "Save" với các trường hợp
                  // Trường hợp mọi thứ đều OK thì dùng nút này
                  NormalButtonCustom(
                    name: "Save",
                    action: () {},
                    background: const Color.fromARGB(255, 84, 110, 255),
                  ),

                  // Trường hợp đã điểm danh hoặc chưa tới giờ điểm danh
                  //const DisabledButtonCustom(name: "Save"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
