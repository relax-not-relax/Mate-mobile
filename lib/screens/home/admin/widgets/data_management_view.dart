import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class DataManagementView extends StatefulWidget {
  const DataManagementView({
    super.key,
    required this.amount,
    required this.userImgs,
    required this.title,
  });

  final List<String> userImgs;
  final int amount;
  final String title;

  @override
  State<DataManagementView> createState() => _DataManagementViewState();
}

class _DataManagementViewState extends State<DataManagementView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148.w,
      height: 148.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(141, 37, 41, 46),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 233, 233, 234),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Icon(
                UniconsLine.arrow_up_right,
                color: Colors.white,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  spacing: -8.w,
                  children: widget.userImgs.map(
                    (member) {
                      return Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(member),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(30.w),
                          border: Border.all(
                            color: const Color.fromARGB(141, 37, 41, 46),
                            width: 2.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "${widget.amount} members",
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 233, 233, 234),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
