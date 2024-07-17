import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/customer_in_room.dart';
import 'package:mate_project/models/date_weekday.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/models/room_assign.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/screens/management/admin/widgets/room_assign_list.dart';
import 'package:mate_project/screens/management/staff/widgets/day_item.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class AdminAssignScreen extends StatefulWidget {
  const AdminAssignScreen({super.key});

  @override
  State<AdminAssignScreen> createState() => _AdminAssignScreenState();
}

class _AdminAssignScreenState extends State<AdminAssignScreen>
    with SingleTickerProviderStateMixin {
  late int selectedMonth;
  late int selectedYear;
  List<DateWeekday> daysList = [];
  final ScrollController _scrollController = ScrollController();
  String dateTitle = "";
  String weekdayTitle = "";

  late TabController tabController;
  late int tIndex;

  late String filterOption;
  List<String> filters = [
    "Assigned",
    "Not assigned",
  ];

  // Test data, call API để lấy dữ liệu về danh sách các phòng theo gói
  List<RoomAssign> roomsList = [];

  List<DateWeekday> generateDays(int year, int month) {
    List<DateWeekday> days = [];
    int daysInMonth =
        DateTime(year, month + 1, 1).subtract(Duration(days: 1)).day;
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime current = DateTime(year, month, day);
      if (current.day == DateTime.now().day &&
          current.month == DateTime.now().month &&
          current.year == DateTime.now().year) {
        days.add(
          DateWeekday(
            dateTime: current,
            weekday: ProjectData.getWeekday(current),
            isSelected: true,
          ),
        );
      } else {
        days.add(
          DateWeekday(
            dateTime: current,
            weekday: ProjectData.getWeekday(current),
            isSelected: false,
          ),
        );
      }
    }
    return days;
  }

  void _scrollToCurrentDay(int index) {
    final itemWidth = 66.w;
    final scrollOffset = index * itemWidth;
    _scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().month;
    selectedYear = DateTime.now().year;
    daysList = generateDays(selectedYear, selectedMonth);
    DateTime selected = daysList
        .where(
          (day) => day.isSelected == true,
        )
        .first
        .dateTime;
    dateTitle = DateFormat.MMMMd().format(selected);
    weekdayTitle = DateFormat.EEEE().format(selected);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to current day after build completes
      final selectedDayIndex = daysList.indexWhere((day) => day.isSelected!);
      if (selectedDayIndex != -1) {
        _scrollToCurrentDay(selectedDayIndex);
      }
    });
    tIndex = 0;
    tabController = TabController(length: 3, vsync: this);
    filterOption = "";

    // Gọi API để lấy dữ liệu, dữ liệu sẽ thay đổi tùy theo loại gói
    // Note: Test data là dữ liệu cho gói vàng
    roomsList = [
      RoomAssign(
        customerInRoom: [
          CustomerInRoom(
            room: Room(
              roomId: 1,
              managerId: 1,
              roomName: 'Sunflower',
            ),
            customer: Customer(
              customerId: 1,
              email: "test@gmail.com",
              fullName: "Graham Potter",
              avatar: "assets/pics/user_test_1.png",
            ),
            joinDate: DateTime.parse("2020-01-01 17:00:20"),
          ),
          CustomerInRoom(
            room: Room(
              roomId: 1,
              managerId: 1,
              roomName: 'Sunflower',
            ),
            customer: Customer(
              customerId: 2,
              email: "test1@gmail.com",
              fullName: "Mike Smith",
              avatar: "assets/pics/user_test_3.png",
            ),
            joinDate: DateTime.parse("2020-02-01 17:00:20"),
          ),
        ],
        staff: Staff(
          staffId: 1,
          email: "staff@mate.org",
          fullName: "Lorem Ipsum",
        ),
        assignDate: DateTime.parse("2024-07-17 00:00:00"),
        isAssigned: true,
      ),
      RoomAssign(
        customerInRoom: [
          CustomerInRoom(
            room: Room(
              roomId: 2,
              managerId: 2,
              roomName: 'Summer',
            ),
            customer: Customer(
              customerId: 3,
              email: "test@gmail.com",
              fullName: "Sarah Ogre",
              avatar: "assets/pics/user_test_2.png",
            ),
            joinDate: DateTime.parse("2020-01-01 17:00:20"),
          ),
        ],
        staff: null,
        assignDate: null,
        isAssigned: false,
      ),
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future displayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        backgroundColor: const Color.fromARGB(255, 37, 41, 46),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 360.w,
                height: 250.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Sort by",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: filters.map(
                            (e) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio<String>(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor:
                                        const Color.fromARGB(255, 67, 90, 204),
                                    value: e,
                                    groupValue: filterOption,
                                    onChanged: (String? value) {
                                      setState(() {
                                        filterOption = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    e,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      NormalButtonCustom(
                        name: "Confirm",
                        action: () {},
                        background: const Color.fromARGB(255, 84, 110, 255),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    Future displayFilterTime(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 220.h,
                width: 360.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.h,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 37, 41, 46),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Sort by",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        DropdownButton<int>(
                          value: selectedMonth,
                          hint: const Text("Select month"),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          items: <String>[
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December'
                          ].asMap().entries.map((entry) {
                            int idx = entry.key;
                            String month = entry.value;
                            return DropdownMenuItem<int>(
                              value: idx + 1,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              // Gọi setState trong StatefulBuilder
                              selectedMonth = newValue!;
                            });
                          },
                          dropdownColor: const Color.fromARGB(255, 35, 38, 47),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownButton<int>(
                          value: selectedYear,
                          hint: const Text("Select year"),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          items: List<DropdownMenuItem<int>>.generate(7,
                              (int index) {
                            return DropdownMenuItem<int>(
                              value: 2024 + index,
                              child: Text("Year ${2024 + index}"),
                            );
                          }),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedYear = newValue!;
                            });
                          },
                          dropdownColor: const Color.fromARGB(255, 35, 38, 47),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    NormalButtonCustom(
                      name: "Confirm",
                      action: () {},
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    Widget content = Container();

    switch (tIndex) {
      case 0:
        content = RoomAssignList(
          assignList: roomsList,
          filter: () {
            displayBottomSheet(context);
          },
        );
        break;
      case 1:
        break;
      case 2:
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Assign",
        isBordered: false,
        isBack: false,
        titleColor: Colors.white,
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        action: IconButton(
          onPressed: () {
            displayFilterTime(context);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.transparent,
            ),
          ),
          icon: Icon(
            IconlyLight.filter,
            size: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              dateTitle,
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
              weekdayTitle,
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
                itemCount: daysList.length,
                itemBuilder: (context, index) {
                  return DayItem(
                    day: daysList[index],
                    onTap: () {
                      setState(() {
                        // ignore: avoid_function_literals_in_foreach_calls
                        daysList.forEach(
                          (d) => d.isSelected = false,
                        );
                        daysList[index].isSelected = true;
                        dateTitle = DateFormat.MMMMd().format(
                          daysList[index].dateTime,
                        );

                        _scrollToCurrentDay(index);
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
          TabBar(
            controller: tabController,
            labelColor: const Color.fromARGB(255, 182, 177, 249),
            labelStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: const Color.fromARGB(255, 112, 114, 118),
            indicatorColor: const Color.fromARGB(255, 182, 177, 249),
            dividerColor: const Color.fromARGB(255, 41, 45, 50),
            onTap: (value) {
              setState(() {
                tIndex = value;
              });
            },
            tabs: const [
              Tab(
                text: 'Gold Room',
              ),
              Tab(
                text: 'Silver Room',
              ),
              Tab(
                text: 'Bronze Room',
              ),
            ],
          ),
          content,
        ],
      ),
    );
  }
}
