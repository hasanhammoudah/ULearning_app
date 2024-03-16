import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_event.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_state.dart';

class LessonBloc extends Bloc<LessonEvents, LessonStates> {
  LessonBloc() : super(const LessonStates()) {
    on<TriggerLessonVideo>(_triggerLessonVideo);
    on<TriggerUrlItem>(_triggerUrlItem);
    on<TriggerPlay>(_triggerPlay);
        on<TriggerVideoIndex>(_triggerVideoIndex);

  }

  void _triggerLessonVideo(
      TriggerLessonVideo event, Emitter<LessonStates> emit) {
    emit(state.copyWith(lessonVideoItem: event.lessonVideoItem));
  }

  void _triggerUrlItem(TriggerUrlItem event, Emitter<LessonStates> emit) {
    emit(state.copyWith(
        initializeVideoPlayerFuture: event.initVideoPlayerFuture));
  }

  void _triggerPlay(TriggerPlay event, Emitter<LessonStates> emit) {
    emit(state.copyWith(isPlay: event.isPlay));
  }
    void _triggerVideoIndex(TriggerVideoIndex event, Emitter<LessonStates> emit) {
    emit(state.copyWith(videoIndex: event.videoIndex));
  }
}
