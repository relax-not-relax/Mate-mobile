import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class LocationListElement extends StatelessWidget {
  const LocationListElement({
    super.key,
    required this.onPressed,
    required this.location,
  });

  final void Function(String) onPressed;
  final String location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(location);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.location,
            color: const Color.fromARGB(255, 32, 35, 43),
            size: 20.sp,
          ),
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            child: Text(
              location,
              style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 32, 35, 43),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
