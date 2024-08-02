import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/event.dart';
import 'package:mate_project/models/month.dart';
import 'package:mate_project/screens/home/customer/widgets/open_event.dart';
import 'package:mate_project/screens/management/admin/event_adding_screen.dart';
import 'package:mate_project/screens/management/admin/widgets/month_item.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:unicons/unicons.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<Month> monthList = [];
  final ScrollController _scrollController = ScrollController();
  String monthTitle = "";
  String yearTitle = "";
  List<String> monthKeys = [];
  List<String> monthsValues = [];
  Event? event;

  final Map<String, String> monthsAbbreviated = {
    'Jan': 'January',
    'Feb': 'February',
    'Mar': 'March',
    'Apr': 'April',
    'May': 'May',
    'Jun': 'June',
    'Jul': 'July',
    'Aug': 'August',
    'Sep': 'September',
    'Oct': 'October',
    'Nov': 'November',
    'Dec': 'December',
  };

  List<Month> generateMonths(List<String> monthSet) {
    List<Month> months = [];
    for (var month in monthSet) {
      if (month.compareTo(DateFormat.MMM().format(DateTime.now())) == 0) {
        months.add(
          Month(
            monthName: month,
            isSelected: true,
          ),
        );
      } else {
        months.add(
          Month(monthName: month, isSelected: false),
        );
      }
    }
    return months;
  }

  @override
  void initState() {
    super.initState();
    monthKeys = monthsAbbreviated.keys.toList();
    monthsValues = monthsAbbreviated.values.toList();
    monthList = generateMonths(monthKeys);
    Month selected = monthList
        .where(
          (element) => element.isSelected == true,
        )
        .first;
    monthTitle = monthsValues[monthKeys.indexOf(selected.monthName)];
    yearTitle = DateTime.now().year.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to current day after build completes
      final selectedMonthIndex =
          monthList.indexWhere((month) => month.isSelected!);
      if (selectedMonthIndex != -1) {
        _scrollToCurrentMonth(selectedMonthIndex);
      }
    });

    // Test data
    // Gọi API lấy ra event trong tháng
    // event = Event(
    //   title: "Summer sounds",
    //   imgUrl: "assets/pics/concert.png",
    //   description:
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    //   start: DateTime.now(),
    // );
    event = null;
  }

  void _scrollToCurrentMonth(int index) {
    final itemWidth = 66.w;
    final scrollOffset = index * itemWidth;
    _scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Event",
        isBordered: false,
        isBack: false,
        titleColor: Colors.white,
        bgColor: const Color.fromARGB(255, 15, 16, 20),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              monthTitle,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              yearTitle,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              width: 360.w,
              height: 70.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: monthList.length,
                itemBuilder: (context, index) {
                  return MonthItem(
                    month: monthList[index],
                    onTap: () {
                      setState(() {
                        monthList.forEach(
                          (month) => month.isSelected = false,
                        );
                        monthList[index].isSelected = true;
                        monthTitle = monthList[index].monthName;
                        _scrollToCurrentMonth(index);
                      });
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: event != null
                ? OpenEvent(
                    event: event!,
                  )
                : InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EventAddingScreen();
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EventAddingScreen();
                                },
                              ),
                              (route) => false,
                            );
                          },
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 152, 152, 152),
                                  width: 1.w,
                                ),
                              ),
                            ),
                          ),
                          icon: Icon(
                            UniconsLine.plus,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "Add event",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
