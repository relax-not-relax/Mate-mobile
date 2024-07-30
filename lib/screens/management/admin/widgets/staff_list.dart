import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/screens/management/admin/widgets/search_field.dart';
import 'package:mate_project/screens/management/admin/widgets/staff_element.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class StaffList extends StatefulWidget {
  const StaffList({super.key, required this.staffs});
  final List<Staff> staffs;

  @override
  // ignore: no_logic_in_create_state
  State<StaffList> createState() => _StaffListState(staffList: staffs);
}

class _StaffListState extends State<StaffList> {
  TextEditingController _controller = TextEditingController();
  // Test data, gọi API để lấy danh sách khách hàng của hệ thống
  List<Staff> staffList;
  List<String> filters = [
    "A - Z",
    "Z - A",
  ];
  List<bool> selectedOptions = [
    false,
    false,
  ];

  _StaffListState({required this.staffList});

  @override
  void initState() {
    super.initState();
    _controller.text = "";
    // Call API to get staffs
  }

  @override
  Widget build(BuildContext context) {
    Future displayUserAction(BuildContext context, Staff staff) {
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
                  backgroundImage: AssetImage(staff.avatar!),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Flexible(
                  child: Text(
                    staff.fullName,
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
                    "Delete user",
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
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 360.w,
                height: 300.h,
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
            hint: "Search for staff",
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
                  children: staffList.map(
                    (e) {
                      return StaffElement(
                        staff: e,
                        action: (staff) {
                          displayUserAction(context, staff);
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
