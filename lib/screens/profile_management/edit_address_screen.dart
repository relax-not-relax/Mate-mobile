import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mate_project/api/location_api.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/location.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/profile_management/account_address_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/screens/profile_management/widgets/edit_address_manually.dart';
import 'package:mate_project/screens/profile_management/widgets/location_list_element.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({
    super.key,
    required this.controller,
    required this.savedAddress,
  });

  final TextEditingController controller;
  final String savedAddress;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  bool isSearched = false;
  List<Location> locations = [];
  bool isSwitch = false;
  Widget content = Container();
  bool isLoading = false;
  late bool isFirstSearch;
  CustomerResponse? customer;
  NormalDialogCustom dialogCustom = const NormalDialogCustom();

  Future<void> placeAutoComplete(String query) async {
    setState(() {
      isLoading = true;
    });
    locations = await LocationApi.getLocation(query);
    setState(() {
      locations;
    });
    print(locations);
    setState(() {
      isLoading = false;
    });
  }

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

  Future getCustomer() async {
    customer = await SharedPreferencesHelper.getCustomer();
  }

  String convertString(String inputString) {
    return inputString.replaceAll(RegExp(r"\s+"), "+").replaceAll(
          ",",
          "%2C",
        );
  }

  @override
  void initState() {
    super.initState();
    getCustomer();
    locations = [];
    isFirstSearch = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isSwitch == false) {
      content = SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Search location",
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
              controller: widget.controller,
              iconData: IconlyBold.location,
              type: TextInputType.streetAddress,
              title: "Address",
              borderColor: const Color.fromARGB(255, 148, 141, 246),
              onSubmitted: (value) async {
                if (isFirstSearch) {
                  setState(() {
                    isFirstSearch = false;
                  });
                }

                await placeAutoComplete(
                  convertString(value),
                );
              },
            ),
            isFirstSearch == false && isLoading == true
                ? Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Suggested address based on your search",
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 15, 16, 20),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      LoadingAnimationWidget.prograssiveDots(
                        color: const Color.fromARGB(255, 84, 110, 255),
                        size: 30.sp,
                      ),
                    ],
                  )
                : locations.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Suggested address based on your search",
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 15, 16, 20),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          isLoading
                              ? LoadingAnimationWidget.prograssiveDots(
                                  color:
                                      const Color.fromARGB(255, 84, 110, 255),
                                  size: 30.sp,
                                )
                              : LocationListElement(
                                  onPressed: (value) {
                                    widget.controller.text = value;
                                  },
                                  location: locations[0].display_name,
                                ),
                        ],
                      )
                    : Container(),
            SizedBox(
              height: 32.h,
            ),
            NormalButtonCustom(
              name: "Save",
              action: () {
                DateFormat outputFormat = DateFormat("yyyy-MM-dd");
                UpdateCustomerRequest reuqest = UpdateCustomerRequest(
                  avatar: customer!.avatar ?? "",
                  fullname: customer!.fullname,
                  dateOfBirth: outputFormat.format(customer!.dateOfBirth!),
                  gender: customer!.gender ?? "",
                  phoneNumber: customer!.phoneNumber ?? "",
                  address: widget.controller.text,
                  favorite: customer!.favorite ?? "",
                  note: customer!.note ?? "",
                );
                if (!_customerBloc.isClosed) {
                  BlocProvider.of<CustomerBloc>(context).add(
                    SaveUpdatePressed(
                        avatar: null,
                        customerId: customer!.customerId,
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
      );
    } else {
      content = EditAddressManually(
        customerResponse: customer,
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: TNormalAppBar(
          title: "Edit address",
          isBordered: false,
          isBack: true,
          back: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AccountAddressScreen();
                },
              ),
            );
          },
        ),
        body: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) async {
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
          },
          child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
            return Container(
              width: 360.w,
              height: 710.h,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: Column(
                children: [
                  content,
                  SizedBox(
                    height: 16.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.w,
                      children: [
                        Switch(
                          value: isSwitch,
                          onChanged: (value) {
                            setState(() {
                              isSwitch = value;
                              content = EditAddressManually(
                                customerResponse: customer,
                              );
                            });
                          },
                          activeColor: const Color.fromARGB(255, 67, 90, 204),
                        ),
                        isSwitch == false
                            ? Text(
                                "Manually add?",
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 67, 90, 204),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                "Search location?",
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 67, 90, 204),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
