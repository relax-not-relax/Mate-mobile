import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/response/TotalAttendance.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/screens/management/customer/attendance_history_screen.dart';
import 'package:mate_project/screens/management/customer/care_history_screen.dart';
import 'package:mate_project/screens/management/customer/widgets/attendance_details.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

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
  AttendanceRepo attendanceRepository = AttendanceRepo();
  late CustomerBloc _customerBloc;
  CustomerResponse? customer = null;
  late ScrollController _scrollController;
  int page = 1;
  final int size = 20;
  String roomName = "Loading";
  Staff? staff = null;
  StaffRepository staffRepository = StaffRepository();
  TotalAttendanceResponse? totalAttendanceResponse;

  Future getAttend() async {
    customer = await SharedPreferencesHelper.getCustomer();
    myAttendance = await attendanceRepository.GetAttendanceOfCustomer(
        filterType: 0,
        pageSize: size,
        page: page,
        customerId: customer!.customerId);
    totalAttendanceResponse = await attendanceRepository.GetTotalAttendance(
        customerId: customer!.customerId);
    page++;

    if (mounted)
      setState(() {
        myAttendance;
      });
  }

  Future setStaff() async {
    if (myAttendance.first.staffId == 0) {
      staff = Staff(
          staffId: 0,
          email: "admin@gmail.com",
          fullName: "Admin care",
          avatar: "avt admin",
          phoneNumber: "0929828327");
    } else {
      staff = myAttendance.first.staff;
    }

    if (mounted)
      setState(() {
        staff;
      });
  }

  void setRoomName() {
    String r = "";
    switch (widget.myRoom.roomId) {
      case 1:
        r = "Sunflower";
        break;
      case 2:
        r = "Lily";
        break;
      case 3:
        r = "Soulmate";
        break;
      case 4:
        r = "F4 plus";
        break;
      case 5:
        r = "New Zone";
        break;
      case 6:
        r = "New World";
        break;
    }

    if (mounted)
      setState(() {
        roomName = r;
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lưu trữ tham chiếu đến CustomerBloc
    _customerBloc = BlocProvider.of<CustomerBloc>(context);
  }

  @override
  void dispose() {
    // Sử dụng CustomerBloc một cách an toàn
    _customerBloc.close();
    super.dispose();
  }

  void _onScroll() async {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels != 0;
      if (isBottom) {
        print("add");

        List<Attendance> listAdd =
            await attendanceRepository.GetAttendanceOfCustomer(
                filterType: 0,
                pageSize: size,
                page: page,
                customerId: customer!.customerId);

        if (mounted)
          setState(() {
            myAttendance.addAll(listAdd);
          });
        page++;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getAttend().then(
      (value) {
        setRoomName();
        setStaff();
      },
    );

    packId = 1;
    myInfo = Customer(
      customerId: 1,
      email: "loremispun@gmail.com",
      fullName: "Lorem ispun",
      avatar: "assets/pics/user_test.png",
    );
    packColor = ProjectData.getGradient(packId!);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
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
        body: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) async {
            if (state is ViewAttendanceSuccess) {
              myAttendance.addAll(state.listAttendance);
            }
          },
          child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
            return Container(
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
                                    backgroundImage: customer == null
                                        ? AssetImage(
                                            "assets/pics/user_test.png")
                                        : (customer!.avatar != null &&
                                                customer!.avatar!.isNotEmpty)
                                            ? NetworkImage(customer!.avatar!)
                                            : AssetImage(
                                                "assets/pics/user_test.png"),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customer == null
                                            ? "Loading"
                                            : customer!.fullname,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        roomName,
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
                                        color:
                                            Color.fromARGB(255, 183, 183, 183),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        totalAttendanceResponse == null
                                            ? "0"
                                            : totalAttendanceResponse!.present
                                                .toString(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        totalAttendanceResponse == null
                                            ? "0"
                                            : totalAttendanceResponse!.absent
                                                .toString(),
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
                                    return const CareHistoryScreen();
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
                                  backgroundImage: staff == null
                                      ? const AssetImage(
                                          "assets/pics/nurse.png")
                                      : (staff!.avatar == null &&
                                              staff!.avatar!.isEmpty)
                                          ? const AssetImage(
                                              "assets/pics/nurse.png")
                                          : NetworkImage(staff!.avatar!),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      staff == null
                                          ? "Loading"
                                          : staff!.fullName,
                                      style: GoogleFonts.inter(
                                        color: const Color.fromARGB(
                                            255, 58, 58, 58),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Mate’s staff",
                                      style: GoogleFonts.inter(
                                        color: const Color.fromARGB(
                                            255, 58, 58, 58),
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
                              onPressed: () {
                                _makePhoneCall(staff!.phoneNumber!);
                              },
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
                            onTap: () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const AttendanceHistoryScreen();
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
                    Container(
                      height: 800.h * 0.45,
                      width: 360.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
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
            );
          }),
        ));
  }
}
