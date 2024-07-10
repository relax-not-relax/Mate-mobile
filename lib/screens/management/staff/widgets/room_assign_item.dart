import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/management/staff/room_attendance_screen.dart';

class RoomAssignItem extends StatefulWidget {
  const RoomAssignItem({
    super.key,
    required this.attendance,
  });

  final Attendance attendance;

  @override
  State<RoomAssignItem> createState() => _RoomAssignItemState();
}

class _RoomAssignItemState extends State<RoomAssignItem> {
  // Lấy dữ liệu về phòng, loại gói và người ở trong phòng
  late Room room;
  late Customer customer;
  late Pack pack;

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
  }

  @override
  Widget build(BuildContext context) {
    Color roomColor = Colors.white;
    switch (pack.packId) {
      case 1:
        roomColor = const Color.fromARGB(255, 251, 189, 5);
        break;
      case 2:
        roomColor = const Color.fromARGB(255, 170, 170, 206);
        break;
      case 3:
        roomColor = const Color.fromARGB(255, 250, 108, 37);
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RoomAttendanceScreen(
                attendance: widget.attendance,
              );
            },
          ),
        );
      },
      child: Container(
        width: 330.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        margin: EdgeInsets.only(
          bottom: 16.h,
        ),
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    room.roomName,
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 35, 38, 47),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${pack.packName} room",
                    style: GoogleFonts.inter(
                      color: roomColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.w,
                        backgroundImage: AssetImage(customer.avatar!),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        customer.fullName,
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 79, 81, 89),
                          fontSize: 10.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: widget.attendance.status == 1
                    ? const Color.fromARGB(255, 52, 168, 83)
                    : const Color.fromARGB(255, 234, 68, 53),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.attendance.status == 1
                    ? "Attendance taken"
                    : "Not taken",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
