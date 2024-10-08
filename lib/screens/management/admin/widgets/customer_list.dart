import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/languages_helper.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/screens/management/admin/widgets/customer_element.dart';
import 'package:mate_project/screens/management/admin/widgets/search_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key, required this.customers});
  final List<CustomerResponse> customers;

  @override
  State<CustomerList> createState() => _CustomerListState(customers: customers);
}

class _CustomerListState extends State<CustomerList> {
  TextEditingController _controller = TextEditingController();
  // Test data, gọi API để lấy danh sách khách hàng của hệ thống
  List<CustomerResponse> customers;
  List<CustomerResponse> customerShows = [];
  List<String> filters = [
    "A - Z",
    "Z - A",
    "Gold membership",
    "Silver membership",
    "Bronze membership",
    "Inactive",
  ];
  List<int> filterInt = [];
  String search = '';
  List<bool> selectedOptions = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  _CustomerListState({required this.customers});

  @override
  void initState() {
    super.initState();
    _controller.text = "";
    setState(() {
      customerShows = customers;
    });
  }

  void setList(List<int> filter, String search) {
    filterInt = filter;
    if (mounted) {
      if (search.isNotEmpty) {
        setState(() {
          customerShows = customers
              .where((e) =>
                  e.fullname.toLowerCase().contains(search.toLowerCase()))
              .toList();
        });
      } else {
        setState(() {
          customerShows = customers;
        });
      }
    }
    if (filter.contains(0) && mounted) {
      setState(
        () {
          customerShows.sort((a, b) => a.fullname.compareTo(b.fullname));
        },
      );
    }
    if (filter.contains(1)) {
      setState(() {
        customerShows.sort((a, b) => b.fullname.compareTo(a.fullname));
      });
    }
    if (filter.contains(2) || filter.contains(3) || filter.contains(4)) {
      setState(() {
        customerShows = customerShows
            .where((e) =>
                e.packs.isNotEmpty &&
                ((filter.contains(2) && e.packs.first.packId == 1) ||
                    (filter.contains(3) && e.packs.first.packId == 2) ||
                    (filter.contains(4) && e.packs.first.packId == 3)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future displayUserAction(BuildContext context, CustomerResponse customer) {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: 360.w,
            height: 220.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 41, 46),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.w,
                  backgroundImage: AssetImage(customer.avatar!),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Flexible(
                  child: Text(
                    customer.fullname,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Divider(
                  height: 1.h,
                  color: const Color.fromARGB(255, 65, 67, 73),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextButton(
                  onPressed: () async {
                    //them dialog new
                    NormalDialogCustom().showWaitingDialog(
                      context,
                      "assets/pics/app_logo_2.png",
                      "Wait a minute",
                      "Deactive user!",
                      false,
                      const Color.fromARGB(255, 68, 60, 172),
                    );
                    CustomerRepository customerRepository =
                        CustomerRepository();
                    await customerRepository
                        .deactiveCustomer(customer.customerId);
                    Navigator.of(context).pop();
                    if (mounted) {
                      setState(() {
                        customerShows.remove(customer);
                        customers.remove(customer);
                      });
                    }
                    //them dialog new
                    NormalDialogCustom().showSelectionDialog(
                      context,
                      "assets/pics/app_logo_2.png",
                      "Successfully!",
                      "Successfully deactivated user!",
                      false,
                      const Color.fromARGB(255, 68, 60, 172),
                      "Continue",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Text(
                    "Deactivate user",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 234, 68, 53),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Future displayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 360.w,
                height: 800.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 37, 41, 46),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "Sort by",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Column(
                          children: filters.map(
                            (e) {
                              return CheckboxListTile(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                splashRadius: 10.w,
                                title: Text(
                                  e,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                value: selectedOptions[filters.indexOf(e)],
                                onChanged: (value) {
                                  if (mounted)
                                    setState(() {
                                      selectedOptions[filters.indexOf(e)] =
                                          value!;
                                    });
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                    NormalButtonCustom(
                      name: "Confirm",
                      action: () async {
                        List<int> selectedStrings = [];
                        for (int i = 0; i < selectedOptions.length; i++) {
                          if (selectedOptions[i]) {
                            selectedStrings.add(i);
                          }
                        }
                        filterInt = selectedStrings;
                        setList(selectedStrings, search);
                        Navigator.pop(context);
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: SearchField(
            controller: _controller,
            search: (p0) {
              search = p0;
              setList(filterInt, search);
            },
            filter: () {
              displayBottomSheet(context);
            },
            hint: "Search for customer",
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          width: 360.w,
          height: 810.h * 0.7,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: customerShows.map(
                    (e) {
                      return CustomerElement(
                        customer: e,
                        action: (customer) {
                          displayUserAction(context, customer);
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 150.h,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
