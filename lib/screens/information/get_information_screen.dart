import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/information/widgets/birthday_selection.dart';
import 'package:mate_project/screens/information/widgets/gender_selection.dart';
import 'package:mate_project/screens/information/widgets/hobbies_selection.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class GetInformationScreen extends StatefulWidget {
  const GetInformationScreen({super.key});

  @override
  State<GetInformationScreen> createState() => _GetInformationScreenState();
}

class _GetInformationScreenState extends State<GetInformationScreen> {
  late int pageIndex;
  List<String> titles = [
    'What is your gender?',
    'What is your date of birth?',
    'What are your hobbies?'
  ];
  List<String> descriptions = [
    'Based on your gender, we have more information to have the most appropriate and standard ways to serve you.',
    'Based on your age, we can prepare a suitable living environment for you, along with annual activities specific to each age.',
    'Helps you easily connect with people with similar interests, facilitating interaction and community engagement. We plan and organize programs and events that suit your interests.',
  ];
  bool isSelecting = false;
  late Future _initGender;
  late Future _initBirthday;
  late Future _initHobbies;
  String? gender;
  String? birthday;
  String? errorMessage;
  List<String> hobbiesSelected = [];
  CustomerRepository customerRepository = CustomerRepository();
  NormalDialogCustom dialogCustom = NormalDialogCustom();

  Future<String> getCurrentGender() async {
    return await SharedPreferencesHelper.getGender();
  }

  Future<String> getCurrentBirthday() async {
    return await SharedPreferencesHelper.getAge();
  }

  Future<List<String>> getCurrentHobbies() async {
    return await SharedPreferencesHelper.getHobbies();
  }

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
    _initGender = getCurrentGender();
    _initGender.then((value) {
      gender = value;
    });
    _initBirthday = getCurrentBirthday();
    _initBirthday.then((value) {
      if (value != "") {
        birthday = value;
      } else {
        birthday = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now());
      }
    });
    _initHobbies = getCurrentHobbies();
    _initHobbies.then(
      (value) {
        hobbiesSelected = value;
      },
    );
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

  void onNext() {
    setState(() {
      pageIndex += 1;
    });
  }

  void onPrevious() {
    setState(() {
      pageIndex -= 1;
    });
  }

  void handleDateChange(String newDate) {
    setState(() {
      birthday = newDate;
    });
  }

  Future<void> handleGenderChange(String newGender) async {
    waitingForSelection();
    await SharedPreferencesHelper.setGender(newGender);
    String _gender = await SharedPreferencesHelper.getGender();
    setState(() {
      gender = _gender;
    });
    finishedSelection();
  }

  Future<void> handleAgeChange(String newAge) async {
    DateTime dob = DateTime.parse(newAge);
    Duration difference = DateTime.now().difference(dob);
    int years = difference.inDays ~/ 365;
    if (years >= 18) {
      await SharedPreferencesHelper.setAge(newAge);
      String _age = await SharedPreferencesHelper.getAge();
      setState(() {
        errorMessage = "";
        birthday = _age;
        pageIndex += 1;
      });
    } else {
      setState(() {
        errorMessage =
            "You must be at least 18 years old to be able to use our services.";
      });
    }
  }

  Future<void> handleHobbiesChange(
      List<String> newHobbies, bool checked, String hobby) async {
    setState(() {
      if (checked) {
        newHobbies.add(hobby);
      } else {
        newHobbies.remove(hobby);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container();
    Widget button = Container();

    switch (pageIndex) {
      case 0:
        content = GenderSelection(
          onSelecting: waitingForSelection,
          done: finishedSelection,
          gender: gender ?? "",
          onSelectGender: handleGenderChange,
        );
        if (isSelecting == false && gender != null && gender != "") {
          button = NormalButtonCustom(
            name: "SAVE",
            action: () {
              onNext();
            },
            background: const Color.fromARGB(255, 46, 62, 140),
          );
        } else {
          button = const DisabledButtonCustom(name: "SAVE");
        }
        break;
      case 1:
        content = BirthdaySelection(
          date: birthday ?? "",
          onDateChanged: handleDateChange,
          error: errorMessage ?? "",
        );
        button = NormalButtonCustom(
          name: "SAVE",
          action: () async {
            await handleAgeChange(birthday!);
          },
          background: const Color.fromARGB(255, 46, 62, 140),
        );
        break;
      case 2:
        content = HobbiesSelection(
          selected: hobbiesSelected,
          onHobbyChanged: handleHobbiesChange,
        );
        button = NormalButtonCustom(
          name: "SAVE",
          action: () async {
            CustomerResponse? customer =
                await SharedPreferencesHelper.getCustomer();
            if (customer != null) {
              String favorite = "";
              if (hobbiesSelected.isNotEmpty) {
                for (String element in hobbiesSelected) {
                  favorite += element + " ";
                }
              }

              UpdateCustomerRequest data = UpdateCustomerRequest(
                  avatar: "",
                  fullname: customer.fullname,
                  dateOfBirth: birthday!,
                  gender: gender!,
                  phoneNumber: (customer.phoneNumber != null)
                      ? customer.phoneNumber!
                      : "xxxx-xxxx-xxxx",
                  address: customer.address != null ? customer.address! : "",
                  favorite: favorite.trim(),
                  note: "");
              try {
                await customerRepository.UpdateInformation(
                    data: data, customerId: customer.customerId);
                Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainScreen(
                            inputScreen: HomeScreen(),
                            screenIndex: 0,
                          )),
                  (Route<dynamic> route) => false,
                );
              } catch (error) {
                dialogCustom.showSelectionDialog(
                  context,
                  'assets/pics/error.png',
                  'Update failed!',
                  'System fail!',
                  true,
                  const Color.fromARGB(255, 230, 57, 71),
                  'Continue',
                  () {
                    Navigator.of(context).pop();
                  },
                );
              }
            }
          },
          background: const Color.fromARGB(255, 46, 62, 140),
        );
        break;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: pageIndex >= 1
            ? IconButton(
                onPressed: () {
                  onPrevious();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )
            : Container(),
        actions: [
          Wrap(
            children: [
              Text(
                '${pageIndex + 1}/',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 60, 78, 181),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '3',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 163, 165, 168),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 24.w,
              ),
            ],
          )
        ],
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titles[pageIndex],
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 60, 78, 181),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    descriptions[pageIndex],
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 84, 87, 91),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 28.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: pageIndex == 0
                                ? const Color.fromARGB(255, 67, 90, 204)
                                : const Color.fromARGB(255, 183, 183, 183),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          width: 28.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: pageIndex == 1
                                ? const Color.fromARGB(255, 67, 90, 204)
                                : const Color.fromARGB(255, 183, 183, 183),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          width: 28.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: pageIndex == 2
                                ? const Color.fromARGB(255, 67, 90, 204)
                                : const Color.fromARGB(255, 183, 183, 183),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  content,
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  button,
                  SizedBox(
                    height: 32.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
