import 'package:ulearning_app/common/entities/course.dart';

class HomePageState {
  final int index;
  final List<CourseItem> courseItem;
  const HomePageState({
    this.index = 0,
    this.courseItem = const <CourseItem>[],
  });

  HomePageState copyWith({int? index,List<CourseItem>? courseItem}) {
    return HomePageState(
      courseItem: courseItem?? this.courseItem,
      index: index ?? this.index,
    );
  }
}
