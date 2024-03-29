import 'package:ulearning_app/common/entities/course.dart';

abstract class SearchEvents {
  const SearchEvents();
}

class TriggerSearchEvents extends SearchEvents {
  TriggerSearchEvents(this.courseItem);
  List<CourseItem> courseItem;
}
