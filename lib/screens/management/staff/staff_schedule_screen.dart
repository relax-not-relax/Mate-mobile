import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/date_weekday.dart';
import 'package:mate_project/models/day_attendance.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/screens/management/staff/widgets/day_item.dart';
import 'package:mate_project/screens/management/staff/widgets/room_assign_item.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class StaffScheduleScreen extends StatefulWidget {
  const StaffScheduleScreen({super.key});

  @override
  State<StaffScheduleScreen> createState() => _StaffScheduleScreenState();
}

class _StaffScheduleScreenState extends State<StaffScheduleScreen> {
  late int selectedMonth;
  late int selectedYear;
  List<DateWeekday> daysList = [];
  Staff? staff = null;
  final ScrollController _scrollController = ScrollController();
  String dateTitle = "";
  // Biến roomAssign để đếm số phòng được giao trong ngày được chọn (Gọi API)
  int roomAssign = 0;
  // List<Attendance> để lấy những phòng nhân viên này sẽ phải điểm danh trong ngày được chọn (Gọi API)
  List<Attendance> attendanceList = [];
  List<DayAttendance> dayAttendanceList = [];
  AttendanceRepo attendanceRepository = AttendanceRepo();

  Future getStaff() async {
    staff = await SharedPreferencesHelper.getStaff();
  }

  int countRoom() {
    if (dayAttendanceList.isEmpty) return 0;
    List<int> listRoom = [];
    for (var element in dayAttendanceList) {
      if (!listRoom.contains(element.roomId)) {
        listRoom.add(element.roomId);
      }
    }
    return listRoom.length;
  }

