import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/request/add_customer_to_room_request.dart';
import 'package:mate_project/models/request/buy_pack_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/screens/authentication/login_selection_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/screens/subscription/room_details_screen.dart';
import 'package:mate_project/screens/subscription/widgets/subscription_selection.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/form/disabled_button_custom.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';
import 'package:unicons/unicons.dart';

class RoomSubscriptionScreen extends StatefulWidget {
  const RoomSubscriptionScreen({super.key, required this.customer});
  final CustomerResponse customer;

  @override
  State<RoomSubscriptionScreen> createState() =>
      _RoomSubscriptionScreenState(customer: customer);
}

class _RoomSubscriptionScreenState extends State<RoomSubscriptionScreen> {
  bool isSelecting = false;
  // Note mới nhất:
  // selectedPack sẽ là gói vàng nếu người dùng mới vào trang này lần đầu
  // Nếu người dùng đã mua gói, thì selecredPack sẽ là gói mà người dùng sở hữu
  // Sửa đổi selectedPack trong initState
  // Ở dòng 299, nếu người dùng đã sở hữu gói thì child: DisabledButtonCustom(name: "Go to payment"),
  // Ở dòng 252, thêm điều kiện trong if(nếu người dùng đã sở hữu gói nào đó) (tự thêm bằng code)
  // Ở dòng 348, nếu người dùng đã sở hữu gói nào đó thì "(Gold, Silver, Bronze)+ member" còn không thì để "Regular member"

  late Pack selectedPack;
  final CustomerResponse customer;

  // Thêm biến để lưu trữ tham chiếu đến CustomerBloc
  late CustomerBloc _customerBloc;

  _RoomSubscriptionScreenState({required this.customer});

