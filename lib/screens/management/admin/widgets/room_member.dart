import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/customer_in_room.dart';
import 'package:unicons/unicons.dart';

class RoomMember extends StatefulWidget {
  const RoomMember({
    super.key,
    required this.member,
  });

  final CustomerInRoom member;

  @override
  State<RoomMember> createState() => _RoomMemberState();
}

class _RoomMemberState extends State<RoomMember> {
  //Test data, gọi API lấy số lần hiện diện và vắng mặt của người trong phòng
  int present = 0;
  int absent = 0;

  @override
  void initState() {
    super.initState();
    present = 150;
    absent = 2;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20.w,
                    backgroundImage: AssetImage(
                      widget.member.customer.avatar!,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      widget.member.customer.fullName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  UniconsLine.ellipsis_h,
                  color: Colors.white,
                  size: 20.sp,
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Attendance details",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            width: 360.w,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300.w * 0.5,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 183, 183, 183),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Presence",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        present.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300.w * 0.5,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Absence",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        absent.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
        ],
      ),
    );
  }
}
