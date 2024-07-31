import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/models/room_assign.dart';
import 'package:mate_project/screens/management/admin/widgets/room_assign_element.dart';
import 'package:mate_project/screens/management/admin/widgets/search_field.dart';

class RoomAssignList extends StatefulWidget {
  const RoomAssignList({
    super.key,
    required this.assignList,
    required this.filter,
    required this.roomId,
    required this.inDate,
  });
  final int roomId;
  final DateTime inDate;
  final List<RoomAssign> assignList;
  final void Function() filter;

  @override
  State<RoomAssignList> createState() => _RoomAssignListState();
}

class _RoomAssignListState extends State<RoomAssignList> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 810.h * 0.55,
      padding: EdgeInsets.fromLTRB(
        24.w,
        16.h,
        24.w,
        0.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchField(
              controller: _controller,
              search: (p0) {},
              filter: widget.filter,
              hint: "Search for customer",
            ),
            SizedBox(
              height: 16.h,
            ),
            Column(
              children: widget.assignList.map(
                (e) {
                  return RoomAssignElement(
                    inDate: widget.inDate,
                    roomId: widget.roomId,
                    room: e,
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 150.h,
            ),
          ],
        ),
      ),
    );
  }
}
