import 'package:ulearning_app/common/entities/entities.dart';

class CourseDetailStates {
  const CourseDetailStates({
    this.lessonItem = const <LessonItem>[],
    this.courseItem,
    this.checkBuy = false,
  });

  final CourseItem? courseItem;
  final List<LessonItem>? lessonItem;
  final bool? checkBuy;

  CourseDetailStates copyWith(
      {CourseItem? courseItem, List<LessonItem>? lessonItem, bool? checkBuy}) {
    return CourseDetailStates(
      courseItem: courseItem ?? this.courseItem,
      lessonItem: lessonItem ?? this.lessonItem,
      checkBuy: checkBuy ?? this.checkBuy,
    );
  }
}
