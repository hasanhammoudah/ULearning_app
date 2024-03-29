import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_cubit.dart';

class ContributorController {
  late BuildContext context;
  ContributorController({required this.context});

  void init() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAuthorData(args['token']);
    asyncLoadAuthorCourseData(args['token']);
  }

  void asyncLoadAuthorData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseAPI.courseAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<ContributorCubit>().triggerContributor(result.data!);
        var res = jsonEncode(context.read<ContributorCubit>().state.authorItem);
        print('my author is ${res}');
      } else {}
    }
    // print('-----my token is $token');
  }

  void asyncLoadAuthorCourseData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseAPI.courseListAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<ContributorCubit>().triggerCourseItemChange(result.data!);
      }
    }
  }
}
