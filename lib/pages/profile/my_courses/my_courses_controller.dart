import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_event.dart';

class MyCoursesController {
  late BuildContext context;
  MyCoursesController({required this.context});

  void int() {
    asyncLoadCourseData();
  }

  asyncLoadCourseData() async {
    context.read<MyCoursesBloc>().add(const TriggerLoadingMyCoursesEvents());
    var result = await CourseAPI.courseList();
    if (result.code == 200) {
      if (context.mounted) {
        context
            .read<MyCoursesBloc>()
            .add(const TriggerLoadedMyCoursesEvents([]));
        Future.delayed(const Duration(milliseconds: 5), () {
          context
              .read<MyCoursesBloc>()
              .add(const TriggerDoneLoadingMyCoursesEvents());
        });
      }
    }
  }
}
