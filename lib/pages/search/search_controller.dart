import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/search/bloc/search_bloc.dart';
import 'package:ulearning_app/pages/search/bloc/search_event.dart';

class MySearchController {
  late BuildContext context;

  MySearchController({required this.context});

  void init() {
    asyncLoadRecommenededData();
  }

 Future <void> asyncLoadRecommenededData() async {
    var result = await CourseAPI.recommendedCourseList();
    if (result.code == 200) {
      context.read<SearchBloc>().add(TriggerSearchEvents(result.data!));
    } else {
      toastInfo(msg: 'Internet error');
    }
  }

 Future <void> asyncLoadSearchData(String item) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = item;
    var result = await CourseAPI.search(params: searchRequestEntity);
    if (result.code == 200) {
      context.read<SearchBloc>().add(TriggerSearchEvents(result.data!));
    } else {
      toastInfo(msg: 'Internet error');
    }
  }
}
