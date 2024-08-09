// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/blocs/staff_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/events/staff_event.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/request/update_staff_request.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/screens/profile_management/staff/staff_account_main_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_date_field.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_selection_field.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/states/staff_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class EditStaffProfileScreen extends StatefulWidget {
  const EditStaffProfileScreen({super.key, required this.staff});
  final Staff staff;

  @override
  State<EditStaffProfileScreen> createState() =>
      // ignore: no_logic_in_create_state
      _EditStaffProfileScreenState(staff: staff);
}

class _EditStaffProfileScreenState extends State<EditStaffProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  Staff staff;

  List<String> genders = ["Male", "Female", "Other"];
  late String genderOption;
  File? _selectedImage;
  late String avatar;
  late StaffBloc _staffBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _staffBloc = BlocProvider.of<StaffBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _EditStaffProfileScreenState({required this.staff});

  String convertDateFormat(String dateString) {
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");

    try {
      DateTime dateTime = inputFormat.parse(dateString);
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    } catch (e) {
      print("Error: $e");
      return "";
    }
  }

  String convertDateTimeString(String dateTimeString) {
    // Parse the input string to DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime to the desired format
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    print(staff.toJson().toString());
    _nameController.text = staff.fullName;
    _emailController.text = staff.email;
    _phoneController.text = staff.phoneNumber ?? "xxxxxxxxxx";
    _birthdayController.text = staff.dateOfBirth != null
        ? convertDateTimeString(staff.dateOfBirth!)
        : "01/01/2000";
    _genderController.text = staff.gender ?? "Other";
    for (var gender in genders) {
      if (staff.gender != null &&
          (gender.toUpperCase().compareTo(staff.gender!.toUpperCase())) == 0) {
        genderOption = gender;
      } else {
        genderOption = "Other";
      }
    }
    avatar = staff.avatar ?? "assets/pics/no_ava.png";
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      if (mounted)
        setState(() {
          _selectedImage = File(returnedImage.path);
        });
    } else {
      return;
    }
  }

  NormalDialogCustom dialogCustom = const NormalDialogCustom();

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
                                      if (mounted)
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const StaffMainScreen(
                    inputScreen: StaffAccountMainScreen(),
                    screenIndex: 3,
                  );
                },
              ),
              (route) => false,
            );
          },
        ),
        body: BlocListener<StaffBloc, StaffState>(
            listener: (context, state) async {
          if (state is UpdateStaffLoading) {
            dialogCustom.showWaitingDialog(
              context,
              'assets/pics/oldpeople.png',
              "Wating..",
              "Togetherness - Companion - Sharing",
              false,
              const Color.fromARGB(255, 68, 60, 172),
            );
          }
          if (state is UpdateStaffSuccess) {
            Navigator.of(context).pop();
            dialogCustom.showWaitingDialog(
              context,
              'assets/pics/oldpeople.png',
              "Update success",
              "Togetherness - Companion - Sharing",
              false,
              const Color.fromARGB(255, 68, 60, 172),
            );
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();
          }
          if (state is UpdateCustomerFailure) {
            Navigator.of(context).pop();
          }
          if (state is UpdateStaffFailure &&
              state.error.type == Failure.System) {
            dialogCustom.showSelectionDialog(
              context,
              'assets/pics/error.png',
              'System failure',
              'Please check again',
              true,
              const Color.fromARGB(255, 230, 57, 71),
              'Continue',
              () {
                Navigator.of(context).pop();
              },
            );
          }
        }, child: BlocBuilder<StaffBloc, StaffState>(builder: (context, state) {
          return Container(
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
                            image: (_selectedImage == null &&
                                    (staff.avatar == null ||
                                        staff.avatar!.isEmpty))
                                ? const AssetImage("assets/pics/no_ava.png")
                                : (_selectedImage != null
                                        ? FileImage(_selectedImage!)
                                        : NetworkImage(staff.avatar!))
                                    as ImageProvider,
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
                    errorText: (state is UpdateStaffFailure &&
                            state.error.type == Failure.Fullname)
                        ? state.error.content
                        : null,
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
                    errorText: (state is UpdateStaffFailure &&
                            state.error.type == Failure.PhoneNumber)
                        ? state.error.content
                        : null,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AccountEditDateField(
                    controller: _birthdayController,
                    title: "Birthday",
                    initBirthday: staff.dateOfBirth != null
                        ? convertDateTimeString(staff.dateOfBirth!)
                        : "01/01/2000",
                    errorText: (state is UpdateStaffFailure &&
                            state.error.type == Failure.Birthday)
                        ? state.error.content
                        : null,
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
                    action: () async {
                      UpdateStaffRequest reuqest = UpdateStaffRequest(
                        avatar: avatar,
                        fullname: _nameController.text,
                        dateOfBirth:
                            convertDateFormat(_birthdayController.text),
                        gender: _genderController.text,
                        phoneNumber: _phoneController.text,
                        address: staff.address ?? "",
                      );
                      if (!_staffBloc.isClosed) {
                        BlocProvider.of<StaffBloc>(context).add(
                            SaveUpdateStaffPressed(
                                staff.staffId, _selectedImage,
                                updateStaffRequest: reuqest));
                      } else {
                        print('STaff_BloC is closed');
                      }
                    },
                    background: const Color.fromARGB(255, 84, 110, 255),
                  ),
                ],
              ),
            ),
          );
        })));
  }
}
