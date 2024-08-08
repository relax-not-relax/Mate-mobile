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
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_date_field.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_selection_field.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.customer});
  final CustomerResponse customer;

  @override
  State<EditProfileScreen> createState() =>
      // ignore: no_logic_in_create_state
      _EditProfileScreenState(customer: customer);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  CustomerResponse customer;

  List<String> genders = ["Male", "Female", "Other"];
  late String genderOption;
  File? _selectedImage;
  late String avatar;
  late CustomerBloc _customerBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _customerBloc = BlocProvider.of<CustomerBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _EditProfileScreenState({required this.customer});

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

  @override
  void initState() {
    super.initState();
    _nameController.text = customer.fullname;
    _emailController.text = customer.email;
    _phoneController.text = customer.phoneNumber ?? "";
    _birthdayController.text =
        DateFormat("dd/MM/yyyy").format(customer.dateOfBirth!);
    _genderController.text = customer.gender ?? "Male";
    for (var gender in genders) {
      if ((gender.toUpperCase().compareTo(customer.gender!.toUpperCase())) ==
          0) {
        genderOption = gender;
      }
    }
    avatar = customer.avatar ?? "assets/pics/no_ava.png";
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
                  return MainScreen(
                    customerResponse: customer,
                    inputScreen: const CustomerAccountMainScreen(),
                    screenIndex: 3,
                  );
                },
              ),
              (route) => false,
            );
          },
        ),
        body: BlocListener<CustomerBloc, CustomerState>(listener:
            (context, state) async {
          if (state is UpdateCustomerLoading) {
            dialogCustom.showWaitingDialog(
              context,
              'assets/pics/oldpeople.png',
              "Wating..",
              "Togetherness - Companion - Sharing",
              false,
              const Color.fromARGB(255, 68, 60, 172),
            );
          }
          if (state is UpdateCustomerSuccess) {
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
          if (state is UpdateCustomerFailure &&
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
        }, child:
            BlocBuilder<CustomerBloc, CustomerState>(builder: (context, state) {
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
                                    (customer.avatar == null ||
                                        customer.avatar!.isEmpty))
                                ? const AssetImage("assets/pics/no_ava.png")
                                : (_selectedImage != null
                                        ? FileImage(_selectedImage!)
                                        : NetworkImage(customer.avatar!))
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
                    errorText: (state is UpdateCustomerFailure &&
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
                    errorText: (state is UpdateCustomerFailure &&
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
                    initBirthday:
                        DateFormat("dd/MM/yyyy").format(customer.dateOfBirth!),
                    errorText: (state is UpdateCustomerFailure &&
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
                      UpdateCustomerRequest reuqest = UpdateCustomerRequest(
                        avatar: avatar,
                        fullname: _nameController.text,
                        dateOfBirth:
                            convertDateFormat(_birthdayController.text),
                        gender: _genderController.text,
                        phoneNumber: _phoneController.text,
                        address: customer.address!,
                        favorite: customer.favorite!,
                        note: customer.note!,
                      );
                      if (!_customerBloc.isClosed) {
                        BlocProvider.of<CustomerBloc>(context).add(
                          SaveUpdatePressed(
                              avatar: _selectedImage,
                              customerId: customer.customerId,
                              customerRequest: reuqest),
                        );
                      } else {
                        print('CustomerBloc is closed');
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