  @override
  void initState() {
    super.initState();
    selectedPack = Pack(
      packId: 1,
      price: 289,
      packName: "Gold Room",
      description: "",
      duration: 0,
      status: true,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lưu trữ tham chiếu đến CustomerBloc
    _customerBloc = BlocProvider.of<CustomerBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void waitingForSelection() {
    if (mounted)
      setState(() {
        isSelecting = true;
      });
  }

  void payment() async {
    CustomerRepository customerRepository = CustomerRepository();
    int roomId = 0;
    try {
      roomId = await customerRepository.checkPack(packId: selectedPack.packId);
    } catch (error) {
      //them dialog
      NormalDialogCustom().showSelectionDialog(
        context,
        "assets/pics/sorry.png",
        "We have some problems",
        "This membership plan is currently full. Please consider other available options.",
        false,
        const Color.fromARGB(255, 84, 110, 255),
        "Got it",
        () {
          Navigator.of(context).pop();
        },
      );
      print("This pack is full");
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
                "Ac373iA9ny5RJw7niHnRiflTj0bJ-ptmXvA5kfr-qB8tri8hyGK4uXurassTCUMnCIF25u4I1TE1tfVb",
            secretKey:
                "EG8pGZ2TWl9f6lBESteEHqtwbpU6QljpzyaqTtLTGQmBUBJLGCjh3zXtZAaH_UcMqf5UYX0g3lldPYwm",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: [
              {
                "amount": {
                  "total": selectedPack.price,
                  "currency": "USD",
                  "details": {
                    "subtotal": selectedPack.price,
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": selectedPack.packName,
                "item_list": {
                  "items": [
                    {
                      "name": selectedPack.packName,
                      "quantity": 1,
                      "price": selectedPack.price,
                      "currency": "USD"
                    }
                  ],
                },
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              BuyPackRequest buyPackRequest = BuyPackRequest(
                  customerId: customer.customerId,
                  packId: selectedPack.packId,
                  passConfirm:
                      "Khasioudbiob!@noipnzxcdi@#asfouib&^%*(98bnn1293b9876vbHhnH97*HG9bi9g*6rGh90*876tfggh*^bHGHBGG*&687gGB*yg68FGb*&7*6fggv*867FGV76f*7gbGBGH867fgasdiub&basd87bv87bvas8d76f6",
                  startDate: DateTime.now(),
                  amount: 1,
                  paypalTransactionId: customer.customerId.toString() +
                      DateFormat('yyyyMMddHHmmss').format(DateTime.now()),
                  title: "${customer.email} pay for ${selectedPack.packName}",
                  description: "Payment done",
                  status: 'Done',
                  paymentedDate: DateTime.now());

              AddToRoomRequest addToRoomRequest = AddToRoomRequest(
                  roomId: roomId,
                  customerId: customer.customerId,
                  joinDate: DateTime.now());
              _customerBloc.add(BuyPackPressed(
                  buyPackRequest: buyPackRequest,
                  addToRoomRequest: addToRoomRequest));
            },
            onError: (error) {
              if (error['name'] == 'INSTRUMENT_DECLINED') {
                //them dialog
                NormalDialogCustom().showSelectionDialog(
                  context,
                  "assets/pics/sorry.png",
                  "We have some problems",
                  "Your balance is insufficient to purchase this package. Please try again.",
                  false,
                  const Color.fromARGB(255, 84, 110, 255),
                  "Got it",
                  () {
                    Navigator.of(context).pop();
                  },
                );
                print("Khong du so du");
              } else {
                //them dialog
                NormalDialogCustom().showSelectionDialog(
                  context,
                  "assets/pics/sorry.png",
                  "We have some problems",
                  "Payment unsuccessful. Please try again.",
                  false,
                  const Color.fromARGB(255, 84, 110, 255),
                  "Got it",
                  () {
                    Navigator.of(context).pop();
                  },
                );
                print("thanh toan khong thanh cong");
              }
            },
            onCancel: (params) {
              //them dialog
              NormalDialogCustom().showSelectionDialog(
                context,
                "assets/pics/sorry.png",
                "We have some problems",
                "Payment unsuccessful. Please try again.",
                false,
                const Color.fromARGB(255, 84, 110, 255),
                "Got it",
                () {
                  Navigator.of(context).pop();
                },
              );
              print('Thanh toan khong thanh cong');
            }),
      ),
    );
  }

  void finishedSelection() {
    if (mounted)
      setState(() {
        isSelecting = false;
      });
  }

  Future<void> handlePackChange(Pack pack) async {
    waitingForSelection();
    await SharedPreferencesHelper.setPack(pack);
    Pack? _pack = await SharedPreferencesHelper.getPack();

    if (mounted)
      setState(() {
        selectedPack = _pack!;
      });
    print(selectedPack.packName);
    finishedSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              UniconsLine.multiply,
              weight: 3,
            ),
            onPressed: () {
              SharedPreferencesHelper.removeCustomer().then(
                (value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginSelectionScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
              );
            },
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
      body: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) async {
          if (state is BuyPackFailure) {
            print(state.error.content);
          }
          if (state is BuyPackSuccess) {
            print("Buy done");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainScreen(
                    customerResponse: customer,
                    inputScreen: const HomeScreen(),
                    screenIndex: 0,
                  );
                },
              ),
              (route) => false,
            );
          }
          if (state is BuyPackLoading) {
            print("Loading");
          }
        },
        child:
            BlocBuilder<CustomerBloc, CustomerState>(builder: (context, state) {
          return Stack(
            children: [
              Positioned(
                bottom: 32.h,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: NormalButtonCustom(
                    name: "Go to payment",
                    action: payment,
                    background: const Color.fromARGB(255, 84, 110, 255),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 800.h * 0.75,
                  width: 360.w,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25.w,
                              backgroundImage: const AssetImage(
                                "assets/pics/user_test.png",
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.fullname,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 15, 16, 20),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Regular member",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 84, 87, 91),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          "Join Mate’s room membership",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Choose the room type that suits your needs",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 84, 87, 91),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        SubscriptionSelection(
                          pack: selectedPack,
                          onSelectPack: handlePackChange,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              ProjectData.benefits(selectedPack.packId).map(
                            (e) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        UniconsSolid.check_circle,
                                        color: const Color.fromARGB(
                                            255, 76, 102, 232),
                                        size: 20.w,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          e,
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RoomDetailsScreen(
                                      customer: customer, pack: selectedPack);
                                },
                              ),
                              (route) => false,
                            );
                          },
                          child: Text(
                            "View details",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color.fromARGB(255, 76, 102, 232),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
