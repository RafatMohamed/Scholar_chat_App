import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

  class ChatService {
    //singleton
    ChatService._internal();
    static final ChatService _instance = ChatService._internal();
    factory ChatService() => _instance;
    //initialize
    final CollectionReference message = FirebaseFirestore.instance.collection('messages',);
    final TextEditingController messageController = TextEditingController();
   final ScrollController scrollController = ScrollController();
   final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  get listKey => _listKey;
   final stream = FirebaseFirestore.instance.collection('messages',).orderBy('timestamp', descending: false).snapshots();
   // Service Function
   sendMessage({required dynamic messageReq, required String email}) async {
     await message.add({'message': messageReq, 'email': email, 'timestamp': FieldValue.serverTimestamp(),});
   }
}