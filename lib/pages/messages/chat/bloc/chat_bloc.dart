import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_event.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvents, ChatStates> {
  ChatBloc() : super(const ChatStates()) {
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerAddMsgContent>(_triggerAddMsgContent);
    on<TriggerMoreStatus>(_triggerMoreStatust);
  }

  void _triggerMsgContentList(
      TriggerMsgContentList event, Emitter<ChatStates> emit) {
    //  emit(state.copyWith(msgcontentList: event.msgContent));
  }

  void _triggerAddMsgContent(
      TriggerAddMsgContent event, Emitter<ChatStates> emit) {
    emit(state.copyWith());
  }

  void _triggerMoreStatust(TriggerMoreStatus event, Emitter<ChatStates> emit) {
    emit(state.copyWith(more_status: event.moreStatus));
  }
}
