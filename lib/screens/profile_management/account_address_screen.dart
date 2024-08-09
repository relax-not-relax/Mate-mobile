import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/screens/profile_management/edit_address_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_selection_field.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class AccountAddressScreen extends StatefulWidget {
  const AccountAddressScreen({super.key});

  @override
  State<AccountAddressScreen> createState() => _AccountAddressScreenState();
}

class _AccountAddressScreenState extends State<AccountAddressScreen> {
  // ignore: prefer_final_fields
  TextEditingController _addressController = TextEditingController();
  CustomerResponse? customer;

  Future getAddress() async {
    customer = await SharedPreferencesHelper.getCustomer();

    if (mounted)
      setState(() {
        customer;
      });
  }

  @override
  void initState() {
    super.initState();
    getAddress().then(
      (value) {
        _addressController.text =
            customer == null ? "Loading..." : customer!.address ?? "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white,
        appBar: TNormalAppBar(
          title: "My Address",
          isBordered: false,
          isBack: true,
          back: () async {
            await Future.delayed(Duration(seconds: 1));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainScreen(
                      inputScreen: CustomerAccountMainScreen(),
                      screenIndex: 3,
                      customerResponse: customer!);
                },
              ),
              (route) => false,
            );
          },
        ),
        body: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) async {},
          child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
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
                          SizedBox(
                            height: 8.h,
                          ),
                          AccountEditSelectionField(
                            controller: _addressController,
                            onPressed: () {},
                            title: "Saved address",
                            iconData: IconlyBold.location,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EditAddressScreen(
                                        controller: _addressController,
                                        savedAddress: customer!.address ?? "",
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8.w,
                                children: [
                                  Icon(
                                    IconsaxPlusLinear.edit,
                                    size: 20.sp,
                                    color:
                                        const Color.fromARGB(255, 67, 90, 204),
                                  ),
                                  Text(
                                    "Edit my address",
                                    style: GoogleFonts.inter(
                                      color: const Color.fromARGB(
                                          255, 67, 90, 204),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32.h,
                  left: 0,
                  right: 0,
                  child: Container(),
                ),
              ],
            );
          }),
        ));
  }
}
