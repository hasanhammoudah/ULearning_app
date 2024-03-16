import 'package:equatable/equatable.dart';
import 'package:ulearning_app/common/entities/lesson.dart';

class LessonStates extends Equatable {
  final List<LessonVideoItem> lessonVideoItem;
  final Future<void>? initializeVideoPlayerFuture;
  final bool isPlay;
  final int videoIndex;
  const LessonStates(
      {this.videoIndex = 0,
      this.lessonVideoItem = const <LessonVideoItem>[],
      this.initializeVideoPlayerFuture,
      this.isPlay = false});

  LessonStates copyWith(
      {int? videoIndex,
      List<LessonVideoItem>? lessonVideoItem,
      bool? isPlay,
      Future<void>? initializeVideoPlayerFuture}) {
    return LessonStates(
      videoIndex: videoIndex ?? this.videoIndex,
      lessonVideoItem: lessonVideoItem ?? this.lessonVideoItem,
      isPlay: isPlay ?? this.isPlay,
      initializeVideoPlayerFuture:
          initializeVideoPlayerFuture ?? this.initializeVideoPlayerFuture,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [lessonVideoItem, videoIndex, isPlay, initializeVideoPlayerFuture];
}
