import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/screens/subscription/room_subscription_screen.dart';

class TMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMainAppBar({
    super.key,
    required this.customer,
    required this.open,
  });

  final Customer? customer;
  final void Function() open;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 12.w, 10.h),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 241, 255),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        //backgroundImage: NetworkImage(customer!.avatar!),
                        backgroundImage: AssetImage(customer!.avatar!),
                        radius: 25,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        customer!.fullName,
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 35, 47, 107),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: open,
                  child: const Icon(
                    IconlyBold.category,
                    color: Color.fromARGB(255, 35, 47, 107),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(110.0.h);
}
