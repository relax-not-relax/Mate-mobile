// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/screens/management/admin/user_data_screen.dart';
import 'package:mate_project/screens/management/admin/widgets/note_view.dart';
import 'package:mate_project/screens/management/admin/widgets/text_field_view.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/outline_button_custom.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.birthday,
    required this.gender,
    required this.address,
    required this.favorites,
    required this.note,
    this.packName,
    required this.isStaff,
  });

  final String fullName;
  final String email;
  final String phone;
  final String avatar;
  final String birthday;
  final String gender;
  final String address;
  final String favorites;
  final String note;
  String? packName;
  final bool isStaff;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // ignore: prefer_final_fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _favoritesController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.fullName;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _birthdayController.text = widget.birthday;
    _genderController.text = widget.gender;
    _addressController.text = widget.address;
    _favoritesController.text = widget.favorites;
    _noteController.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Profile",
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (widget.isStaff) {
                  return const AdminMainScreen(
                    inputScreen: UserDataScreen(),
                    screenIndex: 1,
                  );
                } else {
                  return const AdminMainScreen(
                    inputScreen: UserDataScreen(),
                    screenIndex: 1,
                  );
                }
              },
            ),
          );
        },
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        titleColor: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.avatar == ""
                        ? const AssetImage("assets/pics/no_ava.png")
                        : NetworkImage(widget.avatar),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              !widget.isStaff
                  ? Text(
                      "${widget.packName!} Membership",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 24.h,
              ),
              TextFieldView(
                controller: _nameController,
                title: "Full name",
                iconData: IconsaxPlusBold.profile,
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFieldView(
                controller: _emailController,
                title: "Email",
                iconData: IconlyBold.message,
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFieldView(
                controller: _phoneController,
                title: "Phone number",
                iconData: IconsaxPlusBold.call,
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFieldView(
                controller: _birthdayController,
                title: "Birthday",
                iconData: IconlyBold.calendar,
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFieldView(
                controller: _genderController,
                title: "Gender",
                iconData: IconsaxPlusBold.profile_2user,
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFieldView(
                controller: _addressController,
                title: "Address",
                iconData: IconlyBold.location,
              ),
              !widget.isStaff
                  ? SizedBox(
                      height: 16.h,
                    )
                  : Container(),
              !widget.isStaff
                  ? TextFieldView(
                      controller: _favoritesController,
                      title: "Favorites",
                      iconData: IconlyBold.heart,
                    )
                  : Container(),
              !widget.isStaff
                  ? SizedBox(
                      height: 16.h,
                    )
                  : Container(),
              !widget.isStaff
                  ? NoteView(
                      controller: _noteController,
                    )
                  : Container(),
              SizedBox(
                height: 32.h,
              ),
              OutlineButtonCustom(
                name: widget.isStaff ? "Delete user" : "Deactivate user",
                action: () {},
                selectionColor: const Color.fromARGB(255, 234, 68, 53),
              ),
              SizedBox(
                height: 48.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
