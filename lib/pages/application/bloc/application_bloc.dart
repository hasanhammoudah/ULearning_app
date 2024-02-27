import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/application/bloc/application_event.dart';
import 'package:ulearning_app/pages/application/bloc/application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(const ApplicationState()) {
    on<TriggerAppEvent>((event, emit) {
      emit(ApplicationState(index: event.index));
    });
  }
}
