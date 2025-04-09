import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';
import 'package:scholar_chat_proj/features/chat/model/chat_service.dart';
import '../../../core/helper/notify_app.dart';
import '../../../core/widget/chat_bubble_widget.dart';
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
    final Radius border = Radius.circular(20);
    return StreamBuilder<QuerySnapshot>(
      stream: ChatView.chatService.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
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
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppConstant.primaryColor, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: AppConstant.primaryColor),
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            "Hi $username",
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Row(
                            children: [
                              Image.asset(
                                AppConstant.kLogo,
                                width: 50,
                                height: 50,
                              ),
                              Text(
                                AppConstant.appName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: "Scholar",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 4),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        key: ChatView.chatService.listKey,
                        controller: ChatView.chatService.scrollController,
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: ChatView.chatService.scrollController,
                            builder: (context, child) {
                              return ChatBubble(
                                border: border,
                                textSend: chatList[index],
                                isMe: chatList[index].email == widget.email,
                              );
                            },
                          );
                        },
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.all(8.0),
                    margin: const EdgeInsetsDirectional.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: AppConstant.primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ChatView.chatService.messageController,
                            onFieldSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                ChatView.chatService.sendMessage(
                                  messageReq: value.trim(),
                                  email: widget.email,
                                );
                                ChatView.chatService.messageController.clear();
                              }
                            },
                            style: TextStyle(color: AppConstant.primaryColor),
                            maxLines: 3,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            autocorrect: true,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: InputBorder.none,
                              hintText: "Type a message",
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            final text =
                                ChatView.chatService.messageController.text
                                    .trim();
                            if (text.isNotEmpty) {
                              ChatView.chatService.sendMessage(
                                messageReq: text,
                                email: widget.email,
                              );
                              ChatView.chatService.messageController.clear();
                              ChatView.chatService.scrollController.animateTo(
                                ChatView
                                        .chatService
                                        .scrollController
                                        .position
                                        .maxScrollExtent
                                        .toDouble() +
                                    100,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.bounceInOut,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppConstant.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
