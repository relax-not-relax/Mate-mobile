import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TNormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  TNormalAppBar({
    super.key,
    required this.title,
    this.back,
    this.action,
    required this.isBordered,
  });

  final String title;
  void Function()? back;
  IconButton? action;
  final bool isBordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 90.h,
      decoration: isBordered
          ? BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 0.5.h,
                  color: const Color.fromARGB(255, 174, 174, 174),
                ),
              ),
            )
          : const BoxDecoration(
              color: Colors.white,
            ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: back,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 35, 47, 107),
                ),
              ),
              title: Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 35, 47, 107),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              centerTitle: true,
              actions: [
                action ?? Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
