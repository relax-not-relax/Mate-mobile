import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class FirstChat extends StatefulWidget {
  const FirstChat({
    super.key,
    required this.ask,
  });

  final void Function(String) ask;

  @override
  State<FirstChat> createState() => _FirstChatState();
}

class _FirstChatState extends State<FirstChat> {
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
    return Container(
      width: 320.w,
      height: 800.h * 0.65,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(12, 20, 19, 19),
            blurRadius: 32,
            offset: Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/pics/app_logo_2.png",
            width: 89.w,
            height: 129.h,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Welcome to Mate",
            style: GoogleFonts.inter(
              color: const Color.fromARGB(255, 40, 36, 102),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Howdy, Friends! Welcome to the Mate Customer Service. How can we support you?",
            style: GoogleFonts.inter(
              color: Color.fromARGB(255, 79, 81, 89),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 16.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
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
          ),
          SizedBox(
            height: 8.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              children: questions.map(
                (e) {
                  return ActionChip(
                    onPressed: () {
                      widget.ask(e);
                    },
                    label: Text(
                      e,
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 68, 60, 172),
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
                    backgroundColor: Colors.white,
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}
