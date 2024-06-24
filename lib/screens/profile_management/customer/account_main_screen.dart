import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_element.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class AccountMainScreen extends StatefulWidget {
  const AccountMainScreen({super.key});

  @override
  State<AccountMainScreen> createState() => _AccountMainScreenState();
}

class _AccountMainScreenState extends State<AccountMainScreen> {
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  late Customer? customer;
  int? packId; // lấy ra id của gói mà người dùng sở hữu
  List<Color> avatarBorder = [];

  @override
  void initState() {
    super.initState();
    customer = Customer(
      customerId: 1,
      email: "loremispum@gmail.com",
      fullName: "Lorem Ispum",
      avatar: "assets/pics/user_test.png",
    );
    packId = 1;
    avatarBorder = ProjectData.getGradient(packId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TNormalAppBar(
        title: "My Account",
        isBordered: false,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MainScreen(
                  inputScreen: HomeScreen(),
                  screenIndex: 0,
                );
              },
            ),
          );
        },
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
                onTap: () {},
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
                                image: AssetImage(customer!.avatar!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              border: GradientBoxBorder(
                                width: 2.w,
                                gradient: LinearGradient(
                                  colors: avatarBorder != []
                                      ? avatarBorder
                                      : const [
                                          Color.fromARGB(255, 244, 244, 244),
                                          Color.fromARGB(255, 244, 244, 244),
                                        ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customer!.fullName,
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 32, 35, 43),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                customer!.email,
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
                      choose: () {},
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
                      icon: IconsaxPlusLinear.heart,
                      title: "Favorites",
                      choose: () {},
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
                      choose: () {},
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
                      choose: () {},
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
                      icon: IconsaxPlusLinear.messages_2,
                      title: "Need help? Let’s chat",
                      choose: () {},
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
