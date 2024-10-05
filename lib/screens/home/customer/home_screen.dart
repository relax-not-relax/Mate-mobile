import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/helper.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/customer_in_room.dart';
import 'package:mate_project/models/event.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/response/PackOfCustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/models/room_assign.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/repositories/event_repository.dart';
import 'package:mate_project/screens/home/customer/widgets/lock_event.dart';
import 'package:mate_project/screens/home/customer/widgets/lock_membership.dart';
import 'package:mate_project/screens/home/customer/widgets/lock_my_room.dart';
import 'package:mate_project/screens/home/customer/widgets/my_room.dart';
import 'package:mate_project/screens/home/customer/widgets/open_event.dart';
import 'package:mate_project/screens/home/customer/widgets/room_membership.dart';
import 'package:mate_project/screens/home/staff/widgets/room_assigned.dart';
import 'package:mate_project/screens/subscription/room_subscription_screen.dart';
import 'package:mate_project/widgets/app_bar/main_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int tabIndex;
  CustomerResponse? customer;
  EventRepository eventRepository = EventRepository();
  List<Event> listEvents = [];
  Pack? pack;
  RoomAssign? roomAssign;
  AttendanceRepo attendanceRepository = AttendanceRepo();
  Future<List<Attendance>> getAttendanceInRoom(
      DateTime inDate, int roomId) async {
    return await attendanceRepository.GetAttendanceByRoomCustomer(
        inDate: inDate, roomId: roomId);
  }

  Future<RoomAssign?> getRoomGold(int type, DateTime inDate) async {
    int roomId1 = 0;
    String roomName1 = "";
    switch (type) {
      case 1:
        roomId1 = 1;
        roomName1 = "Iris";
        break;
      case 2:
        roomId1 = 2;
        roomName1 = "Peony";
        break;
      case 3:
        roomId1 = 3;
        roomName1 = "Lotus";
        break;
      case 4:
        roomId1 = 4;
        roomName1 = "Infinite Frontier";
        break;
      case 5:
        roomId1 = 5;
        roomName1 = "New Haven";
        break;
      case 6:
        roomId1 = 6;
        roomName1 = "Horizon Edge";
        break;
      case 7:
        roomId1 = 7;
        roomName1 = "HeartLink";
        break;
      case 8:
        roomId1 = 8;
        roomName1 = "TrueBond";
        break;
      case 9:
        roomId1 = 9;
        roomName1 = "DreamScape";
        break;
    }
    List<Attendance> attendanceRoom1 =
        await getAttendanceInRoom(inDate, roomId1);
    if (attendanceRoom1.isNotEmpty) {
      List<CustomerInRoom> customerInRooms = [];
      for (var element in attendanceRoom1) {
        CustomerInRoom cusInRoom = CustomerInRoom(
            room: Room(roomId: roomId1, managerId: 0, roomName: roomName1),
            customer: element.customer!,
            joinDate: element.checkDate);
        customerInRooms.add(cusInRoom);
      }
      RoomAssign room1 = RoomAssign(
          customerInRoom: customerInRooms,
          isAssigned: attendanceRoom1.first.staff != null,
          assignDate: DateTime.now(),
          staff: attendanceRoom1.first.staff);
      return room1;
    }
    return null;
  }

  Future<CustomerResponse?> getCustomer() async {
    return await SharedPreferencesHelper.getCustomer();
  }

  Future<List<Event>> getEvent() async {
    return (await eventRepository.GetAllEvent());
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabIndex = 0;
    getEvent().then(
      (value) {
        listEvents = value;
        getCustomer().then(
          (value) async {
            if (mounted && value != null) {
              if (mounted) {
                setState(() {
                  customer = value;
                  PackOfCustomerResponse? packOC = value.packs.firstOrNull;
                  if (packOC != null) {
                    pack = Helper.getPackFromId(packOC.packId);
                  }
                });
              }
            }
            getRoomGold(customer!.customerInRooms.first.roomId, DateTime.now())
                .then(
              (value) {
                if (value != null && mounted) {
                  setState(() {
                    roomAssign = value;
                  });
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget event = Container();

    switch (tabIndex) {
      case 0:
        Event? eventGet = listEvents
            .where((e) =>
                e.startTime.month == DateTime.now().month &&
                e.startTime.year == DateTime.now().year &&
                e.startTime.day <= DateTime.now().day)
            .lastOrNull;
        //use when user is not a member
        if (eventGet == null) {
          event = LockEvent();
        } else {
          event = OpenEvent(event: eventGet);
        }

        //use when user is a member
        // event = OpenEvent(
        //   event: Event(
        //     title: "Summer sounds",
        //     imgUrl: "assets/pics/concert.png",
        //     description:
        //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        //     start: DateTime.now(),
        //   ),
        // );
        break;
      case 1:
        Event? eventGet = listEvents
            .where((e) =>
                e.startTime.month == DateTime.now().month &&
                e.startTime.year == DateTime.now().year)
            .lastOrNull;
        //use when user is not a member
        if (eventGet == null) {
          event = LockEvent();
        } else {
          event = OpenEvent(event: eventGet);
        }
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: TMainAppBar(
        customer: Customer(
          customerId: customer != null ? customer!.customerId : 0,
          email: customer != null ? customer!.email : "",
          fullName: customer != null ? customer!.fullname : "loading...",
          avatar: customer != null
              ? customer!.avatar
              : "https://firebasestorage.googleapis.com/v0/b/mate-ccd5e.appspot.com/o/uploads%2Fno_ava.png?alt=media&token=ff9f001c-a953-42a8-9406-2f9bceb0b11e",
        ),
        open: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return RoomSubscriptionScreen(customer: customer!);
              },
            ),
            (route) => false,
          );
        },
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pics/decor_home.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 360.w,
                height: 1.h,
                color: const Color.fromARGB(255, 233, 233, 234),
              ),
              SizedBox(
                height: 16.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  //Change based on account
                  customer != null ? customer!.fullname : "",
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 148, 141, 246),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "How do you feel today?",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Our activities",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 168.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 234, 234, 235),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: TabBar(
                      controller: tabController,
                      labelColor: Colors.black,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: (value) {
                        if (mounted) {
                          setState(() {
                            tabIndex = value;
                          });
                        }
                      },
                      unselectedLabelColor:
                          const Color.fromARGB(255, 154, 155, 159),
                      indicatorColor: Colors.white,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: -20.w),
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(
                          text: 'Today',
                        ),
                        Tab(
                          text: 'Month',
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              event,
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PackMembership(
                    pack: pack != null
                        ? pack!
                        : Pack(
                            packId: 1,
                            packName: "Loading",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                            price: 0.0,
                            duration: 12,
                            status: true,
                          ),
                  ),
                  MyRoom(
                    roomA: roomAssign,
                    room: Room(
                      roomId: customer != null
                          ? customer!.customerInRooms.first.roomId
                          : 0,
                      managerId: 1,
                      roomName: Helper.getRoomName(customer != null
                          ? customer!.customerInRooms.first.roomId
                          : 0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
