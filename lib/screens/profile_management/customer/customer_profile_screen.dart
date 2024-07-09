// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/screens/profile_management/customer/account_main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_date_field.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_selection_field.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_text_field.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  // ignore: prefer_final_fields
  TextEditingController _nameController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _emailController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  //Test data (Thay đổi khi call API để lấy dữ liệu)
  late Customer? customer;
  List<String> genders = [
    "Male",
    "Female",
    "Other",
  ];
  late String genderOption;
  File? _selectedImage;
  late String avatar;

  @override
  void initState() {
    super.initState();
    customer = Customer(
      customerId: 1,
      email: "loremispum@gmail.com",
      fullName: "Lorem Ispum",
      avatar: "assets/pics/user_test.png",
      dateOfBirth: "1975-01-01 17:00:20",
      gender: "Male",
    );
    _nameController.text = customer!.fullName;
    _emailController.text = customer!.email;
    _phoneController.text = customer!.phoneNumber ?? "";
    _birthdayController.text = DateFormat("dd/MM/yyyy").format(
      DateTime.parse(
        customer!.dateOfBirth!,
      ),
    );
    _genderController.text = customer!.gender ?? "Male";
    for (var gender in genders) {
      if ((gender.toUpperCase().compareTo(customer!.gender!.toUpperCase())) ==
          0) {
        genderOption = gender;
      }
    }
    avatar = customer!.avatar ?? "assets/pics/no_ava.png";
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    } else {
      return;
    }

    // print(response);
  }

  @override
  Widget build(BuildContext context) {
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Select your gender",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: genders.map(
                            (e) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio<String>(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor:
                                        const Color.fromARGB(255, 67, 90, 204),
                                    value: e,
                                    groupValue: genderOption,
                                    onChanged: (String? value) {
                                      setState(() {
                                        genderOption = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    e,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      NormalButtonCustom(
                        name: "Confirm",
                        action: () {
                          _genderController.text = genderOption;
                          Navigator.pop(context);
                        },
                        background: const Color.fromARGB(255, 84, 110, 255),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TNormalAppBar(
        title: "My Profile",
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AccountMainScreen();
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
              Text(
                "Customize your personal information",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 84, 87, 91),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 24.h,
              ),
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: -20.h,
                children: [
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : AssetImage(customer!.avatar!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: Icon(
                      IconlyBold.camera,
                      size: 24.sp,
                      color: const Color.fromARGB(255, 84, 110, 255),
                    ),
                    padding: EdgeInsets.all(12.w),
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 229, 233, 255),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              AccountEditTextField(
                controller: _nameController,
                iconData: IconsaxPlusBold.profile,
                type: TextInputType.name,
                borderColor: const Color.fromARGB(255, 148, 141, 246),
                title: "Full name",
              ),
              SizedBox(
                height: 16.h,
              ),
              AccountEditTextField(
                controller: _emailController,
                iconData: IconlyBold.message,
                type: TextInputType.emailAddress,
                borderColor: const Color.fromARGB(255, 148, 141, 246),
                title: "Email",
              ),
              SizedBox(
                height: 16.h,
              ),
              AccountEditTextField(
                controller: _phoneController,
                iconData: IconsaxPlusBold.call,
                type: TextInputType.phone,
                borderColor: const Color.fromARGB(255, 148, 141, 246),
                title: "Phone number",
              ),
              SizedBox(
                height: 16.h,
              ),
              AccountEditDateField(
                controller: _birthdayController,
                title: "Birthday",
                initBirthday: customer!.dateOfBirth!,
              ),
              SizedBox(
                height: 16.h,
              ),
              AccountEditSelectionField(
                controller: _genderController,
                onPressed: () {
                  displayBottomSheet(context);
                },
                title: "Gender",
                iconData: IconsaxPlusBold.profile_2user,
              ),
              SizedBox(
                height: 64.h,
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
