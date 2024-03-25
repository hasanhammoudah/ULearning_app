import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_event.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_state.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvents, MyCoursesStates> {
  MyCoursesBloc() : super(const InitialMyCoursesStates()) {
    on<TriggerInitialMyCoursesEvents>(_triggerInitialMyCourses);
    on<TriggerLoadingMyCoursesEvents>(_triggerLoadingMyCourses);
    on<TriggerLoadedMyCoursesEvents>(_triggerLoadedMyCourses);
    on<TriggerDoneLoadingMyCoursesEvents>(_triggerDoneLoadingMyCourses);
  }

  void _triggerInitialMyCourses(
      TriggerInitialMyCoursesEvents event, Emitter<MyCoursesStates> emit) {
    print('Initial........');
    emit(const InitialMyCoursesStates());
  }

  void _triggerLoadedMyCourses(
      TriggerLoadedMyCoursesEvents event, Emitter<MyCoursesStates> emit) {
    print('loaded........');

    emit(LoadedMyCoursesStates(event.courseItem));
  }

  void _triggerLoadingMyCourses(
      TriggerLoadingMyCoursesEvents event, Emitter<MyCoursesStates> emit) {
    print('loading........');

    emit(const LoadingMyCoursesStates());
  }

  void _triggerDoneLoadingMyCourses(
      TriggerDoneLoadingMyCoursesEvents event, Emitter<MyCoursesStates> emit) {
    print('done........');

    emit(const DoneLoadingMyCoursesStates());
  }
}
