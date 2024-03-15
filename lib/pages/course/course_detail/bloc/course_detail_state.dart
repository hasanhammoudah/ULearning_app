import 'package:ulearning_app/common/entities/entities.dart';

class CourseDetailStates {
  const CourseDetailStates(
      {this.lessonItem = const <LessonItem>[], this.courseItem});

  final CourseItem? courseItem;
  final List<LessonItem>? lessonItem;

  CourseDetailStates copyWith(
      {CourseItem? courseItem, List<LessonItem>? lessonItem}) {
    return CourseDetailStates(
      courseItem: courseItem ?? this.courseItem,
      lessonItem: lessonItem ?? this.lessonItem,
    );
  }
}
