import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_event.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_state.dart';

class PayviewBloc extends Bloc<PayWebViewEvent, PayWebViewStates> {
  PayviewBloc() : super(const PayWebViewStates()) {
    on<TriggerWebView>(_triggerWebView);
  }
  void _triggerWebView(TriggerWebView event, Emitter<PayWebViewStates> emit) {
    emit(state.copyWith(url: event.url));
  }
}
