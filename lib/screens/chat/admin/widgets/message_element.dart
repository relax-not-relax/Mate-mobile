import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/message.dart';

class MessageElement extends StatelessWidget {
  const MessageElement({
    super.key,
    required this.element,
    required this.onTap,
  });

  final Message element;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    String formattedDate = "";
    if (element.time.day == DateTime.now().day) {
      formattedDate = DateFormat.Hm().format(element.time);
    } else {
      formattedDate = DateFormat.MMMMd().format(element.time);
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 360.w,
        margin: EdgeInsets.only(
          bottom: 4.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.w,
                  backgroundImage: element.avatar == ""
                      ? AssetImage(
                          element.avatar,
                        )
                      : NetworkImage(element.avatar),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 180.w,
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          element.name,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: element.status!
                                ? FontWeight.w500
                                : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Flexible(
                        child: Text(
                          element.isAdmin
                              ? "Admin: ${element.lastMessage}"
                              : element.lastMessage,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: element.status!
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedDate,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                element.status!
                    ? Container()
                    : CircleAvatar(
                        radius: 4.w,
                        backgroundColor:
                            const Color.fromARGB(255, 76, 102, 232),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
