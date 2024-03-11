import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/course/bloc/course_event.dart';
import 'package:ulearning_app/pages/course/bloc/course_state.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  CourseBloc() : super(const CourseStates()) {
    on<TriggerCourse>(_triggerCourse);
  }
  void _triggerCourse(
      TriggerCourse event, Emitter<CourseStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
