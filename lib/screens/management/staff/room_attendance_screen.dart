import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/blocs/staff_bloc.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/staff_event.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/attendance_type.dart';
import 'package:mate_project/models/check_attendance.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/day_attendance.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/management/staff/staff_schedule_screen.dart';
import 'package:mate_project/screens/management/staff/widgets/attendance_of_day.dart';
import 'package:mate_project/screens/management/staff/widgets/attendance_selection.dart';
import 'package:mate_project/states/staff_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class RoomAttendanceScreen extends StatefulWidget {
  const RoomAttendanceScreen({
    super.key,
    required this.attendance,
    required this.room,
    required this.customer,
    required this.pack,
  });

  final DayAttendance attendance;
  final Room room;
  final CustomerResponse customer;
  final Pack pack;

  @override
  State<RoomAttendanceScreen> createState() => _RoomAttendanceScreenState();
}

class _RoomAttendanceScreenState extends State<RoomAttendanceScreen> {
  // Lấy dữ liệu về phòng, loại gói và người ở trong phòng
  late Room room;
  late CustomerResponse customer;
  late Pack pack;

  bool isSelecting = false;
  late AttendanceType type;
  String attendStatus = "";
  bool posibleSave = false;
  NormalDialogCustom dialogCustom = NormalDialogCustom();

  @override
  void initState() {
    super.initState();
    room = widget.room;
    customer = widget.customer;
    pack = widget.pack;
    print(widget.attendance.morningAttendance.toJson().toString());
    print(widget.attendance.eveningAttendance.toJson().toString());
    type = ProjectData.attendanceType[0];
    switch (widget.attendance.morningAttendance.status) {
      case 1:
        attendStatus = "Present";
        break;
      case 2:
        attendStatus = "Absent";
        break;
      case 3:
        attendStatus = "";
        break;
    }

    if (mounted)
      setState(() {
        attendStatus;
      });
    if (type.session == "Morning") {
      if (widget.attendance.morningAttendance.checkDate.day ==
              DateTime.now().day &&
          widget.attendance.morningAttendance.checkDate.month ==
              DateTime.now().month &&
          widget.attendance.morningAttendance.checkDate.year ==
              DateTime.now().year &&
          DateTime.now().hour < 12) {
        if (mounted)
          setState(() {
            posibleSave = true;
          });
      } else {
        if (mounted)
          setState(() {
            posibleSave = false;
          });
      }
    } else {
      if (widget.attendance.morningAttendance.checkDate.day ==
              DateTime.now().day &&
          widget.attendance.morningAttendance.checkDate.month ==
              DateTime.now().month &&
          widget.attendance.morningAttendance.checkDate.year ==
              DateTime.now().year &&
          DateTime.now().hour > 12) {
        if (mounted)
          setState(() {
            posibleSave = true;
          });
      } else {
        if (mounted)
          setState(() {
            posibleSave = false;
          });
      }
    }
  }

  void waitingForSelection() {
    if (mounted)
      setState(() {
        isSelecting = true;
      });
  }

  void finishedSelection() {
    if (mounted)
      setState(() {
        isSelecting = false;
      });
  }

  void onSelectAttendanceSession(AttendanceType aType) {
    waitingForSelection();

    if (aType.session == "Morning") {
      switch (widget.attendance.morningAttendance.status) {
        case 1:
          attendStatus = "Present";
          break;
        case 2:
          attendStatus = "Absent";
          break;
        case 3:
          attendStatus = "";
          break;
      }

      if (mounted)
        setState(() {
          type = aType;
          attendStatus;
        });
    } else {
      switch (widget.attendance.eveningAttendance.status) {
        case 1:
          attendStatus = "Present";
          break;
        case 2:
          attendStatus = "Absent";
          break;
        case 3:
          attendStatus = "";
          break;
      }

      if (mounted)
        setState(() {
          type = aType;
          attendStatus;
        });
    }
    if (type.session == "Morning") {
      if (widget.attendance.morningAttendance.checkDate.day ==
              DateTime.now().day &&
          widget.attendance.morningAttendance.checkDate.month ==
              DateTime.now().month &&
          widget.attendance.morningAttendance.checkDate.year ==
              DateTime.now().year &&
          DateTime.now().hour < 12) {
        if (mounted)
          setState(() {
            posibleSave = true;
          });
      } else {
        if (mounted)
          setState(() {
            posibleSave = false;
          });
      }
    } else {
      if (widget.attendance.morningAttendance.checkDate.day ==
              DateTime.now().day &&
          widget.attendance.morningAttendance.checkDate.month ==
              DateTime.now().month &&
          widget.attendance.morningAttendance.checkDate.year ==
              DateTime.now().year &&
          DateTime.now().hour > 12) {
        if (mounted)
          setState(() {
            posibleSave = true;
          });
      } else {
        if (mounted)
          setState(() {
            posibleSave = false;
          });
      }
    }
    finishedSelection();
  }

