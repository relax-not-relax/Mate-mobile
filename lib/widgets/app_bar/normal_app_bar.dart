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
    required this.isBack,
    this.bgColor,
    this.titleColor,
  });

  final String title;
  void Function()? back;
  Widget? action;
  final bool isBordered;
  final bool isBack;
  Color? bgColor;
  Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 90.h,
      decoration: isBordered
          ? BoxDecoration(
              color: bgColor ?? Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 0.5.h,
                  color: const Color.fromARGB(255, 174, 174, 174),
                ),
              ),
            )
          : BoxDecoration(
              color: bgColor ?? Colors.white,
            ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: bgColor ?? Colors.white,
              leading: isBack
                  ? IconButton(
                      onPressed: back,
                      icon: Icon(
                        Icons.arrow_back,
                        color: titleColor ??
                            const Color.fromARGB(255, 35, 47, 107),
                      ),
                    )
                  : Container(),
              title: Text(
                title,
                style: GoogleFonts.inter(
                  color: titleColor ?? const Color.fromARGB(255, 35, 47, 107),
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
