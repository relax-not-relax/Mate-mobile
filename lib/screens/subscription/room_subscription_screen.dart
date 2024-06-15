import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/screens/subscription/widgets/subscription_selection.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:unicons/unicons.dart';

class RoomSubscriptionScreen extends StatefulWidget {
  const RoomSubscriptionScreen({super.key});

  @override
  State<RoomSubscriptionScreen> createState() => _RoomSubscriptionScreenState();
}

class _RoomSubscriptionScreenState extends State<RoomSubscriptionScreen> {
  bool isSelecting = false;
  late Pack selectedPack;

  @override
  void initState() {
    super.initState();
    selectedPack = Pack(
      packId: 1,
      price: 1100,
      packName: "Gold Room",
      description: "",
      duration: 0,
      status: true,
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

  Future<void> handlePackChange(Pack pack) async {
    waitingForSelection();
    await SharedPreferencesHelper.setPack(pack);
    Pack? _pack = await SharedPreferencesHelper.getPack();
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
              //Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
      body: Stack(
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
                action: () {},
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
                              "Lorem ispum",
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 15, 16, 20),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Regular member",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 84, 87, 91),
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
                      height: 16.h,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: ProjectData.benefits(selectedPack.packId).map(
                        (e) {
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    UniconsSolid.check_circle,
                                    color:
                                        const Color.fromARGB(255, 76, 102, 232),
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
                                height: 8.h,
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
