import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/event.dart';
import 'package:mate_project/screens/home/widgets/lock_event.dart';
import 'package:mate_project/screens/home/widgets/lock_membership.dart';
import 'package:mate_project/screens/home/widgets/lock_my_room.dart';
import 'package:mate_project/screens/home/widgets/open_event.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabIndex = 0;
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
        //use when user is not a member
        event = LockEvent();

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
        //use when user is not a member
        //event = LockEvent();

        //use when user is a member
        event = OpenEvent(
          event: Event(
            title: "Summer sounds",
            imgUrl: "assets/pics/concert.png",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            start: DateTime.now(),
          ),
        );
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: TMainAppBar(
        customer: Customer(
          customerId: 1,
          email: "lorem@gmail.com",
          fullName: 'Lorem ispun',
          avatar: "assets/pics/user_test.png",
        ),
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
                  "Lorem ispun,",
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
                        setState(() {
                          tabIndex = value;
                        });
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
                          text: 'Week',
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
                  // use when user is not a member
                  // LockMembership(),
                  // LockMyRoom(),
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
