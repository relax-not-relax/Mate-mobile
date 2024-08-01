import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/screens/management/admin/widgets/customer_list.dart';
import 'package:mate_project/screens/management/admin/widgets/staff_list.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({
    super.key,
  });

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
  CustomerRepository customerRepository = CustomerRepository();
  StaffRepository staffRepository = StaffRepository();

  List<CustomerResponse> listCustomer = [];
  List<Staff> listStaff = [];

  Future<List<CustomerResponse>> getCustomers() async {
    List<CustomerResponse> rs =
        (await customerRepository.GetCustomerByAdmin(page: 1, pageSize: 1000));

    return rs;
  }

  Future<List<Staff>> getStaff() async {
    List<Staff> rs =
        (await staffRepository.GetStaffByAdmin(page: 1, pageSize: 1000));

    return rs;
  }

  @override
  void initState() {
    super.initState();
    getCustomers().then(
      (value) {
        if (mounted)
          setState(() {
            listCustomer = value;
            content = CustomerList(
              customers: listCustomer,
            );
            customerAmount = listCustomer.length;
          });
      },
    );
    getStaff().then(
      (value) {
        if (mounted)
          setState(() {
            listStaff = value;
            content = StaffList(
              staffs: listStaff,
            );
            staffAmount = listStaff.length;
          });
      },
    );
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

  Widget content = Container();

  @override
  Widget build(BuildContext context) {
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
                if (mounted)
                  setState(() {
                    tIndex = value;
                  });
                switch (tIndex) {
                  case 0:
                    content = CustomerList(customers: listCustomer);
                    break;
                  case 1:
                    content = StaffList(
                      staffs: listStaff,
                    );
                    break;
                }
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
