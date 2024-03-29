import 'package:equatable/equatable.dart';
import 'package:ulearning_app/common/entities/entities.dart';

abstract class ChatEvents extends Equatable {
  const ChatEvents();

  @override
  List<Object> get props => [];
}

class TriggerMsgContentList extends ChatEvents {
  const TriggerMsgContentList(this.msgContent);
  final Msgcontent msgContent;

  @override
  List<Object> get props => [msgContent];
}

class TriggerAddMsgContent extends ChatEvents {
  const TriggerAddMsgContent(this.msgContent);
  final Msgcontent msgContent;

  @override
  List<Object> get props => [msgContent];
}

class TriggerMoreStatus extends ChatEvents {
  const TriggerMoreStatus(this.moreStatus);
  final bool moreStatus;

  @override
  List<Object> get props => [moreStatus];
}
