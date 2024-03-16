import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/lesson.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_bloc.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_event.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_state.dart';
import 'package:ulearning_app/pages/lesson/lesson_controller.dart';
import 'package:video_player/video_player.dart';

Widget videoPlayer(LessonStates state, LessonController lessonController) {
  return state.lessonVideoItem.isEmpty
      ? Container()
      : Container(
          width: 325.w,
          height: 200.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  state.lessonVideoItem[state.videoIndex].thumbnail!),
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.circular(0.h),
          ),
          child: FutureBuilder(
            future: state.initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return lessonController.videoPlayerController == null
                    ? Container()
                    : AspectRatio(
                        aspectRatio: lessonController
                            .videoPlayerController!.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(
                              lessonController.videoPlayerController!,
                            ),
                            VideoProgressIndicator(
                              lessonController.videoPlayerController!,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: AppColors.primaryElement,
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
        );
}

Widget videoControls(LessonStates state, LessonController lessonController,
    BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 15.h,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              var videoIndex = context.read<LessonBloc>().state.videoIndex;

              videoIndex = videoIndex - 1;
              if (videoIndex < 0) {
                videoIndex = 0;
                context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
                toastInfo(msg: 'This is the first video you are watching');
                return;
              } else {
                var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                lessonController.playVideo(videoItem.url!);
              }
              context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
            },
            child: Container(
              width: 24.w,
              height: 24.h,
              margin: EdgeInsets.only(
                right: 15.w,
              ),
              child: Image.asset('assets/icons/rewind-left.png'),
            )),
        GestureDetector(
          onTap: () {
            if (state.isPlay) {
              lessonController.videoPlayerController?.pause();
              context.read<LessonBloc>().add(const TriggerPlay(false));
            } else {
              lessonController.videoPlayerController?.play();
              context.read<LessonBloc>().add(const TriggerPlay(true));
            }
          },
          child: state.isPlay
              ? Container(
                  width: 24.w,
                  height: 24.h,
                  child: Image.asset('assets/icons/pause.png'),
                )
              : Container(
                  width: 24.w,
                  height: 24.h,
                  child: Image.asset('assets/icons/play-circle.png'),
                ),
        ),
        GestureDetector(
            onTap: () {
              var videoIndex = context.read<LessonBloc>().state.videoIndex;
              videoIndex = videoIndex + 1;
              if (videoIndex >= state.lessonVideoItem.length) {
                videoIndex = videoIndex - 1;
                toastInfo(msg: 'No video in the play list');
                context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
                return;
              } else {
                var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                lessonController.playVideo(videoItem.url!);
              }
              context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
            },
            child: Container(
              width: 24.w,
              height: 24.h,
              margin: EdgeInsets.only(
                left: 15.w,
              ),
              child: Image.asset('assets/icons/rewind-right.png'),
            )),
      ],
    ),
  );
}

SliverPadding videoList(LessonStates state, LessonController lessonController) {
  return SliverPadding(
    padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 25.w),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _buildLessonItems(
            context, index, state.lessonVideoItem[index], lessonController);
      }, childCount: state.lessonVideoItem.length),
    ),
  );
}

Widget _buildLessonItems(BuildContext context, int index, LessonVideoItem item,
    LessonController lessonController) {
  return Container(
    width: 325.w,
    height: 80.h,
    margin: EdgeInsets.only(
      bottom: 20.h,
    ),
    padding: EdgeInsets.symmetric(
      vertical: 10.h,
      horizontal: 10.w,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        10.w,
      ),
      color: const Color.fromRGBO(255, 255, 255, 1),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 1),
        )
      ],
    ),
    child: InkWell(
      onTap: () {
        var videoIndex =
            context.read<LessonBloc>().add(TriggerVideoIndex(index));

        lessonController.playVideo(item.url!);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      "${item.thumbnail}",
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6.sp),
                alignment: Alignment.centerLeft,
                width: 210.w,
                height: 60.h,
                child: reusableText2(
                  fontSize: 13.sp,
                  "${item.name}",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: GestureDetector(
                  onTap: () {
                    context.read<LessonBloc>().add(TriggerVideoIndex(index));
                    lessonController.playVideo(item.url!);
                  },
                  child: Image.asset(
                    'assets/icons/play-circle.png',
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
