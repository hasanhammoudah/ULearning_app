import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_state.dart';
import 'package:ulearning_app/pages/profile/buy_courses/buy_courses_controller.dart';
import 'package:ulearning_app/pages/profile/buy_courses/widgets/buy_courses_widgets.dart';

class BuyCourses extends StatefulWidget {
  const BuyCourses({super.key});

  @override
  State<BuyCourses> createState() => _BuyCoursesState();
}

class _BuyCoursesState extends State<BuyCourses> {
  late BuyCoursesController _buyCoursesController;
  @override
  void didChangeDependencies() {
    _buyCoursesController = BuyCoursesController(context: context);
    _buyCoursesController.int();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyCoursesBloc, BuyCoursesStates>(
      builder: (context, state) {
        if (state is DoneLoadingBuyCoursesStates) {
          print('done loading the data......');
          return Container();
        } else if (state is LoadedBuyCoursesStates) {
          if (state.courseItem!.isEmpty) {
            print('bang..........');
          }
          print('just loaded the data we bought.........');

          return Scaffold(
              appBar: buildAppBar('Courses bought'),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      menuView(),
                      buildBoughtListItem(state),
                    ],
                  ),
                ),
              ));
        } else if (state is LoadingBuyCoursesStates) {
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
