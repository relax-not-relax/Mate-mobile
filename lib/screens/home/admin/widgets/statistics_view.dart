import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/screens/home/admin/widgets/statistics_selection.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({
    super.key,
    required this.currentMonth,
    required this.profit,
    required this.revenue,
  });

  final DateTime currentMonth;
  final int revenue;
  final int profit;

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
  }

  String formatMonth(DateTime month) {
    return DateFormat("MMMM yyyy").format(widget.currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 244.h,
      margin: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 41, 45, 50),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatMonth(widget.currentMonth),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Statistics",
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Image.asset(
                "assets/pics/chart.png",
                width: 42.w,
                height: 42.w,
              ),
            ],
          ),
          SizedBox(
            height: 32.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatisticsSelection(
                amount: formatNumber(widget.revenue),
                title: "Revenue",
              ),
              StatisticsSelection(
                amount: formatNumber(widget.profit),
                title: "Profit",
              ),
            ],
          )
        ],
      ),
    );
  }
}
