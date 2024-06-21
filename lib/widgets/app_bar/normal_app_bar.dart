import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TNormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TNormalAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5.h,
            color: const Color.fromARGB(255, 174, 174, 174),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {},
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
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
