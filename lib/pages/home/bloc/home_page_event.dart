import 'package:ulearning_app/common/entities/course.dart';

abstract class HomePageEvents {
  const HomePageEvents();
}

class HomePageDots extends HomePageEvents {
  final int index;
  const HomePageDots(this.index) : super();
}

class HomePageCourseItem extends HomePageEvents {
  final List<CourseItem> courseItem;
  const HomePageCourseItem(this.courseItem);
}
