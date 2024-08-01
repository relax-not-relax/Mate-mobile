import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/screens/chat/admin/messages_list_screen.dart';
import 'package:mate_project/screens/home/admin/widgets/data_management_view.dart';
import 'package:mate_project/screens/home/admin/widgets/statistics_view.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late DateTime now;
  String formatDate = "";
  List<String> members = [
    "assets/pics/user_test_1.png",
    "assets/pics/user_test_2.png",
    "assets/pics/user_test_3.png",
  ];

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    formatDate = DateFormat('dd.MM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: 360.w,
        height: 800.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pics/admin_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 360.w,
                height: 320.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(148, 255, 255, 255),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 150.h,
              right: 0,
              left: 0,
              child: StatisticsView(
                currentMonth: DateTime.now(),
                revenue: 120120,
                profit: 1102,
              ),
            ),
            Positioned(
              top: 32.h,
              left: 24.w,
              right: 24.w,
              child: Container(
                width: 360.w,
                height: 800.h * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                8.w,
                                8.h,
                                12.w,
                                8.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 37, 41, 46),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8.w,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 84, 87, 91),
                                    radius: 20,
                                    child: Icon(
                                      IconlyLight.paper_plus,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    formatDate,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MessagesListScreen();
                                      },
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(169, 84, 87, 91),
                                  radius: 25,
                                  child: Badge(
                                    isLabelVisible: true,
                                    backgroundColor:
                                        const Color.fromARGB(255, 84, 110, 255),
                                    label: Text(
                                      "1",
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: const Icon(
                                      IconlyLight.chat,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  IconsaxPlusLinear.logout_1,
                                  size: 24.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome to",
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 243, 243, 243),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "The Administration Portal!",
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 202, 210, 255),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataManagementView(
                            amount: 100,
                            userImgs: members,
                            title: "Mate’s staff",
                          ),
                          DataManagementView(
                            amount: 100,
                            userImgs: members,
                            title: "Customers",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
