import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/authentication/login_selection_screen.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/profile_management/account_address_screen.dart';
import 'package:mate_project/screens/profile_management/edit_language_screen.dart';
import 'package:mate_project/screens/profile_management/edit_password_screen.dart';
import 'package:mate_project/screens/profile_management/edit_profile_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_favorite_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_element.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class CustomerAccountMainScreen extends StatefulWidget {
  const CustomerAccountMainScreen({super.key});

  @override
  State<CustomerAccountMainScreen> createState() =>
      _CustomerAccountMainScreenState();
}

class _CustomerAccountMainScreenState extends State<CustomerAccountMainScreen> {
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  Customer customer =
      Customer(customerId: 0, email: "loading....", fullName: "loading...");
  CustomerResponse? customerR;
  int? packId; // lấy ra id của gói mà người dùng sở hữu
  List<Color> avatarBorder = [];
  Future<CustomerResponse?> getCustomer() async {
    return SharedPreferencesHelper.getCustomer();
  }

  @override
  void initState() {
    super.initState();
    getCustomer().then(
      (value) {
        if (mounted) {
          setState(() {
            customerR = value;
            customer = Customer(
                customerId: value!.customerId,
                email: value!.email,
                fullName: value.fullname,
                address: value.address,
                avatar: "assets/pics/user_test.png",
                dateOfBirth: value.dateOfBirth.toString(),
                favorite: value.favorite,
                gender: value.gender,
                note: value.note,
                phoneNumber: value.phoneNumber);
          });
        }
      },
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
                        return EditProfileScreen(customer: customerR!);
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
                                image: (customer!.avatar != null &&
                                        customer!.avatar!.isNotEmpty)
                                    ? NetworkImage(customerR!.avatar!)
                                    : AssetImage("assets/pics/user_test.png"),
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
                      icon: IconsaxPlusLinear.heart,
                      title: "Favorites",
                      choose: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CustomerFavoriteScreen();
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
                              return const EditPasswordScreen(
                                isStaff: false,
                              );
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
                      choose: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainScreen(
                                inputScreen: ChatScreen(
                                  isAdmin: false,
                                  customerResponse: customerR!,
                                ),
                                screenIndex: 1,
                                customerResponse: customerR!,
                              );
                            },
                          ),
                          (route) => false,
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
                  onTap: () async {
                    SharedPreferencesHelper.removeCustomer().then(
                      (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginSelectionScreen();
                            },
                          ),
                          (route) => false,
                        );
                      },
                    );
                  },
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
