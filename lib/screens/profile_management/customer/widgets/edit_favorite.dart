import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/screens/profile_management/customer/widgets/account_edit_selection_field.dart';

class EditFavorite extends StatefulWidget {
  const EditFavorite({
    super.key,
    required this.selected,
    required this.onHobbyChanged,
    required this.controller,
    required this.height,
  });

  final List<String> selected;
  final void Function(List<String>, bool, String, TextEditingController)
      onHobbyChanged;
  final TextEditingController controller;
  final double height;

  @override
  State<EditFavorite> createState() => _EditFavoriteState();
}

class _EditFavoriteState extends State<EditFavorite> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 8.h,
        ),
        Container(
          width: 360.w,
          height: widget.height,
          child: TextFormField(
            controller: widget.controller,
            ignorePointers: true,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color.fromARGB(255, 108, 110, 116),
              fontWeight: FontWeight.w400,
            ),
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              labelText: "Favorites",
              labelStyle: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 67, 90, 204),
              ),
              hintText: "Favorites",
              prefixIcon: Icon(
                IconlyBold.heart,
                size: 20.sp,
                color: const Color.fromARGB(255, 67, 90, 204),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 148, 141, 246),
                  width: 1.5.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 148, 141, 246),
                  width: 1.5.w,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 16.w,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        widget.selected.length > 5
            ? Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You can only select 5 favorite hobbies",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 230, 57, 71),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                ),
              )
            : Container(),
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
                  widget.onHobbyChanged(
                    widget.selected,
                    value,
                    e,
                    widget.controller,
                  );
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