  Future<void> getAttendance(DateTime startDate, DateTime endDate) async {
    dayAttendanceList = [];
    attendanceList = await attendanceRepository.GetAttendanceByDay(
        startDate: startDate, endDate: endDate, staffId: staff!.staffId);
    for (var element in attendanceList) {
      int index = isInDayAttendance(element, dayAttendanceList);
      if (index == -1) {
        if (element.checkDate.hour < 12) {
          Attendance eveningAttendance = Attendance(
              attendanceId: 0,
              customerId: element.customerId,
              staffId: element.staffId,
              checkDate: DateTime(element.checkDate.year,
                  element.checkDate.month, element.checkDate.day, 13, 0, 0),
              status: 3,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          DayAttendance dayAttendance = DayAttendance(
              element, eveningAttendance,
              customerId: element.customerId,
              staffId: element.staffId,
              status: element.staffId,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          if (dayAttendance.eveningAttendance.status == 3 ||
              dayAttendance.morningAttendance.status == 3) {
            dayAttendance.status = 2;
          } else {
            dayAttendance.status = 1;
          }
          dayAttendanceList.add(dayAttendance);
        } else {
          Attendance morningAttendance = Attendance(
              attendanceId: 0,
              customerId: element.customerId,
              staffId: element.staffId,
              checkDate: DateTime(element.checkDate.year,
                  element.checkDate.month, element.checkDate.day, 9, 0, 0),
              status: 3,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          DayAttendance dayAttendance = DayAttendance(
              morningAttendance, element,
              customerId: element.customerId,
              staffId: element.staffId,
              status: element.staffId,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          dayAttendanceList.add(dayAttendance);
          if (dayAttendance.eveningAttendance.status == 3 ||
              dayAttendance.morningAttendance.status == 3) {
            dayAttendance.status = 2;
          } else {
            dayAttendance.status = 1;
          }
        }
      } else {
        if (element.checkDate.hour < 12) {
          dayAttendanceList[index].morningAttendance = element;
          if (dayAttendanceList[index].eveningAttendance.status == 3 ||
              dayAttendanceList[index].morningAttendance.status == 3) {
            dayAttendanceList[index].status = 2;
          } else {
            dayAttendanceList[index].status = 1;
          }
        } else {
          dayAttendanceList[index].eveningAttendance = element;
          if (dayAttendanceList[index].eveningAttendance.status == 3 ||
              dayAttendanceList[index].morningAttendance.status == 3) {
            dayAttendanceList[index].status = 2;
          } else {
            dayAttendanceList[index].status = 1;
          }
        }
      }
    }
  }

  int isInDayAttendance(Attendance attendance, List<DayAttendance> list) {
    if (list.isEmpty) return -1;
    for (var element in list) {
      if ((element.morningAttendance.checkDate.day ==
                  attendance.checkDate.day &&
              element.morningAttendance.checkDate.month ==
                  attendance.checkDate.month &&
              element.morningAttendance.checkDate.year ==
                  attendance.checkDate.year &&
              element.customerId == attendance.customerId) ||
          (element.eveningAttendance.checkDate.day ==
                  attendance.checkDate.day &&
              element.eveningAttendance.checkDate.month ==
                  attendance.checkDate.month &&
              element.eveningAttendance.checkDate.year ==
                  attendance.checkDate.year &&
              element.customerId == attendance.customerId)) {
        return list.indexOf(element);
      }
    }
    return -1;
  }

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

  Future<void> setDate(DateTime date) async {
    print('ok');
    DateTime startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    dayAttendanceList = [];
    attendanceList = await attendanceRepository.GetAttendanceByDay(
        startDate: startDate, endDate: endDate, staffId: staff!.staffId);
    for (var element in attendanceList) {
      int index = isInDayAttendance(element, dayAttendanceList);
      if (index == -1) {
        if (element.checkDate.hour < 12) {
          Attendance eveningAttendance = Attendance(
              attendanceId: 0,
              customerId: element.customerId,
              staffId: element.staffId,
              checkDate: DateTime(element.checkDate.year,
                  element.checkDate.month, element.checkDate.day, 13, 0, 0),
              status: 3,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          DayAttendance dayAttendance = DayAttendance(
              element, eveningAttendance,
              customerId: element.customerId,
              staffId: element.staffId,
              status: element.staffId,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          if (dayAttendance.eveningAttendance.status == 3 ||
              dayAttendance.morningAttendance.status == 3) {
            dayAttendance.status = 2;
          } else {
            dayAttendance.status = 1;
          }
          dayAttendanceList.add(dayAttendance);
        } else {
          Attendance morningAttendance = Attendance(
              attendanceId: 0,
              customerId: element.customerId,
              staffId: element.staffId,
              checkDate: DateTime(element.checkDate.year,
                  element.checkDate.month, element.checkDate.day, 9, 0, 0),
              status: 3,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          DayAttendance dayAttendance = DayAttendance(
              morningAttendance, element,
              customerId: element.customerId,
              staffId: element.staffId,
              status: element.staffId,
              staff: staff,
              roomId: element.roomId,
              customer: element.customer);
          dayAttendanceList.add(dayAttendance);
          if (dayAttendance.eveningAttendance.status == 3 ||
              dayAttendance.morningAttendance.status == 3) {
            dayAttendance.status = 2;
          } else {
            dayAttendance.status = 1;
          }
        }
      } else {
        if (element.checkDate.hour < 12) {
          dayAttendanceList[index].morningAttendance = element;
          if (dayAttendanceList[index].eveningAttendance.status == 3 ||
              dayAttendanceList[index].morningAttendance.status == 3) {
            dayAttendanceList[index].status = 2;
          } else {
            dayAttendanceList[index].status = 1;
          }
        } else {
          dayAttendanceList[index].eveningAttendance = element;
          if (dayAttendanceList[index].eveningAttendance.status == 3 ||
              dayAttendanceList[index].morningAttendance.status == 3) {
            dayAttendanceList[index].status = 2;
          } else {
            dayAttendanceList[index].status = 1;
          }
        }
      }
    }
    for (var element in dayAttendanceList) {
      print(element.status);
    }
    setState(() {
      dayAttendanceList;
      roomAssign = countRoom();
    });
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
    getStaff().then(
      (value) async {
        DateTime startDate =
            DateTime(selected.year, selected.month, selected.day, 0, 0, 0);
        DateTime endDate =
            DateTime(selected.year, selected.month, selected.day, 23, 59, 59);
        getAttendance(startDate, endDate).then(
          (value) {
            setState(() {
              dayAttendanceList;
              roomAssign = countRoom();
            });
          },
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to current day after build completes
      final selectedDayIndex = daysList.indexWhere((day) => day.isSelected!);
      if (selectedDayIndex != -1) {
        _scrollToCurrentDay(selectedDayIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future displayBottomSheet(BuildContext context) {
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
                  color: Colors.white,
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
                          color: Colors.black,
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
                            color: const Color.fromARGB(255, 32, 35, 43),
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
                          dropdownColor: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownButton<int>(
                          value: selectedYear,
                          hint: const Text("Select year"),
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 32, 35, 43),
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
                          dropdownColor: Colors.white,
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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 45, 50),
      extendBodyBehindAppBar: false,
      appBar: TNormalAppBar(
        title: "My Schedule",
        isBordered: false,
        isBack: false,
        titleColor: Colors.white,
        bgColor: const Color.fromARGB(255, 41, 45, 50),
        action: IconButton(
          onPressed: () {
            displayBottomSheet(context);
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
      body: Stack(
        children: [
          Positioned(
            top: 0.h,
            left: 24.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTitle,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "$roomAssign rooms",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  width: 360.w,
                  height: 70.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: daysList.length,
                    itemBuilder: (context, index) {
                      return DayItem(
                        day: daysList[index],
                        onTap: () async {
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
                          DateTime date = daysList[index].dateTime;
                          await setDate(date);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 360.w,
              height: 800.h * 0.65,
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 249, 249),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: dayAttendanceList.map(
                        (e) {
                          return RoomAssignItem(
                            attendance: e,
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(
                      height: 150.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
