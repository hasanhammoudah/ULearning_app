import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_event.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvents, ChatStates> {
  ChatBloc() : super(const ChatStates()) {
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerAddMsgContent>(_triggerAddMsgContent);
    on<TriggerMoreStatus>(_triggerMoreStatust);
    on<TriggerClearMsgList>(_triggerClearMsgList);
    on<TriggerLoadMsgData>(_triggerLoadMsgData);
  }

  void _triggerMsgContentList(
      TriggerMsgContentList event, Emitter<ChatStates> emit) {
    // get the total message
    var res = state.msgcontentList.toList();
    //below is the single msessage
    res.insert(0, event.msgContentList);
    //res.add (event.msgContentList);

    emit(state.copyWith(msgcontentList: res));
  }

  void _triggerAddMsgContent(
      TriggerAddMsgContent event, Emitter<ChatStates> emit) {
    // get the total message
    var res = state.msgcontentList.toList();
    res.add(event.msgContent);
    //below is the single msessage
    emit(state.copyWith(msgcontentList: res));
  }

  void _triggerMoreStatust(TriggerMoreStatus event, Emitter<ChatStates> emit) {
    emit(state.copyWith(more_status: event.moreStatus));
  }

  void _triggerClearMsgList(
      TriggerClearMsgList event, Emitter<ChatStates> emit) {
    emit(state.copyWith(msgcontentList: []));
  }

  void _triggerLoadMsgData(TriggerLoadMsgData event, Emitter<ChatStates> emit) {
    emit(state.copyWith(is_loading: event.isLoading));
  }
}
