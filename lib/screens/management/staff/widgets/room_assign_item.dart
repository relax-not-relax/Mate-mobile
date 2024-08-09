import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/day_attendance.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/repositories/room_repo.dart';
import 'package:mate_project/screens/management/staff/room_attendance_screen.dart';

class RoomAssignItem extends StatefulWidget {
  const RoomAssignItem({
    super.key,
    required this.attendance,
  });

  final DayAttendance attendance;

  @override
  State<RoomAssignItem> createState() => _RoomAssignItemState();
}

class _RoomAssignItemState extends State<RoomAssignItem> {
  // Lấy dữ liệu về phòng, loại gói và người ở trong phòng
  Room? room;
  CustomerResponse? customer;
  Pack? pack;
  RoomRepository roomRepository = RoomRepository();

  Future getData() async {
    room =
        (await roomRepository.GetRoomStaff(roomId: widget.attendance.roomId))!;
    customer = widget.attendance.customer!;
    if (room!.roomId == 1 || room!.roomId == 2) {
      pack = Pack(
        packId: 1,
        price: 289,
        packName: "Gold Room",
        description: "",
        duration: 0,
        status: true,
      );
    } else if (room!.roomId == 3 || room!.roomId == 4) {
      pack = Pack(
        packId: 2,
        price: 199,
        packName: "Silver Room",
        description: "",
        duration: 0,
        status: true,
      );
    } else {
      pack = Pack(
        packId: 3,
        price: 99,
        packName: "Bronze Room",
        description: "",
        duration: 0,
        status: true,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Color roomColor = Colors.white;
    if (pack != null) {
      switch (pack!.packId) {
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
    }

    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RoomAttendanceScreen(
                customer: customer!,
                pack: pack!,
                room: room!,
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
                    room != null ? room!.roomName : "",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 35, 38, 47),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pack != null ? "${pack!.packName} room" : "",
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
                        backgroundImage: customer != null
                            ? NetworkImage(customer!.avatar!)
                            : const AssetImage("assets/pics/man.png"),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        customer != null ? customer!.fullname : "",
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
                widget.attendance.status == 1 ? "Taken" : "Not taken",
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
