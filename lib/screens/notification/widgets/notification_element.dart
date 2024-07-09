import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/news.dart';

class NotificationElement extends StatefulWidget {
  const NotificationElement({
    super.key,
    required this.news,
    required this.onRead,
  });

  final News news;
  final void Function() onRead;

  @override
  State<NotificationElement> createState() => _NotificationElementState();
}

class _NotificationElementState extends State<NotificationElement> {
  Duration difference = const Duration(
    seconds: 0,
  );
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  String formattedTime = "";

  @override
  void initState() {
    super.initState();
    difference = DateTime.now().difference(widget.news.time);
    seconds = difference.inSeconds;
    minutes = seconds ~/ 60;
    hours = minutes ~/ 60;
    days = hours ~/ 24;
    if (days > 0) {
      formattedTime = '${days}d';
    } else if (hours > 0) {
      formattedTime = "${hours}h";
    } else if (minutes > 0) {
      formattedTime = "${minutes}m";
    } else {
      formattedTime = "${seconds}s";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.h,
      ),
      color: widget.news.status
          ? Colors.transparent
          : const Color.fromARGB(255, 238, 241, 255),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.w,
                backgroundImage: AssetImage(
                  widget.news.avatar,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.news.title,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 35, 47, 107),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    width: 220.w,
                    child: Text(
                      widget.news.description,
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 84, 87, 91),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
          Text(
            formattedTime,
            style: GoogleFonts.inter(
              color: const Color.fromARGB(255, 84, 87, 91),
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
