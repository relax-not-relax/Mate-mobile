import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/screens/profile_management/account_address_screen.dart';
import 'package:mate_project/screens/profile_management/edit_language_screen.dart';
import 'package:mate_project/screens/profile_management/edit_password_screen.dart';
import 'package:mate_project/screens/profile_management/edit_profile_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_element.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class StaffAccountMainScreen extends StatefulWidget {
  const StaffAccountMainScreen({super.key});

  @override
  State<StaffAccountMainScreen> createState() => _StaffAccountMainScreenState();
}

class _StaffAccountMainScreenState extends State<StaffAccountMainScreen> {
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  Staff? staff;
  CustomerResponse? customerResponse;

  @override
  void initState() {
    super.initState();
    staff = Staff(
      staffId: 1,
      email: "staff@mate.org",
      fullName: "Lorem Ipsum",
      avatar: "assets/pics/nurse.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TNormalAppBar(
        title: "My Account",
        isBordered: false,
        isBack: false,
      ),
      body: Container(
        width: 360.w,
        height: 710.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfileScreen(
                          customer: customerResponse!,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 24.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 244, 244),
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
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(staff!.avatar!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                staff!.fullName,
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 32, 35, 43),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                staff!.email,
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 32, 35, 43),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          )
                        ],
                      ),
                      Icon(
                        IconsaxPlusLinear.edit,
                        size: 20.sp,
                        color: const Color.fromARGB(255, 157, 158, 161),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "General",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 35, 47, 107),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 24.h,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 244, 244),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountEditElement(
                      icon: IconsaxPlusLinear.location,
                      title: "Address",
                      choose: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AccountAddressScreen();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      height: 0.5.h,
                      color: const Color.fromARGB(255, 189, 190, 191),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    AccountEditElement(
                      icon: IconsaxPlusLinear.security_safe,
                      title: "Change password",
                      choose: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const EditPasswordScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "System",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 35, 47, 107),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 24.h,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 244, 244),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountEditElement(
                      icon: IconsaxPlusLinear.global,
                      title: "Language",
                      choose: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const EditLanguageScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 24.h,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 244, 244),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        IconsaxPlusLinear.logout,
                        size: 22.sp,
                        color: const Color.fromARGB(255, 234, 68, 53),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "Logout",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 234, 68, 53),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
