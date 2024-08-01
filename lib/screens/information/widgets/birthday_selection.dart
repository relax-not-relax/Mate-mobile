import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class BirthdaySelection extends StatefulWidget {
  const BirthdaySelection({
    super.key,
    required this.date,
    required this.onDateChanged,
    required this.error,
  });

  final String date;
  final void Function(String) onDateChanged;
  final String error;

  @override
  State<BirthdaySelection> createState() => _BirthdaySelectionState();
}

class _BirthdaySelectionState extends State<BirthdaySelection> {
  late String parsedDate;
  late DateTime dateInput;

  @override
  void initState() {
    super.initState();
    dateInput = DateTime.parse(widget.date);
    parsedDate = DateFormat("d/M/y").format(dateInput);
  }

  void updateDate() async {
    final DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: dateInput,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (datePicker != null) {
      if (mounted)
        setState(() {
          dateInput = datePicker;
        });
      widget.onDateChanged(
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateInput),
      );
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    parsedDate = DateFormat("d/M/y").format(dateInput);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            updateDate();
          },
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(
              Size(360.w, 55.h),
            ),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 238, 241, 255),
            ),

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                  color: const Color.fromARGB(255, 238, 241, 255),
                ),
              ),
            ),
            // padding: MaterialStateProperty.all(
            //     EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w)),
          ),
          icon: const Icon(
            IconlyBold.calendar,
            color: Color.fromARGB(255, 84, 110, 255),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 8.w), // Thêm khoảng cách ở đây
              Text(
                parsedDate,
                style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 140, 159, 255),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          widget.error,
          style: GoogleFonts.inter(
            color: const Color.fromARGB(255, 230, 57, 71),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
