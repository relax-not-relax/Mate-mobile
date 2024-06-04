import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/event.dart';

class OpenEvent extends StatefulWidget {
  const OpenEvent({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<OpenEvent> createState() => _OpenEventState();
}

class _OpenEventState extends State<OpenEvent> {
  DateFormat formatter = DateFormat('dd MMMM');
  DateFormat dayFormatter = DateFormat('EEEE');
  DateFormat monthFormatter = DateFormat('MMMM');
  DateFormat dateFormatter = DateFormat('dd');
  DateFormat yearFormatter = DateFormat('yyyy');
  DateFormat timeFormatter = DateFormat('HH:mm');
  String? formattedDate;
  String? formattedDateTime;
  List<String> splittedDate = [];

  @override
  void initState() {
    super.initState();
    formattedDate = formatter.format(widget.event.start);
    splittedDate = formattedDate!.split(' ');
    formattedDateTime =
        '${timeFormatter.format(widget.event.start)} ${dayFormatter.format(widget.event.start)}, ${monthFormatter.format(widget.event.start)} ${dateFormatter.format(widget.event.start)}, ${yearFormatter.format(widget.event.start)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 140.h,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 241, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(38, 20, 19, 19),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4), // changes position of shadow
            )
          ]),
      child: Row(
        children: [
          Container(
            width: 102.w,
            height: 140.h,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    splittedDate[0],
                    style: GoogleFonts.inter(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 35, 47, 107),
                    ),
                  ),
                  Text(
                    splittedDate[1],
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 35, 47, 107),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 140.h,
              child: Stack(
                children: [
                  Container(
                    height: 140.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/pics/concert.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Container(
                    height: 140.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/pics/inner_shadow.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              widget.event.title,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                IconlyLight.time_circle,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Flexible(
                                child: Text(
                                  formattedDateTime ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
