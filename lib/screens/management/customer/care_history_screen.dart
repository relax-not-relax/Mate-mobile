import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/screens/management/customer/my_room_screen.dart';
import 'package:mate_project/screens/management/customer/widgets/search_field.dart';
import 'package:mate_project/screens/management/customer/widgets/staff_daily_details.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class CareHistoryScreen extends StatefulWidget {
  const CareHistoryScreen({super.key});

  @override
  State<CareHistoryScreen> createState() => _CareHistoryScreenState();
}

class _CareHistoryScreenState extends State<CareHistoryScreen> {
  TextEditingController _controller = TextEditingController();
  late int selectedYear;
  late String filterOption;
  CustomerResponse? customer = null;
  AttendanceRepo attendanceRepository = AttendanceRepo();
  List<Attendance> myAttendance = [];
  late ScrollController _scrollController;
  List<Attendance> myAttendanceOrigin = [];
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

    if (mounted)
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

    if (mounted)
      setState(() {
        myAttendance = myAttendanceOrigin;
      });
  }

  List<String> filters = [
    "This week",
    "This month",
    "This year",
    "All time",
  ];
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

        if (mounted)
          setState(() {
            myAttendanceOrigin.addAll(listAdd);
            myAttendance.addAll(listAdd);
          });
        page++;
      }
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _controller.text = "";
    super.initState();
    selectedYear = DateTime.now().year;
    filterOption = filters[3];
    getAttend();
  }

  void search(String search) {
    print(myAttendanceOrigin.length);
    myAttendance = myAttendanceOrigin
        .where((attendance) => attendance.staff!.fullName
            .toLowerCase()
            .contains(search.toLowerCase()))
        .toList();

    if (mounted)
      setState(() {
        myAttendance;
      });
  }

  void filter(String filter) async {
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

    if (mounted)
      setState(() {
        myAttendance = myAttendanceOrigin;
      });
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
                            if (mounted)
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
                                      if (mounted)
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
        title: "Care history",
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
        isBordered: false,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 72.h,
            left: 0,
            right: 0,
            child: Container(
              width: 360.w,
              height: 800.h * 0.8,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: myAttendance.map(
                    (e) {
                      return StaffDailyDetails(
                        dateCare: e.checkDate,
                        staff: e.staff!,
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 360.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: SearchField(
                controller: _controller,
                search: () {
                  search(_controller.text);
                },
                filter: () {
                  displayBottomSheet(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
