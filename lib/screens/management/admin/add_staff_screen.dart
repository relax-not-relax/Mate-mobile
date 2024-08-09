// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/screens/management/admin/user_data_screen.dart';
import 'package:mate_project/screens/management/admin/widgets/edit_password_admin.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({super.key});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  StaffRepository staffRepository = StaffRepository();

  @override
  void initState() {
    super.initState();
    _nameController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Staff Registration",
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AdminMainScreen(
                  inputScreen: UserDataScreen(),
                  screenIndex: 1,
                );
              },
            ),
            (route) => false,
          );
        },
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        titleColor: Colors.white,
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 32.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AccountEditTextField(
                  controller: _nameController,
                  iconData: IconsaxPlusBold.profile,
                  type: TextInputType.name,
                  borderColor: Colors.white,
                  titleColor: Colors.white,
                  title: "Full name",
                ),
                SizedBox(
                  height: 16.h,
                ),
                AccountEditTextField(
                  controller: _emailController,
                  iconData: IconlyBold.message,
                  type: TextInputType.emailAddress,
                  borderColor: Colors.white,
                  titleColor: Colors.white,
                  title: "Email",
                ),
                SizedBox(
                  height: 16.h,
                ),
                EditPasswordAdmin(
                  controller: _passwordController,
                  borderColor: Colors.white,
                  title: "Init password",
                ),
              ],
            ),
            NormalButtonCustom(
              name: "Confirm",
              action: () async {
                //them dialog new
                NormalDialogCustom().showWaitingDialog(
                  context,
                  "assets/pics/oldpeople.png",
                  "Wait a minute",
                  "Adding staff",
                  false,
                  const Color.fromARGB(255, 68, 60, 172),
                );
                try {
                  Navigator.pop(context);
                  await staffRepository.CreateStaff(
                      fullName: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text);

                  NormalDialogCustom().showSelectionDialog(
                    context,
                    "assets/pics/oldpeople.png",
                    "Successfully registered",
                    "Staff has been successfully registered",
                    false,
                    const Color.fromARGB(255, 84, 110, 255),
                    "Continue",
                    () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AdminMainScreen(
                              inputScreen: UserDataScreen(),
                              screenIndex: 1,
                            );
                          },
                        ),
                        (route) => false,
                      );
                    },
                  );
                } catch (er) {
                  if (er is CustomException) {
                    NormalDialogCustom().showSelectionDialog(
                      context,
                      "assets/pics/oldpeople.png",
                      "Create fail",
                      er.content,
                      false,
                      Color.fromARGB(255, 185, 0, 0),
                      "Continue",
                      () {
                        Navigator.pop(context);
                      },
                    );
                  }
                }
              },
              background: const Color.fromARGB(255, 84, 110, 255),
            ),
          ],
        ),
      ),
    );
  }
}
