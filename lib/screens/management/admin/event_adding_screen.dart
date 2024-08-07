import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/models/event.dart';
import 'package:mate_project/repositories/event_repository.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/screens/management/admin/event_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_date_field.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class EventAddingScreen extends StatefulWidget {
  const EventAddingScreen({super.key});

  @override
  State<EventAddingScreen> createState() => _EventAddingScreenState();
}

class _EventAddingScreenState extends State<EventAddingScreen> {
  // ignore: prefer_final_fields
  TextEditingController _titleController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _descriptionController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _startDateController = TextEditingController();
  EventRepository eventRepository = EventRepository();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _titleController.text = "";
    _descriptionController.text = "";
    _startDateController.text = "";
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Adding Event",
        isBordered: false,
        isBack: true,
        titleColor: Colors.white,
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        back: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AdminMainScreen(
                  inputScreen: EventScreen(),
                  screenIndex: 4,
                );
              },
            ),
            (route) => false,
          );
        },
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        margin: EdgeInsets.only(
          bottom: 36.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                AccountEditTextField(
                  controller: _titleController,
                  iconData: IconsaxPlusBold.subtitle,
                  type: TextInputType.text,
                  title: "Event name",
                  borderColor: Colors.white,
                  titleColor: Colors.white,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AccountEditDateField(
                  controller: _startDateController,
                  title: "Start date",
                  initBirthday: DateFormat("dd/MM/yyyy").format(
                    DateTime.now(),
                  ),
                  titleColor: Colors.white,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AccountEditTextField(
                  controller: _descriptionController,
                  iconData: IconsaxPlusBold.note_2,
                  type: TextInputType.text,
                  title: "Description",
                  borderColor: Colors.white,
                  titleColor: Colors.white,
                ),
                SizedBox(
                  height: 16.h,
                ),
                _selectedImage == null
                    ? GestureDetector(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          color: Colors.grey,
                          dashPattern: const [8, 5],
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: Container(
                              height: 140.h,
                              width: 360.w,
                              color: const Color.fromARGB(255, 32, 32, 32),
                              child: Center(
                                child: Text(
                                  "Select event image",
                                  style: GoogleFonts.inter(
                                    color: const Color.fromARGB(
                                        255, 129, 129, 129),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 140.h,
                        width: 360.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ],
            ),
            NormalButtonCustom(
              name: "Add",
              action: () async {
                if (_selectedImage == null) {
                  const NormalDialogCustom().showSelectionDialog(
                    context,
                    "assets/pics/error.png",
                    "Image is required",
                    "Please choose an image",
                    false,
                    Color.fromARGB(255, 195, 0, 0),
                    "Continue",
                    () {
                      Navigator.pop(context);
                    },
                  );
                } else {
                  //them dialog new
                  const NormalDialogCustom().showWaitingDialog(
                    context,
                    "assets/pics/oldpeople.png",
                    "Wait a minute",
                    "Event is preparing",
                    false,
                    const Color.fromARGB(255, 68, 60, 172),
                  );
                  try {
                    if (_startDateController.text.isEmpty) {
                      Navigator.pop(context);
                      const NormalDialogCustom().showSelectionDialog(
                        context,
                        "assets/pics/error.png",
                        "Start date is required",
                        "Please choose start date",
                        false,
                        Color.fromARGB(255, 195, 0, 0),
                        "Continue",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      DateTime startDate = DateFormat("dd/MM/yyyy")
                          .parse(_startDateController.text);
                      await eventRepository.CreateEvent(
                          title: _titleController.text,
                          startDate: startDate,
                          description: _descriptionController.text,
                          image: _selectedImage!);
                      Navigator.pop(context);
                      const NormalDialogCustom().showSelectionDialog(
                        context,
                        "assets/pics/oldpeople.png",
                        "Create Success",
                        "New event has been created",
                        false,
                        Color.fromARGB(255, 31, 158, 255),
                        "Continue",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
                  } catch (er) {
                    if (er is CustomException) {
                      Navigator.pop(context);
                      const NormalDialogCustom().showSelectionDialog(
                        context,
                        "assets/pics/error.png",
                        "Have a trouble",
                        er.content,
                        false,
                        const Color.fromARGB(255, 195, 0, 0),
                        "Continue",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
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
