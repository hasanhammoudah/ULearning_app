import 'package:flutter/material.dart';
import 'package:ulearning_app/pages/messages/message/message_controller.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late MessagesController _messagesController;
  @override
  void didChangeDependencies() {
    _messagesController = MessagesController(context: context);
    _messagesController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
