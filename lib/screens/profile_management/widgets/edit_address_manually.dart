import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class EditAddressManually extends StatefulWidget {
  const EditAddressManually({super.key, required this.customerResponse});
  final CustomerResponse? customerResponse;
  @override
  State<EditAddressManually> createState() =>
      _EditAddressManuallyState(customer: customerResponse);
}

class _EditAddressManuallyState extends State<EditAddressManually> {
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  NormalDialogCustom dialogCustom = const NormalDialogCustom();
  CustomerResponse? customer;
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

  _EditAddressManuallyState({required this.customer});
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
    return BlocListener<CustomerBloc, CustomerState>(
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
      child:
          BlocBuilder<CustomerBloc, CustomerState>(builder: (context, state) {
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
                action: () {
                  String address = "";
                  String house = "${_houseController.text}, ";
                  String district = "${_districtController.text}, ";
                  String city = "${_cityController.text}, ";
                  String state = "${_stateController.text}, ";
                  String country = _countryController.text;
                  address += house + district + city + state + country;
                  DateFormat outputFormat = DateFormat("yyyy-MM-dd");
                  UpdateCustomerRequest reuqest = UpdateCustomerRequest(
                    avatar: customer!.avatar ?? "",
                    fullname: customer!.fullname,
                    dateOfBirth: outputFormat.format(customer!.dateOfBirth!),
                    gender: customer!.gender ?? "",
                    phoneNumber: customer!.phoneNumber ?? "",
                    address: address,
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
      }),
    );
  }
}
