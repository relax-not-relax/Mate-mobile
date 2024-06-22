import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/management/customer/care_history_screen.dart';
import 'package:mate_project/screens/management/customer/widgets/attendance_details.dart';
import 'package:unicons/unicons.dart';

class MyRoomScreen extends StatefulWidget {
  const MyRoomScreen({
    super.key,
    required this.myRoom,
  });

  final Room myRoom;

  @override
  State<MyRoomScreen> createState() => _MyRoomScreenState();
}

class _MyRoomScreenState extends State<MyRoomScreen> {
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  int? packId;
  Customer? myInfo;
  List<Attendance> myAttendance = [];
  List<Color> packColor = [];
  Color? buttonBackground;

  @override
  void initState() {
    super.initState();
    packId = 1;
    myInfo = Customer(
      customerId: 1,
      email: "loremispun@gmail.com",
      fullName: "Lorem ispun",
      avatar: "assets/pics/user_test.png",
    );
    myAttendance = [
      Attendance(
        attendanceId: 1,
        customerId: 1,
        staffId: 1,
        checkDate: DateTime.now(),
        status: 1,
      ),
      Attendance(
        attendanceId: 2,
        customerId: 1,
        staffId: 1,
        checkDate: DateTime.now(),
        status: 3,
      ),
    ];
    packColor = ProjectData.getGradient(packId!);
  }

  @override
  Widget build(BuildContext context) {
    switch (packId) {
      case 1:
        buttonBackground = const Color.fromARGB(90, 255, 223, 150);
        break;
      case 2:
        buttonBackground = const Color.fromARGB(90, 202, 202, 230);
        break;
      case 3:
        buttonBackground = const Color.fromARGB(90, 247, 160, 89);
        break;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: Container(
        width: 360.w,
        height: 800.h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 32.h,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: packColor,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(34, 20, 19, 19),
                      blurRadius: 32,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8.w,
                          children: [
                            CircleAvatar(
                              radius: 24.w,
                              backgroundImage: AssetImage(
                                myInfo!.avatar!,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myInfo!.fullName,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  widget.myRoom.roomName,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              buttonBackground,
                            ),
                          ),
                          icon: Icon(
                            UniconsLine.multiply,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Overview",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 360.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300.w * 0.5,
                            padding: EdgeInsets.only(
                              left: 16.w,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 183, 183, 183),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Presence",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "150",
                                  style: GoogleFonts.inter(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300.w * 0.5,
                            padding: EdgeInsets.only(
                              left: 16.w,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Absence",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "2",
                                  style: GoogleFonts.inter(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Day-care staff",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CareHistoryScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "View history",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 67, 90, 204),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Container(
                  width: 360.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.w,
                        children: [
                          CircleAvatar(
                            radius: 22.w,
                            backgroundImage:
                                const AssetImage("assets/pics/nurse.png"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lorem ispum",
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 58, 58, 58),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Mate’s staff",
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 58, 58, 58),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconsaxPlusBold.call,
                          color: const Color.fromARGB(255, 140, 159, 255),
                          size: 20.sp,
                        ),
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 238, 241, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Attendance information",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "View history",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 67, 90, 204),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 800.h * 0.45,
                width: 360.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: ListView.builder(
                  itemCount: myAttendance.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AttendanceDetails(
                          details: myAttendance[index],
                          index: index,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
