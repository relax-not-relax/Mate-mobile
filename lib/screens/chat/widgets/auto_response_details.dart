import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/models/chat.dart';

class AutoResponseDetails extends StatefulWidget {
  const AutoResponseDetails({
    super.key,
    required this.chatElement,
    required this.isAnswer,
    required this.ask,
  });

  final Chat chatElement;
  final bool isAnswer;
  final void Function(String) ask;

  @override
  State<AutoResponseDetails> createState() => _AutoResponseDetailsState();
}

class _AutoResponseDetailsState extends State<AutoResponseDetails> {
  // Bộ data câu hỏi auto response, call API to get
  List<String> questions = [];

  @override
  void initState() {
    super.initState();
    questions = [
      "Room-specific pricing policies?",
      "Some benefits for gold, silver and bronze room?",
      "Types of rooms do you have for gold, silver, bronze?",
      "Frequency of music concert organization?",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return widget.isAnswer
        ? Container(
            width: 360.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(widget.chatElement.avatar),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            widget.chatElement.text,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 84, 87, 91),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8.w,
                          children: [
                            Icon(
                              IconsaxPlusLinear.messages_2,
                              color: const Color.fromARGB(255, 63, 82, 191),
                              size: 21.sp,
                            ),
                            Text(
                              "Automated response",
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 63, 82, 191),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Wrap(
                          children: questions.map(
                            (e) {
                              return ActionChip(
                                onPressed: () {
                                  widget.ask(e);
                                },
                                label: Text(
                                  e,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 68, 60, 172),
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 68, 60, 172),
                              );
                            },
                          ).toList(),
                        ),
                      ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            widget.chatElement.text,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8.w,
                          children: [
                            Icon(
                              IconsaxPlusLinear.messages_2,
                              color: const Color.fromARGB(255, 63, 82, 191),
                              size: 21.sp,
                            ),
                            Text(
                              "Automated response",
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 63, 82, 191),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Wrap(
                          children: questions.map(
                            (e) {
                              return ActionChip(
                                onPressed: () {
                                  widget.ask(e);
                                },
                                label: Text(
                                  e,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 68, 60, 172),
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 68, 60, 172),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(widget.chatElement.avatar),
                ),
              ],
            ),
          );
  }
}
