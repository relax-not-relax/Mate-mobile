import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/staff.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffDailyDetails extends StatefulWidget {
  const StaffDailyDetails({
    super.key,
    required this.staff,
    required this.dateCare,
  });

  final Staff staff;
  final DateTime dateCare;

  @override
  State<StaffDailyDetails> createState() => _StaffDailyDetailsState();
}

class _StaffDailyDetailsState extends State<StaffDailyDetails> {
  //Ngày phụ trách phòng của nhân viên (Gọi API để thay đổi)
  DateTime careDate = DateTime.now();
  String formatDate = "";
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  void initState() {
    super.initState();
    formatDate = DateFormat("dd/MM/yyyy").format(careDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 24.h,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 244, 255),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.w,
                    children: [
                      CircleAvatar(
                        radius: 20.w,
                        backgroundImage: widget.staff.avatar == null
                            ? const NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/lottery-4803d.appspot.com/o/admin.png?alt=media&token=36c3bf42-b2b3-4742-bf5b-671f06926823")
                            : NetworkImage(widget.staff.avatar!),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.staff.fullName,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 25, 27, 33),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Mate's staff",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: const Color.fromARGB(255, 108, 110, 116),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: widget.staff.status!
                          ? const Color.fromARGB(255, 67, 90, 204)
                          : const Color.fromARGB(255, 32, 35, 43),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      widget.staff.status! ? "Active" : "Inactive",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Container(
                height: 0.5.h,
                color: const Color.fromARGB(255, 202, 210, 255),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Nursing care: ${widget.dateCare.day}/${widget.dateCare.month}/${widget.dateCare.year}",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 154, 155, 159),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _makePhoneCall(widget.staff.phoneNumber!);
                    },
                    child: Icon(
                      IconsaxPlusBold.call,
                      size: 20.sp,
                      color: const Color.fromARGB(255, 67, 90, 204),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
