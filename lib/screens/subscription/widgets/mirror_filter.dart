import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/pack.dart';

class MirrorFilter extends StatelessWidget {
  const MirrorFilter({
    super.key,
    required this.pack,
    required this.change,
  });

  final Pack pack;
  final void Function(String) change;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: 360.w,
        height: 110.h,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              blurRadius: 32,
              color: Color.fromARGB(47, 20, 19, 19),
              offset: Offset(0.0, 30),
            )
          ],
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ProjectData.roomDetails(pack.packId).map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          change(e);
                        },
                        child: Container(
                          width: 110.w,
                          height: 76.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 4.w,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(e),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
