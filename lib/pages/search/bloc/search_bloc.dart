import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/search/bloc/search_event.dart';
import 'package:ulearning_app/pages/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  SearchBloc() : super(const SearchStates()) {
    on<TriggerSearchEvents>(_triggerSearchEvents);
  }
  void _triggerSearchEvents(
      TriggerSearchEvents event, Emitter<SearchStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
