import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/room_assign.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/screens/management/admin/admin_assign_screen.dart';
import 'package:mate_project/screens/management/admin/widgets/room_member.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:unicons/unicons.dart';

class RoomAssignScreen extends StatefulWidget {
  const RoomAssignScreen({
    super.key,
    required this.roomAssign,
    required this.roomId,
    required this.inDate,
  });

  final RoomAssign roomAssign;
  final int roomId;
  final DateTime inDate;

  @override
  State<RoomAssignScreen> createState() => _RoomAssignScreenState();
}

class _RoomAssignScreenState extends State<RoomAssignScreen> {
  // Test data, gọi API để lấy danh sách nhân viên
  List<Staff> staffList = [];
  late Staff staffSelected;
  Widget? assignEl;
  bool isAssign = false;
  StaffRepository staffRepository = StaffRepository();
  AttendanceRepo attendanceRepository = AttendanceRepo();
  Future<List<Staff>> getStaffs() async {
    return await staffRepository.GetStaffByAdmin(page: 1, pageSize: 100);
  }

  Future<void> assingToStaff() async {
    List<int> customerIds = [];
    for (var element in widget.roomAssign.customerInRoom) {
      customerIds.add(element.customer.customerId);
    }
    await attendanceRepository.AssingAttendance(
        roomId: widget.roomId,
        inDate: widget.inDate,
        staffId: staffSelected.staffId,
        customerIds: customerIds);
    setState(() {
      isAssign = true;
    });
  }

  Future displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(255, 37, 41, 46),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 24.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Staff",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Container(
                        width: 360.w,
                        height: 250.h,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: ListView.builder(
                          itemCount: staffList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: 8.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 20.w,
                                        backgroundImage:
                                            staffList[index].avatar != null
                                                ? NetworkImage(
                                                    staffList[index].avatar!)
                                                : const AssetImage(
                                                    "assets/pics/no_ava.png"),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Text(
                                        staffList[index].fullName,
                                        style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Radio<Staff>(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor:
                                        const Color.fromARGB(255, 67, 90, 204),
                                    value: staffList[index],
                                    groupValue: staffSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        staffSelected = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                    ),
                    child: NormalButtonCustom(
                      name: "Confirm",
                      action: () {
                        Navigator.of(context).pop();
                        setStaff(staffSelected);
                        print(staffSelected.fullName);
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void setStaff(Staff staff) {
    setState(() {
      assignEl = GestureDetector(
        onLongPress: () {
          displayBottomSheet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.w,
              backgroundImage: AssetImage(staff.avatar!),
            ),
            SizedBox(
              width: 16.w,
            ),
            Text(
              staff.fullName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Call API to get staffs
    getStaffs().then(
      (value) {
        setState(() {
          staffList = value;
          staffSelected = staffList[0];
        });
      },
    );

    assignEl = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            displayBottomSheet(context);
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                  color: const Color.fromARGB(255, 152, 152, 152),
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
          width: 16.w,
        ),
        Text(
          "Choose staff",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: '"${widget.roomAssign.customerInRoom[0].room.roomName}" Room',
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AdminMainScreen(
                  inputScreen: AdminAssignScreen(),
                  screenIndex: 2,
                );
              },
            ),
          );
        },
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        titleColor: Colors.white,
      ),
      body: Container(
        width: 360.w,
        height: 710.h,
        padding: EdgeInsets.fromLTRB(
          24.w,
          0,
          24.w,
          40.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Room Members",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  children: widget.roomAssign.customerInRoom.map(
                    (e) {
                      return RoomMember(member: e);
                    },
                  ).toList(),
                ),
                Text(
                  "Assign to",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                widget.roomAssign.isAssigned
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20.w,
                            backgroundImage: widget.roomAssign.staff!.avatar !=
                                    null
                                ? NetworkImage(widget.roomAssign.staff!.avatar!)
                                : const AssetImage(
                                    "assets/pics/no_ava.png",
                                  ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(
                            widget.roomAssign.staff!.fullName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    : assignEl!,
              ],
            ),
            widget.roomAssign.isAssigned || isAssign
                ? const DisabledButtonCustom(
                    name: "Assign",
                  )
                : NormalButtonCustom(
                    name: "Assign",
                    action: () {
                      assingToStaff();
                    },
                    background: const Color.fromARGB(255, 84, 110, 255),
                  ),
          ],
        ),
      ),
    );
  }
}
