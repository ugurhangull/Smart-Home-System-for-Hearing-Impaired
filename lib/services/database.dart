import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  Future<void> addConversationData(
      conversationData, String conversationId) async {
    await FirebaseFirestore.instance
        .collection("conversation")
        .doc(conversationId)
        .set(conversationData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addMessagesData(conversationData, String conversationId) async {
    await FirebaseFirestore.instance
        .collection("conversation")
        .doc(conversationId)
        .collection("messages")
        .add(conversationData)
        .catchError((e) {
      print(e);
    });
  }

  getChatsdata() async {
    return await FirebaseFirestore.instance
        .collection("conversation")
        .snapshots();
  }

  getMessagesData(quizId) async {
    return await FirebaseFirestore.instance
        .collection("conversation")
        .doc(quizId)
        .collection("messages")
        .get();
  }
}
