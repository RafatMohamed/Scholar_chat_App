import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String email;
  final Timestamp? timestamp;
  ChatModel({this.timestamp, required this.message, required this.email});
  factory ChatModel.fromJson(json) => ChatModel(
    message: json['message'],
    email: json['email'],
    timestamp: json['timestamp'],
  );
}
