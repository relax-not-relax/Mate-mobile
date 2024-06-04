import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/pack.dart';

class PackMembership extends StatefulWidget {
  const PackMembership({
    super.key,
    required this.pack,
  });

  final Pack pack;

  @override
  State<PackMembership> createState() => _PackMembershipState();
}

class _PackMembershipState extends State<PackMembership> {
  List<String> members = [
    "assets/pics/user_test_1.png",
    "assets/pics/user_test_2.png",
    "assets/pics/user_test_3.png",
  ];

  @override
  Widget build(BuildContext context) {
    Color packColor = Colors.white;
    String packIcon = "";

    switch (widget.pack.packId) {
      case 1:
        packColor = const Color.fromARGB(255, 255, 223, 150);
        packIcon = "assets/pics/gold.png";
        break;
      case 2:
        packColor = const Color.fromARGB(255, 205, 205, 233);
        packIcon = "assets/pics/silver.png";
        break;
      case 3:
        packColor = const Color.fromARGB(255, 249, 161, 89);
        packIcon = "assets/pics/bronze.png";
        break;
    }

    return Container(
      width: 150.w,
      height: 160.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: packColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(38, 20, 19, 19),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  widget.pack.packName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Image.asset(
                packIcon,
                width: 42.w,
                height: 42.w,
              ),
            ],
          ),
          Column(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.start,
                spacing: -8.w,
                children: members.map(
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
                        border: Border.all(
                          color: packColor,
                          width: 2.w,
                          style: BorderStyle.solid,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(7.w),
                ),
                child: Center(
                  child: Text(
                    "& 100 other members",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
