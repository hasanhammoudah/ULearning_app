import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_event.dart';

class BuyCoursesController {
  late BuildContext context;
  BuyCoursesController({required this.context});

  void int() {
    asyncLoadBuyCoursesData();
  }

  asyncLoadBuyCoursesData() async {
    context.read<BuyCoursesBloc>().add(const TriggerLoadingBuyCoursesEvents());
    var result = await CourseAPI.coursesBought();
    if (result.code == 200) {
      if (context.mounted) {
        context
            .read<BuyCoursesBloc>()
            .add(const TriggerDoneLoadingBuyCoursesEvents());
        Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<BuyCoursesBloc>()
              .add(TriggerLoadedBuyCoursesEvents(result.data!));
        });
      }
    }
  }
}
