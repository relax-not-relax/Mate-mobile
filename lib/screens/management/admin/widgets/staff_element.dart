import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/screens/management/admin/user_profile_screen.dart';
import 'package:unicons/unicons.dart';

class StaffElement extends StatefulWidget {
  const StaffElement({
    super.key,
    required this.staff,
    required this.action,
  });

  final Staff staff;
  final void Function(Staff) action;

  @override
  State<StaffElement> createState() => _StaffElementState();
}

class _StaffElementState extends State<StaffElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      margin: EdgeInsets.only(
        bottom: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              String date;

              if (widget.staff.dateOfBirth != null &&
                  widget.staff.dateOfBirth != "") {
                DateTime birthDate = DateTime.parse(widget.staff.dateOfBirth!);
                date = DateFormat("dd/MM/yyyy").format(birthDate);
              } else {
                date = "";
              }

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfileScreen(
                        fullName: widget.staff.fullName,
                        email: widget.staff.email,
                        phone: widget.staff.phoneNumber ?? "",
                        avatar: widget.staff.avatar ?? "assets/pics/no_ava.png",
                        birthday: date,
                        gender: widget.staff.gender ?? "",
                        address: widget.staff.address ?? "",
                        favorites: "",
                        note: "",
                        isStaff: true);
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.w,
                  backgroundImage: AssetImage(widget.staff.avatar!),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 200.w,
                  height: 50.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.staff.fullName,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              widget.action(widget.staff);
            },
            child: Icon(
              UniconsLine.ellipsis_h,
              color: Colors.white,
              size: 20.sp,
            ),
          )
        ],
      ),
    );
  }
}
