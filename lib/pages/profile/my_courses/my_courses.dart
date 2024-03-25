import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_state.dart';
import 'package:ulearning_app/pages/profile/my_courses/my_courses_controller.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  late MyCoursesController _myCoursesController;
  @override
  void didChangeDependencies() {
    _myCoursesController = MyCoursesController(context: context);
    _myCoursesController.int();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCoursesBloc, MyCoursesStates>(
      builder: (context, state) {
        if (state is DoneLoadingMyCoursesStates) {
          print('done loading the data......');
          return Scaffold(
              appBar: buildAppBar('My Courses'),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                  ],
                ),
              ));
        } else if (state is LoadedMyCoursesStates) {
          print('just loaded the data.........');
          return Container();
        } else if (state is LoadingMyCoursesStates) {
          print('loading the data...............');
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}
