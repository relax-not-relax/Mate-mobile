import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/screens/management/admin/widgets/customer_element.dart';
import 'package:mate_project/screens/management/admin/widgets/search_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  TextEditingController _controller = TextEditingController();
  // Test data, gọi API để lấy danh sách khách hàng của hệ thống
  List<Customer> customers = [];
  List<String> filters = [
    "A - Z",
    "Z - A",
    "Gold membership",
    "Silver membership",
    "Bronze membership",
    "Inactive",
  ];
  List<bool> selectedOptions = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    _controller.text = "";
    // Call API to get customers
    customers = [
      Customer(
          customerId: 1,
          email: "test@gmail.com",
          fullName: "Lorem ispum",
          avatar: "assets/pics/user_test.png",
          dateOfBirth: "1975-01-01 17:00:20",
          gender: "Male",
          favorite: "Music, dolor sit amet",
          note:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
      Customer(
        customerId: 2,
        email: "test1@gmail.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/user_test_1.png",
        dateOfBirth: "1975-01-01 17:00:20",
        gender: "Male",
      ),
      Customer(
        customerId: 3,
        email: "test2@gmail.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/user_test_2.png",
        dateOfBirth: "1975-01-01 17:00:20",
        gender: "Female",
      ),
      Customer(
        customerId: 4,
        email: "test3@gmail.com",
        fullName: "Lorem ispum",
        avatar: "assets/pics/user_test_3.png",
        dateOfBirth: "1975-01-01 17:00:20",
        gender: "Male",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Future displayUserAction(BuildContext context, Customer customer) {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: 360.w,
            height: 220.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 41, 46),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.w,
                  backgroundImage: AssetImage(customer.avatar!),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Flexible(
                  child: Text(
                    customer.fullName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Divider(
                  height: 1.h,
                  color: const Color.fromARGB(255, 65, 67, 73),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Deactivate user",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 234, 68, 53),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Future displayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 360.w,
                height: 800.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 37, 41, 46),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "Sort by",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Column(
                          children: filters.map(
                            (e) {
                              return CheckboxListTile(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                splashRadius: 10.w,
                                title: Text(
                                  e,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                value: selectedOptions[filters.indexOf(e)],
                                onChanged: (value) {
                                  setState(() {
                                    selectedOptions[filters.indexOf(e)] =
                                        value!;
                                  });
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                    NormalButtonCustom(
                      name: "Confirm",
                      action: () {
                        List<String> selectedStrings = [];
                        for (int i = 0; i < selectedOptions.length; i++) {
                          if (selectedOptions[i]) {
                            selectedStrings.add(filters[i]);
                          }
                        }
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: SearchField(
            controller: _controller,
            search: (p0) {},
            filter: () {
              displayBottomSheet(context);
            },
            hint: "Search for customer",
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          width: 360.w,
          height: 810.h * 0.7,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: customers.map(
                    (e) {
                      return CustomerElement(
                        customer: e,
                        action: (customer) {
                          displayUserAction(context, customer);
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 150.h,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
