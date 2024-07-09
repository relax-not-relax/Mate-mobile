import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/models/staff.dart';
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
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  List<Staff> staffList = [];

  late int selectedYear;
  late String filterOption;
  List<String> filters = [
    "This week",
    "This month",
    "This year",
    "All time",
  ];

  @override
  void initState() {
    _controller.text = "";
    super.initState();
    staffList = [
      Staff(
        staffId: 1,
        email: "lorem@staff.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/nurse.png",
        status: true,
      ),
      Staff(
        staffId: 2,
        email: "lorem@staff.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/nurse.png",
        status: false,
      ),
      Staff(
        staffId: 3,
        email: "lorem@staff.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/nurse.png",
        status: true,
      ),
      Staff(
        staffId: 4,
        email: "lorem@staff.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/nurse.png",
        status: true,
      ),
      Staff(
        staffId: 5,
        email: "lorem@staff.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/nurse.png",
        status: true,
      ),
      Staff(
        staffId: 6,
        email: "lorem@staff.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/nurse.png",
        status: true,
      ),
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
                child: Column(
                  children: staffList.map(
                    (e) {
                      return StaffDailyDetails(
                        staff: e,
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
                search: (p0) {},
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
