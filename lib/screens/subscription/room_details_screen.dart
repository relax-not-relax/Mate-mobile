import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/screens/subscription/room_subscription_screen.dart';

import 'package:mate_project/screens/subscription/widgets/mirror_filter.dart';
import 'package:readmore/readmore.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({
    super.key,
    required this.pack,
  });

  final Pack pack;

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  // Note mới nhất:
  // Dòng 89, sử lý get customer chuyển về trang RoomSubscriptionScreen
  // Nhớ đọc note dòng 311

  String bigImg = "";
  List<String> titles = [
    "Gold Room: Elevate Your Elderly Care Experience",
    "Silver Room: A Comfortable and Welcoming Living Space",
    "Bronze Room: Affordable Comfort and Care",
  ];

  //Dùng để list ra user sở hữu gói, tạm thời là list hình ảnh, mai mốt sẽ thay thế
  List<String> userImgs = [
    "assets/pics/user_test_1.png",
    "assets/pics/user_test_2.png",
    "assets/pics/user_test_3.png",
  ];

  List<String> descriptions = [
    "Gold Room offers a premium living experience with comprehensive care services to cater to your refined needs. Gold Room is the perfect choice for those seeking a life of comfort, convenience, and attentive care at our elderly care facility.",
    "Silver Room offers comfortable accommodations and a range of services to make your stay enjoyable. Silver Room is a great option for those seeking a comfortable and welcoming living space with essential amenities and services.",
    "Bronze Room provides a comfortable and affordable living option with essential amenities and services. Bronze Room is an excellent choice for those seeking a basic yet comfortable living space at a cost-effective price."
  ];

  @override
  void initState() {
    super.initState();
    bigImg = ProjectData.roomDetails(widget.pack.packId)[0];
  }

  void updateBigImg(String img) {
    if (mounted)
      setState(() {
        bigImg = img;
      });
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    String description = "";
    switch (widget.pack.packId) {
      case 1:
        title = titles[0];
        description = descriptions[0];
        break;
      case 2:
        title = titles[1];
        description = descriptions[1];
        break;
      case 3:
        title = titles[2];
        description = descriptions[2];
        break;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     return RoomSubscriptionScreen(customer: customer)
            //   },),
            //   (route) => false,
            // );
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Color.fromARGB(61, 28, 28, 28),
            ),
          ),
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        child: Stack(
          children: [
            Container(
              width: 360.w,
              height: 800.h * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bigImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 72.h, 0, 24.h),
                width: 360.w,
                height: 800.h * 0.6,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          spacing: -8.w,
                          children: userImgs.map(
                            (member) {
                              return Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(member),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(30.w),
                                ),
                              );
                            },
                          ).toList()
                            ..add(
                              Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 67, 90, 204),
                                  borderRadius: BorderRadius.circular(30.w),
                                ),
                                child: Center(
                                  child: Text(
                                    "20",
                                    style: GoogleFonts.inter(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 24.w,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:
                                ProjectData.roomFacilities(widget.pack.packId)
                                    .map(
                              (e) {
                                return Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 234, 234, 235),
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 8.w,
                                        children: [
                                          e.icon,
                                          Text(
                                            e.title,
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 84, 87, 91),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Text(
                          "Description",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: ReadMoreText(
                          description,
                          trimLines: 3,
                          textAlign: TextAlign.start,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "Read more",
                          trimExpandedText: "Show less",
                          lessStyle: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 67, 90, 204),
                          ),
                          moreStyle: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 67, 90, 204),
                          ),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // TODO: Bên dưới dòng này là widget để người dùng chọn mua gói, nếu người dùng đã mua gói thì hiển thị widget đã được comment từ dòng 378 -> 444 (nhớ đọc comment dòng 420)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                              Color.fromARGB(255, 84, 110, 255),
                            ),
                            fixedSize: WidgetStatePropertyAll(
                              Size(360.w, 59.h),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 84, 110, 255),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Choose pack",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      "\$1000",
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "/per year",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 24.w,
                      //   ),
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ButtonStyle(
                      //       backgroundColor: const WidgetStatePropertyAll(
                      //         Color.fromARGB(255, 183, 183, 183),
                      //       ),
                      //       fixedSize: WidgetStatePropertyAll(
                      //         Size(360.w, 59.h),
                      //       ),
                      //       shape: WidgetStatePropertyAll(
                      //         RoundedRectangleBorder(
                      //           side: const BorderSide(
                      //             color: Color.fromARGB(255, 183, 183, 183),
                      //           ),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //       ),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 16.w,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             "Choose pack",
                      //             style: GoogleFonts.inter(
                      //               fontSize: 12.sp,
                      //               fontWeight: FontWeight.w600,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //           Wrap(
                      //             crossAxisAlignment: WrapCrossAlignment.center,
                      //             children: [
                      //               Text(
                      //                 // giá tiền của gói, nhớ thay đổi
                      //                 "\$1000",
                      //                 style: GoogleFonts.inter(
                      //                   fontSize: 14.sp,
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 "/per year",
                      //                 style: GoogleFonts.inter(
                      //                   fontSize: 12.sp,
                      //                   fontWeight: FontWeight.w400,
                      //                   color: Colors.white,
                      //                 ),
                      //                 maxLines: 1,
                      //                 overflow: TextOverflow.ellipsis,
                      //               )
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 270.h,
              left: 0,
              right: 0,
              child: MirrorFilter(
                pack: widget.pack,
                change: updateBigImg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
