import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/screens/profile_management/customer/account_main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_selection_field.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_text_field.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/edit_favorite.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/edit_note.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class CustomerFavoriteScreen extends StatefulWidget {
  const CustomerFavoriteScreen({super.key});

  @override
  State<CustomerFavoriteScreen> createState() => _CustomerFavoriteScreenState();
}

class _CustomerFavoriteScreenState extends State<CustomerFavoriteScreen> {
  // ignore: prefer_final_fields
  TextEditingController _favoriteController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  //Test data (Thay đổi khi call API để lấy dữ liệu)
  late Customer? customer;

  List<String> favorites = [];
  late double fieldHeight;

  @override
  void initState() {
    super.initState();
    customer = Customer(
      customerId: 1,
      email: "loremispum@gmail.com",
      fullName: "Lorem Ispum",
      favorite:
          "Play chess, Trekking, Seeing relatives, Watching movies, Making artworks",
      note:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
    );
    _favoriteController.text = customer!.favorite ?? "";
    favorites = customer!.favorite!
        .split(",")
        .map(
          (e) => e.trim(),
        )
        .toList();
    _noteController.text = customer!.note ?? "";
    fieldHeight = 80.h;
  }

  void handleHobbiesChange(List<String> newHobbies, bool checked, String hobby,
      TextEditingController textController) {
    setState(() {
      if (checked) {
        newHobbies.add(hobby);
        textController.text = newHobbies.join(", ");
        fieldHeight += 16.h;
      } else {
        newHobbies.remove(hobby);
        textController.text = newHobbies.join(", ");
        fieldHeight -= 16.h;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TNormalAppBar(
        title: "My Favorites",
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
              EditFavorite(
                selected: favorites,
                onHobbyChanged: handleHobbiesChange,
                controller: _favoriteController,
                height: fieldHeight,
              ),
              SizedBox(
                height: 24.h,
              ),
              EditNote(
                controller: _noteController,
              ),
              SizedBox(
                height: 32.h,
              ),
              favorites.length <= 5
                  ? NormalButtonCustom(
                      name: "Save",
                      action: () {},
                      background: const Color.fromARGB(255, 84, 110, 255),
                    )
                  : const DisabledButtonCustom(
                      name: "Save",
                    ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
