import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_bloc.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_event.dart';

class ChatController {
  late BuildContext context;
  ChatController({required this.context});
  TextEditingController textEditingController = TextEditingController();
  ScrollController appScrollController = ScrollController();

  UserItem? userProfile = Global.storageService.getUserProfile();

  final db = FirebaseFirestore.instance;
  late var docId;
  late var listener;
  bool isLoadMore = true;

  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    docId = data["doc_id"];
    // print("--------my doc id ${docId}-----");

    _chatSnapShots();
  }

  void dispose() {
    textEditingController.dispose();
  }

  Future<void> _chatSnapShots() async {
    var chatContext = context;
    chatContext.read<ChatBloc>().add(const TriggerClearMsgList());
    var messages = await db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .limit(15);

    //  print(jsonEncode(Message));
    listener = messages.snapshots().listen(
      (event) {
        // print("${event.docs[0].data().content}");
        List<Msgcontent> tempMsgList = <Msgcontent>[];
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (kDebugMode) {
                print('added ---: ${change.doc.data()}');
              }
              if (change.doc.data() != null) {
                tempMsgList.add(change.doc.data()!);
                if (kDebugMode) {
                  print('added');
                }
              }
              break;
            case DocumentChangeType.modified:
            // TODO: Handle this case.
            case DocumentChangeType.removed:
            // TODO: Handle this case.
          }
        }
        if (kDebugMode) {
          print('the lenght of the chat is ${tempMsgList[0].content}');
        }

        for (var element in tempMsgList.reversed) {
          chatContext.read<ChatBloc>().add(TriggerMsgContentList(element));
        }
      },
      onError: (error) => print('Listen failed $error'),
    );

    appScrollController.addListener(() {
      if (kDebugMode) {
        print('offset----${appScrollController.offset}---------');
      }
      if (kDebugMode) {
        print(
            'maxScrollExtent----${appScrollController.position.maxScrollExtent}---------');
      }

      if ((appScrollController.offset) >
          (appScrollController.position.maxScrollExtent)) {
        if (isLoadMore) {
          chatContext.read<ChatBloc>().add(const TriggerLoadMsgData(true));

          isLoadMore = false;
          print('loading............');
          _asyncLoadMoreData();
          chatContext.read<ChatBloc>().add(const TriggerLoadMsgData(false));
        }
      }
    });
  }

  Future<void> _asyncLoadMoreData() async {
    var state = context.read<ChatBloc>().state;
    var moreMessages = await db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .where("addtime", isLessThan: state.msgcontentList.last.addtime)
        .limit(10)
        .get();

    if (moreMessages.docs.isNotEmpty) {
      moreMessages.docs.forEach((element) {
        var data = element.data();
        context.read<ChatBloc>().add(TriggerAddMsgContent(data));
      });

      //TODO read more about this and read ** Encode and decode for dart
      SchedulerBinding.instance.addPostFrameCallback((_) {
        isLoadMore = true;
      });
    }
  }

  sendMessage() async {
    if (textEditingController.text.isEmpty) {
      toastInfo(msg: "You can not send an empty message");
    } else {
      String sendContent = textEditingController.text.trim();
      textEditingController.clear();
      final content = Msgcontent(
        token: userProfile!.token,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now(),
      );

      await db
          .collection("message")
          .doc(docId)
          .collection("msglist")
          .withConverter(
              fromFirestore: Msgcontent.fromFirestore,
              toFirestore: (Msgcontent msg, options) => msg.toFirestore())
          .add(content)
          .then((DocumentReference doc) {
        print("----------after adding ${docId}------------");
      });

      var messageRes = await db
          .collection("message")
          .doc(docId)
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .get();

      if (messageRes.data()! != null) {
        var item = messageRes.data()!;

        int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
        int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
        if (item.from_token == userProfile!.token) {
          from_msg_num = from_msg_num + 1;
        } else {
          to_msg_num = to_msg_num + 1;
        }

        await db.collection("message").doc(docId).update({
          "to_msg_num": to_msg_num,
          "from_msg_num": from_msg_num,
          "last_time": Timestamp.now(),
          "last_msg": sendContent
        });
      }
    }
  }
}
