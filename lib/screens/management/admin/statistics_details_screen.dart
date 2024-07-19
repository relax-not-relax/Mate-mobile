import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/cash_flow.dart';
import 'package:mate_project/screens/management/admin/widgets/cost_details_element.dart';
import 'package:mate_project/screens/management/admin/widgets/statistics_chart.dart';
import 'package:mate_project/screens/management/admin/widgets/total_statistics_element.dart';

class StatisticsDetailsScreen extends StatefulWidget {
  const StatisticsDetailsScreen({
    super.key,
    required this.data,
    required this.month,
    required this.year,
    required this.totalRevenue,
    required this.totalProfit,
    required this.advice,
  });

  final List<CashFlow> data;
  final int month;
  final int year;
  final double totalRevenue;
  final double totalProfit;
  final String advice;

  @override
  State<StatisticsDetailsScreen> createState() =>
      _StatisticsDetailsScreenState();
}

class _StatisticsDetailsScreenState extends State<StatisticsDetailsScreen>
    with SingleTickerProviderStateMixin {
  List<CashFlow> cashFlows = [];
  Map<int, List<CashFlow>>? groupByWeek;
  List<Map<int, List<CashFlow>>>? cashFlowsEachWeak;
  late int weekNumber;
  String monthText = "";
  late int sIndex;
  Widget? chart;
  Widget? costDetails;

  late TabController tabController;
  late int tabIndex;

  List<Map<int, List<CashFlow>>> groupDaysByWeek(List<CashFlow> days) {
    Map<int, List<CashFlow>> weekMap = {};
    List<Map<int, List<CashFlow>>> weeksList = [];

    int firstDayWeekIndex =
        ((days.first.time.day - days.first.time.weekday + 10) / 7).floor();

    for (CashFlow day in days) {
      int weekOfYear = ((day.time.day - day.time.weekday + 10) / 7).floor();

      int weekIndex = weekOfYear - firstDayWeekIndex + 1;
      if (weekMap.containsKey(weekIndex)) {
        weekMap[weekIndex]!.add(day);
      } else {
        weekMap[weekIndex] = [day];
      }
    }

    weekMap.forEach((key, value) {
      weeksList.add({key: value});
    });

    return weeksList;
  }

  @override
  void initState() {
    super.initState();
    sIndex = 0;
    cashFlowsEachWeak = groupDaysByWeek(widget.data);
    groupByWeek = cashFlowsEachWeak![sIndex];
    cashFlows = groupByWeek!.values.first;
    weekNumber = groupByWeek!.keys.first;
    monthText = ProjectData.getMonthName(widget.month);
    chart = StatisticsChart(
      key: ValueKey('chart_$sIndex'),
      cashFlows: cashFlows,
    );
    costDetails = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cashFlows.map(
        (e) {
          return CostDetailsElement(
            cashFlow: e,
          );
        },
      ).toList(),
    );

    tabController = TabController(length: 2, vsync: this);
    tabIndex = 0;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 800.h,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Week $weekNumber, $monthText ${widget.year}",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            chart!,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: sIndex > 0
                      ? () {
                          setState(() {
                            sIndex--;
                            groupByWeek = cashFlowsEachWeak![sIndex];
                            cashFlows = groupByWeek!.values.first;
                            weekNumber = groupByWeek!.keys.first;
                            chart = StatisticsChart(
                              key: ValueKey('chart_$sIndex'),
                              cashFlows: cashFlows,
                            );
                            costDetails = Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: cashFlows.map(
                                (e) {
                                  return CostDetailsElement(
                                    cashFlow: e,
                                  );
                                },
                              ).toList(),
                            );
                          });
                        }
                      : null,
                  icon: Icon(
                    IconsaxPlusLinear.arrow_left,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: sIndex < ((cashFlowsEachWeak!.length) - 1)
                      ? () {
                          setState(() {
                            sIndex++;
                            groupByWeek = cashFlowsEachWeak![sIndex];
                            cashFlows = groupByWeek!.values.first;
                            weekNumber = groupByWeek!.keys.first;
                            chart = StatisticsChart(
                              key: ValueKey('chart_$sIndex'),
                              cashFlows: cashFlows,
                            );
                            costDetails = Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: cashFlows.map(
                                (e) {
                                  return CostDetailsElement(
                                    cashFlow: e,
                                  );
                                },
                              ).toList(),
                            );
                          });
                        }
                      : null,
                  icon: Icon(
                    IconsaxPlusLinear.arrow_right,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 76, 102, 232),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Revenue",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 202, 251),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Cost",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TotalStatisticsElement(
                  title: "Total Revenue",
                  amount: widget.totalRevenue,
                  bgColor: const Color.fromARGB(255, 35, 38, 47),
                ),
                SizedBox(
                  width: 4.w,
                ),
                TotalStatisticsElement(
                  title: "Total Profit",
                  amount: widget.totalProfit,
                  bgColor: const Color.fromARGB(255, 140, 159, 255),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 79, 81, 89),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Advice",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Wrap(
                    children: [
                      Text(
                        widget.advice,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Cost details",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            costDetails!,
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Revenue details",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "See all",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 118, 141, 255),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 150.h,
            ),
          ],
        ),
      ),
    );
  }
}
