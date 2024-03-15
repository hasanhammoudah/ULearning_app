import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_bloc.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_event.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_state.dart';
import 'package:ulearning_app/pages/lesson/lesson_controller.dart';
import 'package:video_player/video_player.dart';

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
                            Container(
                              width: 325.w,
                              height: 200.h,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/icons/video.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                                borderRadius: BorderRadius.circular(20.h),
                              ),
                              child: FutureBuilder(
                                future: state.initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _lessonController
                                                .videoPlayerController ==
                                            null
                                        ? Container()
                                        : AspectRatio(
                                            aspectRatio: _lessonController
                                                .videoPlayerController!
                                                .value
                                                .aspectRatio,
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                VideoPlayer(
                                                  _lessonController
                                                      .videoPlayerController!,
                                                ),
                                                VideoProgressIndicator(
                                                  _lessonController
                                                      .videoPlayerController!,
                                                  allowScrubbing: true,
                                                  colors:
                                                      const VideoProgressColors(
                                                    playedColor: AppColors
                                                        .primaryElement,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
