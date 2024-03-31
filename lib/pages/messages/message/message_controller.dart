import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/global.dart';

class MessagesController {
  late BuildContext context;
  MessagesController({required this.context});
  final db = FirebaseFirestore.instance;
  UserItem? userProfile = Global.storageService.getUserProfile();
  StreamSubscription<QuerySnapshot<Object?>>? listener1;
  StreamSubscription<QuerySnapshot<Object?>>? listener2;

  void init() {
    _snapShots();
  }

  void _snapShots() {
    var token = userProfile!.token;
    // print('user token $token');
    final toMessageRef = db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: token);

    final fromMessageRef = db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token);

    listener1 = fromMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });

    listener2 = fromMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });
  }

  _asyncLoadMsgData() async {
    var msgContext = context;
    final fromMessageRef = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: userProfile!.token)
        .get();

    print(fromMessageRef.docs.length);

    final toMessageRef = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: userProfile!.token)
        .get();
    print(toMessageRef.docs.length);

    List<Message> messageList = <Message>[];
    if (fromMessageRef.docs.isNotEmpty) {
      var message = await _addMessage(fromMessageRef.docs);
      messageList.addAll(message);
    }

    if (toMessageRef.docs.isNotEmpty) {
      var message = await _addMessage(toMessageRef.docs);
      messageList.addAll(message);
    }

    messageList.sort((a, b) {
      if (b.last_time == null) return 0;
      if (a.last_time == null) return 0;
    });
  }

  Future<List<Message>> _addMessage(
      List<QueryDocumentSnapshot<Msg>> data) async {
    List<Message> messageList = <Message>[];
    data.forEach((element) {
      var item = element.data();
      Message message = Message();
      message.doc_id = element.id;
      message.last_time = item.last_time;
      message.last_msg = item.last_msg;
      message.msg_num = item.msg_num;

      if (item.from_token == userProfile!.token) {
        message.name = item.to_name;
        message.avatar = item.to_avatar;
        message.msg_num = item.to_msg_num ?? 0;
        message.online = item.to_online;
      } else {
        message.name = item.from_name;
        message.avatar = item.from_avatar;
        message.msg_num = item.from_msg_num ?? 0;
        message.online = item.from_online;
      }

      messageList.add(message);
    });

    return messageList;
  }
}
