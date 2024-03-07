import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_event.dart';

class HomeController {
  final BuildContext context;
  HomeController({required this.context});
  UserItem? userProfile = Global.storageService.getUserProfile();

  Future<void> init() async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await CourseAPI.courseList();
      if (result.code == 200) {
        if (context.mounted) {
          context.read<HomePageBloc>().add(HomePageCourseItem(result.data!));
        }
      } else {
        print(result.code);
      }
    } else {
      print('User has already logged out');
    }
  }
}
