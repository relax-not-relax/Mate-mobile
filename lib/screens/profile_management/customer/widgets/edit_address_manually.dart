import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_text_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class EditAddressManually extends StatefulWidget {
  const EditAddressManually({super.key});

  @override
  State<EditAddressManually> createState() => _EditAddressManuallyState();
}

class _EditAddressManuallyState extends State<EditAddressManually> {
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _houseController.text = "";
    _districtController.text = "";
    _cityController.text = "";
    _stateController.text = "";
    _countryController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Manually add",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 15, 16, 20),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          AccountEditTextField(
            controller: _houseController,
            iconData: IconlyBold.location,
            type: TextInputType.text,
            title: "Apartment no",
            borderColor: const Color.fromARGB(255, 148, 141, 246),
          ),
          SizedBox(
            height: 16.h,
          ),
          AccountEditTextField(
            controller: _districtController,
            iconData: IconlyBold.location,
            type: TextInputType.text,
            title: "District",
            borderColor: const Color.fromARGB(255, 148, 141, 246),
          ),
          SizedBox(
            height: 16.h,
          ),
          AccountEditTextField(
            controller: _cityController,
            iconData: IconlyBold.location,
            type: TextInputType.text,
            title: "City",
            borderColor: const Color.fromARGB(255, 148, 141, 246),
          ),
          SizedBox(
            height: 16.h,
          ),
          AccountEditTextField(
            controller: _stateController,
            iconData: IconlyBold.location,
            type: TextInputType.text,
            title: "State",
            borderColor: const Color.fromARGB(255, 148, 141, 246),
          ),
          SizedBox(
            height: 16.h,
          ),
          AccountEditTextField(
            controller: _countryController,
            iconData: IconlyBold.location,
            type: TextInputType.text,
            title: "Country",
            borderColor: const Color.fromARGB(255, 148, 141, 246),
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
    );
  }
}
