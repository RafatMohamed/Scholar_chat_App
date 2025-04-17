import 'package:flutter/material.dart';
import '../../../../core/constants/app_constant.dart';
import '../../../../core/widget/chat_bubble_widget.dart';
import '../../data/chat_model.dart';
import '../chat_view.dart';

class BuilderView extends StatelessWidget {

  const BuilderView({super.key, required this.username, required this.border, required this.chatList, required this.email});
  final String username;
  final Radius border;
  final  List<ChatModel> chatList;
  final String email;


  @override
  Widget build(BuildContext context,) {
   return  SafeArea(
     child: Scaffold(
       resizeToAvoidBottomInset: true,
       body:  Container(
         decoration:const BoxDecoration(
           gradient:  LinearGradient(
             colors: [AppConstant.primaryColor, Colors.white],
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
           ),
         ),
         child: Column(
           children: [
             Container(
               decoration: const BoxDecoration(color: AppConstant.primaryColor),
               child: Row(
                 children: [
                   const SizedBox(width: 8),
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
                   const Spacer(flex: 1),
                   Align(
                     alignment: AlignmentDirectional.center,
                     child: Row(
                       children: [
                         Image.asset(
                           AppConstant.kLogo,
                           width: 50,
                           height: 50,
                         ),
                         const Text(
                           AppConstant.appName,
                           style:   TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20,
                             fontFamily: "Scholar",
                           ),
                         ),
                       ],
                     ),
                   ),
                   const  Spacer(flex: 4),
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
                           isMe: chatList[index].email ==email,
                         );
                       },
                     );
                   },
                   physics: const ClampingScrollPhysics(),
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
                             email: email,
                           );
                           ChatView.chatService.messageController.clear();
                         }
                       },
                       style: const TextStyle(color: AppConstant.primaryColor),
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
                           email: email,
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
                           duration: const Duration(milliseconds: 400),
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
  }

}