  void onSelectAttendance(String aStatus) {
    waitingForSelection();
    // Lưu ý: Xử lý trường hợp đã điểm danh thì không     setState

    if (mounted)
      setState(() {
        attendStatus = aStatus;
      });
    finishedSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: const Color.fromARGB(255, 41, 45, 50),
        appBar: TNormalAppBar(
          title: room.roomName,
          isBordered: false,
          isBack: true,
          bgColor: const Color.fromARGB(255, 41, 45, 50),
          titleColor: Colors.white,
          back: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const StaffMainScreen(
                    inputScreen: StaffScheduleScreen(),
                    screenIndex: 2,
                  );
                },
              ),
              (route) => false,
            );
          },
        ),
        body: BlocListener<StaffBloc, StaffState>(
          listener: (context, state) async {
            if (state is SaveAttendanceLoading) {
              //them dialog
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/oldpeople.png',
                "Wating..",
                "Togetherness - Companion - Sharing",
                true,
                const Color.fromARGB(255, 68, 60, 172),
              );
            }
            if (state is SaveAttendanceSuccess) {
              //them dialog
              Navigator.of(context).pop();
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/oldpeople.png',
                "Save success",
                "Togetherness - Companion - Sharing",
                true,
                const Color.fromARGB(255, 68, 60, 172),
              );
              Future.delayed(Duration(seconds: 1)).then(
                (value) {
                  Navigator.of(context).pop();
                },
              );
            }
            if (state is SaveAttendanceFailure &&
                state.error.type == Failure.System) {
              //them dialog
              dialogCustom.showSelectionDialog(
                context,
                'assets/pics/error.png',
                'Save Fail',
                'Please check again',
                true,
                const Color.fromARGB(255, 230, 57, 71),
                'Continue',
                () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: BlocBuilder<StaffBloc, StaffState>(builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 24.w,
                  right: 24.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24.w,
                            backgroundImage: AssetImage(customer.avatar!),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customer.fullname,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${pack.packName} Membership",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      AttendanceOfDay(
                        aType: type,
                        onChoose: onSelectAttendanceSession,
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
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      24.w,
                      24.w,
                      32.h,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
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
                              "Take attendance",
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 35, 38, 47),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            AttendanceSelection(
                              status: attendStatus,
                              sessionType: type.session,
                              onSelect: onSelectAttendance,
                            ),
                          ],
                        ),
                        posibleSave
                            ?
                            // Xử lý nút "Save" với các trường hợp
                            // Trường hợp mọi thứ đều OK thì dùng nút này
                            NormalButtonCustom(
                                name: "Save",
                                action: () {
                                  List<CheckAttendance> list = [];

                                  CheckAttendance checkAttendance =
                                      CheckAttendance(
                                          customerId:
                                              widget.attendance.customerId,
                                          staffId: widget.attendance.staffId,
                                          status: attendStatus == "Present"
                                              ? "1"
                                              : "2",
                                          checkDate: DateTime.now());
                                  list.add(checkAttendance);
                                  BlocProvider.of<StaffBloc>(context).add(
                                      SaveAttendancePresses(
                                          checkAttendanceList: list));
                                },
                                background:
                                    const Color.fromARGB(255, 84, 110, 255),
                              )
                            :

                            // Trường hợp đã điểm danh hoặc chưa tới giờ điểm danh
                            const DisabledButtonCustom(name: "Save"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
