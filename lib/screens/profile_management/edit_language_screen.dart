import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/language.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:country_flags/country_flags.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:unicons/unicons.dart';

class EditLanguageScreen extends StatefulWidget {
  const EditLanguageScreen({super.key});

  @override
  State<EditLanguageScreen> createState() => _EditLanguageScreenState();
}

class _EditLanguageScreenState extends State<EditLanguageScreen> {
  late Language defaultLanguage;

  bool isSelecting = false;

  @override
  void initState() {
    super.initState();
    // Lấy language mà người dùng đã cài đặt trước đó (không có thì default là rojectData.languages[0])
    defaultLanguage = ProjectData.languages[0];
  }

  void waitingForSelection() {
    setState(() {
      isSelecting = true;
    });
  }

  void finishedSelection() {
    setState(() {
      isSelecting = false;
    });
  }

  void onSelectLanguage(Language language) {
    waitingForSelection();
    setState(() {
      defaultLanguage = language;
    });
    finishedSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TNormalAppBar(
        title: "Change Password",
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const CustomerAccountMainScreen();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.w,
                  children: [
                    Icon(
                      IconsaxPlusLinear.global,
                      color: const Color.fromARGB(255, 84, 87, 91),
                      size: 22.sp,
                    ),
                    Text(
                      "Select a language",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 32, 35, 43),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
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
                  children: ProjectData.languages.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          onSelectLanguage(e);
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 16.w,
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      e.countryCode,
                                      width: 34.w,
                                      height: 23.h,
                                    ),
                                    Text(
                                      e.language,
                                      style: GoogleFonts.inter(
                                        color: const Color.fromARGB(
                                            255, 32, 35, 43),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                defaultLanguage == e
                                    ? Icon(
                                        UniconsSolid.check_circle,
                                        size: 20.sp,
                                        color: const Color.fromARGB(
                                            255, 67, 90, 204),
                                      )
                                    : Container(),
                              ],
                            ),
                            if (ProjectData.languages.indexOf(e) <
                                ProjectData.languages.length - 1)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Container(
                                    height: 0.5.h,
                                    color: const Color.fromARGB(
                                        255, 189, 190, 191),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                ],
                              )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              NormalButtonCustom(
                name: "Save",
                action: () {},
                background: const Color.fromARGB(255, 84, 110, 255),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
