import 'package:bloc/bloc.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_state.dart';

class ContributorCubit extends Cubit<ContributorStates> {
  ContributorCubit() : super(ContributorStates());

  triggerContributor(AuthorItem event) {
    emit(state.copyWith(authorItem: event));
  }

   triggerCourseItemChange(List<CourseItem> event) {
    emit(state.copyWith(courseItem: event));
  }
}
