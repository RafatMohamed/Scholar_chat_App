import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/chat/data/chat_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/app_constant.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.border,
    required this.textSend,
    this.isMe = true,
    this.color = AppConstant.primaryColor,
    this.alignmentDirectional = AlignmentDirectional.centerEnd,
  });

  final Radius border;
  final ChatModel textSend;
  final bool isMe;
  final Color color;
  final AlignmentGeometry alignmentDirectional;
  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Align(
          alignment:
              isMe ? alignmentDirectional : AlignmentDirectional.centerStart,
          child: Container(
            constraints: BoxConstraints(maxWidth: sizeWidth * 0.6),
            padding: const EdgeInsetsDirectional.all(16),
            decoration: BoxDecoration(
              color: isMe ? color : const Color(0xff006D84),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: border,
                topStart: border,
                bottomEnd: isMe ? Radius.zero : border,
                bottomStart: isMe ? border : Radius.zero,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textSend.message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 5),
                Text(
                  textSend.timestamp != null
                      ? timeago.format(
                        textSend.timestamp!.toDate(),
                        locale: 'en_short',
                      )
                      : "just now",
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
