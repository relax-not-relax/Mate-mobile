import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/chat.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({
    super.key,
    required this.chatElement,
    required this.isAnswer,
  });

  final Chat chatElement;
  final bool isAnswer;

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    return widget.isAnswer
        ? Container(
            width: 360.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.chatElement.isShowAvatar
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: widget.chatElement.avatar ==
                                "assets/pics/admin_avatar.png"
                            ? AssetImage(widget.chatElement.avatar)
                            : NetworkImage(widget.chatElement.avatar),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                      ),
                SizedBox(
                  width: 8.w,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 237, 237),
                      borderRadius: BorderRadius.only(
                        topLeft: widget.chatElement.isShowAvatar
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      widget.chatElement.text,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 84, 87, 91),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 360.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 84, 110, 255),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: widget.chatElement.isShowAvatar
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      widget.chatElement.text,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                widget.chatElement.isShowAvatar
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: widget.chatElement.avatar ==
                                "assets/pics/admin_avatar.png"
                            ? AssetImage(widget.chatElement.avatar)
                            : NetworkImage(widget.chatElement.avatar),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                      ),
              ],
            ),
          );
  }
}
