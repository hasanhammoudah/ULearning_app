import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_bloc.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_event.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_state.dart';
import 'package:ulearning_app/pages/lesson/lesson_controller.dart';
import 'package:ulearning_app/pages/lesson/widgets/lesson_details_widgets.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  late LessonController _lessonController;
  int videoIndex = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lessonController = LessonController(context: context);
    context.read<LessonBloc>().add(const TriggerUrlItem(null));
    context.read<LessonBloc>().add(const TriggerVideoIndex(0));

    _lessonController.init();
  }

  @override
  void dispose() {
    _lessonController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonStates>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar('lesson detail'),
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 25.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        child: Column(
                          children: [
                            videoPlayer(state, _lessonController),
                            videoControls(state, _lessonController, context)
                          ],
                        ),
                      ),
                    ),
                  ),
                  videoList(state,_lessonController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
