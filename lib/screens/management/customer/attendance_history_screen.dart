import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/screens/management/customer/my_room_screen.dart';
import 'package:mate_project/screens/management/customer/widgets/attendance_history_details.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  List<Attendance> attendanceList = [];
  CustomerResponse? customer = null;
  AttendanceRepo attendanceRepository = AttendanceRepo();
  List<Attendance> myAttendance = [];
  late ScrollController _scrollController;
  List<Attendance> myAttendanceOrigin = [];

  late int selectedYear;
  late String filterOption;
  List<String> filters = [
    "This week",
    "This month",
    "This year",
    "All time",
  ];

  int page = 1;
  final int size = 20;
  Future getAttend() async {
    customer = await SharedPreferencesHelper.getCustomer();
    myAttendanceOrigin = await attendanceRepository.GetAttendanceOfCustomer(
        filterType: 0,
        pageSize: size,
        page: page,
        customerId: customer!.customerId);
    page++;
    setState(() {
      myAttendance = myAttendanceOrigin;
    });
  }

  void resetSearch() async {
    page = 1;
    myAttendanceOrigin = await attendanceRepository.GetAttendanceOfCustomer(
        filterType: 0,
        pageSize: size,
        page: page,
        customerId: customer!.customerId);
    page++;
    setState(() {
      myAttendance = myAttendanceOrigin;
    });
  }

  void _onScroll() async {
    print('hihi');
    if (_scrollController.position.atEdge && filterOption == 'All time') {
      print('hihi');
      bool isBottom = _scrollController.position.pixels != 0;
      if (isBottom) {
        List<Attendance> listAdd =
            await attendanceRepository.GetAttendanceOfCustomer(
                filterType: 0,
                pageSize: size,
                page: page,
                customerId: customer!.customerId);
        setState(() {
          myAttendanceOrigin.addAll(listAdd);
          myAttendance.addAll(listAdd);
        });
        page++;
      }
    }
  }

  void filter(String filter) async {
    page = 1;
    int sortType = 0;
    switch (filter) {
      case 'This week':
        sortType = 1;
        break;
      case 'This month':
        sortType = 2;
        break;
      case 'This year':
        sortType = 3;
        break;
    }
    print("okee");
    myAttendanceOrigin = await attendanceRepository.GetAttendanceOfCustomer(
        filterType: sortType,
        pageSize: 0,
        page: 1,
        customerId: customer!.customerId);
    setState(() {
      myAttendance = myAttendanceOrigin;
    });
    for (var element in myAttendance) {
      print(element.toJson().toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    getAttend();
    attendanceList = [
      Attendance(
          roomId: 0,
          customer: null,
          attendanceId: 1,
          customerId: 1,
          staffId: 1,
          checkDate: DateTime.parse("2024-06-22 07:30:20"),
          status: 1,
          staff: null),
      Attendance(
          roomId: 0,
          customer: null,
          attendanceId: 2,
          customerId: 1,
          staffId: 1,
          checkDate: DateTime.parse("2024-06-22 17:00:20"),
          status: 2,
          staff: null),
      Attendance(
          roomId: 0,
          customer: null,
          attendanceId: 3,
          customerId: 1,
          staffId: 1,
          checkDate: DateTime.parse("2024-06-21 07:30:20"),
          status: 1,
          staff: null),
      Attendance(
          roomId: 0,
          customer: null,
          attendanceId: 4,
          customerId: 1,
          staffId: 1,
          checkDate: DateTime.parse("2024-06-21 17:00:20"),
          status: 1,
          staff: null),
      Attendance(
          roomId: 0,
          customer: null,
          attendanceId: 5,
          customerId: 1,
          staffId: 1,
          checkDate: DateTime.parse("2024-06-20 07:30:20"),
          status: 1,
          staff: null),
      Attendance(
          roomId: 0,
          customer: null,
          attendanceId: 6,
          customerId: 1,
          staffId: 1,
          checkDate: DateTime.parse("2024-06-20 17:00:20"),
          status: 1,
          staff: null),
    ];
    selectedYear = DateTime.now().year;
    filterOption = filters[3];
  }

  @override
  Widget build(BuildContext context) {
    Future displayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 360.w,
                height: 370.h,
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButton<int>(
                          value: selectedYear,
                          hint: Text("Chọn năm"),
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
                      ),
                      SizedBox(
                        height: 8.h,
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
                                      color: Colors.black,
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
                        action: () {
                          if (filterOption == 'All time') {
                            resetSearch();
                          } else {
                            filter(filterOption);
                          }
                        },
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

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TNormalAppBar(
        title: "Attendance history",
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MyRoomScreen(
                  myRoom: Room(
                    roomId: 1,
                    managerId: 1,
                    roomName: "“Sunflower” Room",
                  ),
                );
              },
            ),
          );
        },
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
            color: const Color.fromARGB(255, 35, 47, 107),
          ),
        ),
      ),
      body: Container(
        width: 360.w,
        height: 710.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: myAttendance.map(
              (e) {
                print(e.checkDate);

                return AttendanceHistoryDetails(
                  details: e,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
