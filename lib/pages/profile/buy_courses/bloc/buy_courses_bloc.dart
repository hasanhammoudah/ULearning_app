import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_event.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_state.dart';

class BuyCoursesBloc extends Bloc<BuyCoursesEvents, BuyCoursesStates> {
  BuyCoursesBloc() : super(const InitialBuyCoursesStates()) {
    on<TriggerInitialBuyCoursesEvents>(_triggerInitialBuyCourses);
    on<TriggerLoadingBuyCoursesEvents>(_triggerLoadingBuyCourses);
    on<TriggerDoneLoadingBuyCoursesEvents>(_triggerDoneLoadingBuyCourses);
    on<TriggerLoadedBuyCoursesEvents>(_triggerLoadedBuyCourses);
  }

  void _triggerInitialBuyCourses(
      TriggerInitialBuyCoursesEvents event, Emitter<BuyCoursesStates> emit) {
    emit(const InitialBuyCoursesStates());
  }

  void _triggerLoadedBuyCourses(
      TriggerLoadedBuyCoursesEvents event, Emitter<BuyCoursesStates> emit) {
    emit(LoadedBuyCoursesStates(event.courseItem));
  }

  void _triggerLoadingBuyCourses(
      TriggerLoadingBuyCoursesEvents event, Emitter<BuyCoursesStates> emit) {
    emit(const LoadingBuyCoursesStates());
  }

  void _triggerDoneLoadingBuyCourses(TriggerDoneLoadingBuyCoursesEvents event,
      Emitter<BuyCoursesStates> emit) {
    emit(const DoneLoadingBuyCoursesStates());
  }
}
