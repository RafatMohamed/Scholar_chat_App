import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/chat/model/chat_service.dart';
import 'package:scholar_chat_proj/features/chat/views/widgets/buillder_view.dart';
import '../../../core/helper/notify_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/chat_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.email});
  final String email;
  static final ChatService chatService = ChatService();

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void dispose() {
    ChatView.chatService.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.email.split('@')[0];
    final Radius border = const Radius.circular(20);
    return StreamBuilder<QuerySnapshot>(
      stream: ChatView.chatService.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return NotifyApp.circularProgress();
        }
        List<ChatModel> chatList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          chatList.add(ChatModel.fromJson(snapshot.data!.docs[i]));
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ChatView.chatService.scrollController.hasClients) {
            Future.delayed(const Duration(seconds: 10)).then((value) {
              ChatView.chatService.scrollController.animateTo(
                ChatView.chatService.scrollController.position.maxScrollExtent,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
              );
            });
          }
        });
        return BuilderView(border: border,chatList: chatList,email: widget.email,username: username,);
      },
    );
  }
}
