import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/data/project_data.dart';

class HobbiesSelection extends StatefulWidget {
  const HobbiesSelection({
    super.key,
    required this.selected,
    required this.onHobbyChanged,
  });

  final List<String> selected;
  final void Function(List<String>, bool, String) onHobbyChanged;

  @override
  State<HobbiesSelection> createState() => _HobbiesSelectionState();
}

class _HobbiesSelectionState extends State<HobbiesSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(
                    "Select up to 5",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 60, 78, 181),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "(${widget.selected.length}/5)",
                    style: widget.selected.length <= 5
                        ? GoogleFonts.inter(
                            color: const Color.fromARGB(255, 60, 78, 181),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          )
                        : GoogleFonts.inter(
                            color: const Color.fromARGB(255, 230, 57, 71),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Wrap(
                spacing: 4.w,
                children: ProjectData.hobbyChoice.map(
                  (e) {
                    return FilterChip(
                      shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
                      selectedColor: const Color.fromARGB(255, 67, 90, 204),
                      showCheckmark: false,
                      label: Text(
                        e,
                        style: widget.selected.contains(e)
                            ? GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              )
                            : GoogleFonts.inter(
                                color: const Color.fromARGB(255, 84, 87, 91),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                      selected: widget.selected.contains(e),
                      onSelected: (value) {
                        widget.onHobbyChanged(widget.selected, value, e);
                      },
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 8.h,
              ),
              // Text(
              //   'Looking for: ${widget.selected.map((e) => e).join(', ')}',
              //   style: TextStyle(
              //     fontSize: 12.sp,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
