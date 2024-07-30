import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/models/chat.dart';
import 'package:mate_project/screens/chat/widgets/auto_response_details.dart';
import 'package:mate_project/screens/chat/widgets/chat_details.dart';

// ignore: must_be_immutable
class Conversation extends StatefulWidget {
  Conversation({
    super.key,
    required this.messages,
    this.ask,
  });

  final List<Chat> messages;
  void Function(String)? ask;

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 710.h * 0.8,
      width: 360.w,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: widget.messages.map(
            (e) {
              if (e.text == "") {
                return const SizedBox(
                  height: 0,
                  width: 0,
                );
              } else {
                int prevId1 = -1;
                if (widget.messages.indexOf(e) == 0) {
                  return ChatDetails(
                    chatElement: e,
                    isAnswer: false,
                  );
                } else {
                  prevId1 =
                      widget.messages[widget.messages.indexOf(e) - 1].id_1;
                  if (e.id_1 == prevId1) {
                    if (e.id_1 == 1) {
                      return ChatDetails(
                        chatElement: e,
                        isAnswer: false,
                      );
                    } else {
                      return ChatDetails(
                        chatElement: e,
                        isAnswer: true,
                      );

                      // Hiển thị câu trả lời khi câu hỏi của khách hàng là auto response
                      // return AutoResponseDetails(
                      //   chatElement: e,
                      //   isAnswer: true,
                      //   ask: widget.ask!,
                      // );
                    }
                  } else {
                    if (e.id_1 == 1) {
                      return Column(
                        children: [
                          ChatDetails(
                            chatElement: e,
                            isAnswer: false,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          ChatDetails(
                            chatElement: e,
                            isAnswer: true,
                          ),
                        ],
                      );

                      // Hiển thị câu trả lời khi câu hỏi của khách hàng là auto response
                      // return AutoResponseDetails(
                      //   chatElement: e,
                      //   isAnswer: true,
                      //   ask: widget.ask!,
                      // );
                    }
                  }
                }
              }
            },
          ).toList(),
        ),
      ),
    );
  }
}
