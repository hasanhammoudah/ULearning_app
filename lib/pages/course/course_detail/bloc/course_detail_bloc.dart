import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_event.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvents, CourseDetailStates> {
  CourseDetailBloc() : super(const CourseDetailStates()) {
    on<TriggerCourseDetail>(_triggerCourseDetail);
  }
  void _triggerCourseDetail(
      TriggerCourseDetail event, Emitter<CourseDetailStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
