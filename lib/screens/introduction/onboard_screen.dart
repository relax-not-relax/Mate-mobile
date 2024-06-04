import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/screens/authentication/login_selection_screen.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late int pageIndex;
  List<String> imgUrl = [
    'assets/pics/onboard_1.png',
    'assets/pics/onboard_2.png',
    'assets/pics/onboard_3.png'
  ];
  List<String> titles = [
    'Mate Service',
    'Always By your Side',
    'Annual Event At Mate'
  ];
  List<String> descriptions = [
    'Examine the 24-hour care system. Many useful services, such as utility rooms and massage services, are available. Come and join us in the society of the elderly.',
    'Togetherness - Companion - Sharing',
    'Please come quarterly and join us for the memorable music concert!'
  ];
  late String url;
  late String title;
  late String description;
  final titleColor = Color.fromARGB(255, 68, 60, 172);
  final descriptionColor = Color.fromARGB(255, 41, 45, 50);

  @override
  void initState() {
    super.initState();
    pageIndex = widget.index;
    url = imgUrl[pageIndex];
    title = titles[pageIndex];
    description = descriptions[pageIndex];
  }

  void continueOnboard() {
    if (pageIndex < 2) {
      setState(() {
        pageIndex += 1;
        url = imgUrl[pageIndex];
        title = titles[pageIndex];
        description = descriptions[pageIndex];
      });
    } else if (pageIndex == 2) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return LoginSelectionScreen();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 360.w,
        height: 800.h,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 800.h * 0.6,
                width: 360.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      url,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 800.h * 0.5,
                width: 360.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                    right: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: pageIndex == 0
                          ? 180.w
                          : pageIndex == 2
                              ? 261.w
                              : 280.w,
                      height: 120.h,
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          color: titleColor,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w800,
                          height: 0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120.h,
                      child: Text(
                        description,
                        style: GoogleFonts.inter(
                          color: descriptionColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                          height: 0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 28.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: pageIndex == 0
                                  ? const Color.fromARGB(255, 67, 90, 204)
                                  : const Color.fromARGB(255, 183, 183, 183),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            width: 28.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: pageIndex == 1
                                  ? const Color.fromARGB(255, 67, 90, 204)
                                  : const Color.fromARGB(255, 183, 183, 183),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            width: 28.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: pageIndex == 2
                                  ? const Color.fromARGB(255, 67, 90, 204)
                                  : const Color.fromARGB(255, 183, 183, 183),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: NormalButtonCustom(
                        name: 'Continue',
                        action: continueOnboard,
                        background: const Color.fromARGB(255, 46, 62, 140),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
