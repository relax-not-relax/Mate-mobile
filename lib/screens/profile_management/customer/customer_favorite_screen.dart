import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_selection_field.dart';
import 'package:mate_project/screens/profile_management/widgets/account_edit_text_field.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/edit_favorite.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/edit_note.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class CustomerFavoriteScreen extends StatefulWidget {
  const CustomerFavoriteScreen({super.key});

  @override
  State<CustomerFavoriteScreen> createState() => _CustomerFavoriteScreenState();
}

class _CustomerFavoriteScreenState extends State<CustomerFavoriteScreen> {
  // ignore: prefer_final_fields
  TextEditingController _favoriteController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  NormalDialogCustom dialogCustom = const NormalDialogCustom();

  //Test data (Thay đổi khi call API để lấy dữ liệu)
  CustomerResponse? customer;

  List<String> favorites = [];
  late double fieldHeight;

  Future getCustomer() async {
    customer = await SharedPreferencesHelper.getCustomer();
  }

  @override
  void initState() {
    super.initState();
    fieldHeight = 80.h;
    getCustomer().then(
      (value) {
        print(customer!.favorite);
        _favoriteController.text = customer!.favorite ?? "";
        favorites = customer!.favorite!
            .split(",")
            .map(
              (e) => e.trim(),
            )
            .toList();
        _noteController.text = customer!.note ?? "";
      },
    );
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

  void handleHobbiesChange(List<String> newHobbies, bool checked, String hobby,
      TextEditingController textController) {
    if (mounted)
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
                  return MainScreen(
                      inputScreen: CustomerAccountMainScreen(),
                      screenIndex: 3,
                      customerResponse: customer!);
                },
              ),
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
                          action: () {
                            DateFormat outputFormat = DateFormat("yyyy-MM-dd");

                            UpdateCustomerRequest reuqest =
                                UpdateCustomerRequest(
                              avatar: customer!.avatar ?? "",
                              fullname: customer!.fullname,
                              dateOfBirth:
                                  outputFormat.format(customer!.dateOfBirth!),
                              gender: customer!.gender ?? "",
                              phoneNumber: customer!.phoneNumber ?? "",
                              address: customer!.address ?? "",
                              favorite: _favoriteController.text,
                              note: _noteController.text,
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
          );
        })));
  }
}
