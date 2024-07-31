import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/models/room_assign.dart';
import 'package:mate_project/screens/management/admin/room_assign_screen.dart';

class RoomAssignElement extends StatelessWidget {
  const RoomAssignElement({
    super.key,
    required this.room,
    required this.inDate,
    required this.roomId,
  });

  final RoomAssign room;
  final DateTime inDate;
  final int roomId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RoomAssignScreen(
                inDate: inDate,
                roomId: roomId,
                roomAssign: room,
              );
            },
          ),
        );
      },
      child: Container(
        width: 360.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          color: const Color.fromARGB(255, 79, 81, 89),
        ),
        margin: EdgeInsets.only(
          bottom: 8.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130.w,
                  child: Text(
                    '"${room.customerInRoom[0].room.roomName}" Room',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconsaxPlusBold.profile_2user,
                      size: 15.sp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      room.customerInRoom.length > 1
                          ? "${room.customerInRoom.length} members"
                          : "${room.customerInRoom.length} member",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: -10.w,
                  children: room.customerInRoom.map(
                    (e) {
                      return Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: e.customer.avatar == null
                                ? const AssetImage("assets/pics/no_ava.png")
                                : NetworkImage(e.customer.avatar!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(50.w),
                          border: Border.all(
                            color: const Color.fromARGB(255, 79, 81, 89),
                            width: 2.w,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: room.isAssigned
                    ? const Color.fromARGB(255, 52, 168, 83)
                    : const Color.fromARGB(255, 234, 68, 53),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Text(
                room.isAssigned ? "Assigned" : "Not Assigned",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
