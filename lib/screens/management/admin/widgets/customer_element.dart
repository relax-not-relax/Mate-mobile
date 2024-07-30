import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/helper/helper.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/management/admin/user_profile_screen.dart';
import 'package:unicons/unicons.dart';

class CustomerElement extends StatefulWidget {
  const CustomerElement({
    super.key,
    required this.customer,
    required this.action,
  });

  final CustomerResponse customer;
  final void Function(CustomerResponse) action;

  @override
  State<CustomerElement> createState() => _CustomerElementState();
}

class _CustomerElementState extends State<CustomerElement> {
  @override
  void initState() {
    super.initState();
    // Test data, gọi API để lấy dữ liệu gói đăng ký từ widget.customer
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      margin: EdgeInsets.only(
        bottom: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfileScreen(
                      fullName: widget.customer.fullname,
                      email: widget.customer.email,
                      phone: widget.customer.phoneNumber ?? "",
                      avatar: widget.customer.avatar ?? "",
                      birthday: DateFormat("dd/MM/yyyy").format(
                          widget.customer.dateOfBirth ?? DateTime.now()),
                      gender: widget.customer.gender ?? "",
                      address: widget.customer.address ?? "",
                      favorites: widget.customer.favorite ?? "",
                      note: widget.customer.note ?? "",
                      packName: Helper.convertRoomToPackName(
                          widget.customer.customerInRooms.isEmpty
                              ? 0
                              : widget.customer.customerInRooms.first.roomId),
                      isStaff: false,
                    );
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.w,
                  backgroundImage: widget.customer.avatar != null
                      ? NetworkImage(widget.customer.avatar!)
                      : AssetImage("assets/pics/no_ava.png"),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 200.w,
                  height: 50.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.customer.fullname,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Flexible(
                        child: Text(
                          "${Helper.convertRoomToPackName(widget.customer.customerInRooms.isEmpty ? 0 : widget.customer.customerInRooms.first.roomId)} Membership",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              widget.action(widget.customer);
            },
            child: Icon(
              UniconsLine.ellipsis_h,
              color: Colors.white,
              size: 20.sp,
            ),
          )
        ],
      ),
    );
  }
}
