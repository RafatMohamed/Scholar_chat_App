import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';
import 'package:scholar_chat_proj/features/chat/model/chat_service.dart';

import '../../../core/helper/notify_app.dart';
import '../../../core/widget/chat_bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/chat_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.email});
  final String email;
  static final ChatService chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    final username = email.split('@')[0];
    final Radius border = Radius.circular(20);
    return StreamBuilder<QuerySnapshot>(
      stream: chatService.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return NotifyApp.circularProgress();
        }
        List <ChatModel> chatList =[];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          chatList.add(ChatModel.fromJson(snapshot.data!.docs[i]));
        }
        return  SafeArea(
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
                    decoration: BoxDecoration(
                      color: AppConstant.primaryColor,
                    ),
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
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                        key: chatService.listKey,
                        controller: chatService.scrollController,
                        itemCount: chatList.length,
                        itemBuilder: (context, index,) {
                          return AnimatedBuilder(
                              animation: chatService.scrollController,
                              builder:(context, child) {
                              return ChatBubble(
                                border: border,
                                textSend: chatList[index],
                                isMe: chatList[index].email == email,
                              );
                            }
                          );
                        },
                        physics: BouncingScrollPhysics(),
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
                            controller: chatService.messageController,
                            onFieldSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                chatService.sendMessage(messageReq: value.trim(), email: email);
                                chatService.messageController.clear();
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
                            final text = chatService.messageController.text.trim();
                            if (text.isNotEmpty) {
                              chatService.sendMessage(messageReq: text, email: email);
                              chatService.messageController.clear();
                            }
                            chatService.scrollController.animateTo(
                                chatService.scrollController.position.maxScrollExtent ,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.slowMiddle
                            );
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

