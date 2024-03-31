import 'package:ulearning_app/common/entities/message.dart';

class MessageStates {
  final List<Message> message;
  final bool loadStatus;

  const MessageStates(
      {this.message = const <Message>[], this.loadStatus = true});

  MessageStates copyWith({List<Message>? message, bool? loadStatus}) {
    return MessageStates(
        message: message ?? this.message,
        loadStatus: loadStatus ?? this.loadStatus);
  }
}
