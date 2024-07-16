import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/screens/management/admin/widgets/customer_list.dart';
import 'package:mate_project/screens/management/admin/widgets/staff_list.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({
    super.key,
    required this.tabIndex,
  });

  final int tabIndex;

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int tIndex;
  // Số lượng customer
  late int customerAmount;
  // Số lượng nhân viên
  late int staffAmount;

  @override
  void initState() {
    super.initState();
    tIndex = widget.tabIndex;
    tabController = TabController(length: 2, vsync: this);
    // Test data (Call API để lấy dữ liệu)
    customerAmount = 100;
    staffAmount = 30;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container();

    switch (tIndex) {
      case 0:
        content = CustomerList();
        break;
      case 1:
        content = StaffList();
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "User's Data",
        isBordered: false,
        isBack: false,
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        titleColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              controller: tabController,
              labelColor: const Color.fromARGB(255, 182, 177, 249),
              labelStyle: GoogleFonts.inter(
                  fontSize: 14.sp, fontWeight: FontWeight.w600),
              unselectedLabelColor: const Color.fromARGB(255, 112, 114, 118),
              indicatorColor: const Color.fromARGB(255, 182, 177, 249),
              dividerColor: const Color.fromARGB(255, 41, 45, 50),
              onTap: (value) {
                setState(() {
                  tIndex = value;
                });
              },
              tabs: [
                Tab(
                  text: 'Customer ($customerAmount)',
                ),
                Tab(
                  text: 'Staff ($staffAmount)',
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
