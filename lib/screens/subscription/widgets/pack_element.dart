import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mate_project/models/pack.dart';

class PackElement extends StatelessWidget {
  const PackElement({
    super.key,
    required this.packInput,
    required this.selected,
  });

  final Pack packInput;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    List<Color> stroke = [];
    Color radio = Colors.black;
    String imgUrl = "";

    if (selected) {
      switch (packInput.packId) {
        case 1:
          stroke = [
            const Color.fromARGB(255, 24, 22, 14),
            const Color.fromARGB(255, 255, 223, 150),
          ];
          radio = const Color.fromARGB(255, 255, 223, 150);
          imgUrl = "assets/pics/gold.png";
          break;
        case 2:
          stroke = [
            const Color.fromARGB(255, 24, 22, 14),
            const Color.fromARGB(255, 205, 205, 233),
          ];
          radio = const Color.fromARGB(255, 205, 205, 233);
          imgUrl = "assets/pics/silver.png";
          break;
        case 3:
          stroke = [
            const Color.fromARGB(255, 24, 22, 14),
            const Color.fromARGB(255, 249, 161, 89),
          ];
          radio = const Color.fromARGB(255, 249, 161, 89);
          imgUrl = "assets/pics/bronze.png";
          break;
      }
    }

    return Column(
      children: [
        Container(
          width: 360.w,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: GradientBoxBorder(
              width: selected ? 3.w : 1.w,
              gradient: LinearGradient(
                colors: selected
                    ? stroke
                    : const [
                        Color.fromARGB(255, 189, 190, 191),
                        Color.fromARGB(255, 189, 190, 191),
                      ],
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                selected ? imgUrl : "assets/pics/yet.png",
                width: 29.w,
                height: 29.w,
              ),
              Container(
                width: 360.w * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      packInput.packName,
                      style: GoogleFonts.inter(
                        color: selected
                            ? Colors.black
                            : const Color.fromARGB(255, 157, 158, 161),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Annually",
                      style: GoogleFonts.inter(
                        color: selected
                            ? const Color.fromARGB(255, 84, 87, 91)
                            : const Color.fromARGB(255, 157, 158, 161),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4.w,
                      children: [
                        Text(
                          "\$" "${packInput.price}",
                          style: GoogleFonts.inter(
                            color: selected
                                ? Colors.black
                                : const Color.fromARGB(255, 157, 158, 161),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "/year",
                          style: GoogleFonts.inter(
                            color: selected
                                ? Colors.black
                                : const Color.fromARGB(255, 157, 158, 161),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: selected
                              ? radio
                              : const Color.fromARGB(255, 189, 190, 191),
                          width: selected ? 6 : 2,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
