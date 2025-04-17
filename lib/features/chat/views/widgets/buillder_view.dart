import 'package:flutter/material.dart';
import '../../../../core/constants/app_constant.dart';
import '../../../../core/widget/chat_bubble_widget.dart';
import '../../data/chat_model.dart';
import '../../model/chat_service.dart';

class BuilderView extends StatefulWidget {

  const BuilderView({super.key, required this.username, required this.border, required this.chatList, required this.email, required this.chatService,});
  final String username;
  final Radius border;
  final  List<ChatModel> chatList;
  final String email;
  final ChatService chatService;
  @override
  State<BuilderView> createState() => _BuilderViewState();
}

class _BuilderViewState extends State<BuilderView> {
  late final ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = widget.chatService;
  }

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
                       "Hi ${widget.username}",
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
                   controller: chatService.scrollController,
                   itemCount: widget.chatList.length,
                   itemBuilder: (context, index) {
                     return AnimatedBuilder(
                       animation: chatService.scrollController,
                       builder: (context, child) {
                         return ChatBubble(
                           border: widget.border,
                           textSend: widget.chatList[index],
                           isMe: widget.chatList[index].email ==widget.email,
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
                       controller: chatService.messageController,
                       onFieldSubmitted: (value) {
                         if (value.trim().isNotEmpty) {
                           chatService.sendMessage(
                             messageReq: value.trim(),
                             email: widget.email,
                           );
                           chatService.messageController.clear();
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
                       chatService.messageController.text
                           .trim();
                       if (text.isNotEmpty) {
                         chatService.sendMessage(
                           messageReq: text,
                           email: widget.email,
                         );
                         chatService.messageController.clear();
                         chatService.scrollController.animateTo(
                               chatService
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