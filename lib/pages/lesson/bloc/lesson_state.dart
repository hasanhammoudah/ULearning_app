import 'package:ulearning_app/common/entities/lesson.dart';

class LessonStates {
  final List<LessonVideoItem> lessonVideoItem;
  final Future<void>? initializeVideoPlayerFuture;
  final bool isPlay;
  const LessonStates(
      {this.lessonVideoItem = const <LessonVideoItem>[],
      this.initializeVideoPlayerFuture,
      this.isPlay = false});

  LessonStates copyWith(
      {List<LessonVideoItem>? lessonVideoItem,
      bool? isPlay,
      Future<void>? initializeVideoPlayerFuture}) {
    return LessonStates(
      lessonVideoItem: lessonVideoItem ?? this.lessonVideoItem,
      isPlay: isPlay ?? this.isPlay,
      initializeVideoPlayerFuture:
          initializeVideoPlayerFuture ?? this.initializeVideoPlayerFuture,
    );
  }
}
