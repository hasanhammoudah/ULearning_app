import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_event.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  ProfileBloc() : super(const ProfileStates()) {
    on<TriggerProfileName>(_triggerProfileName);
  }
  _triggerProfileName(TriggerProfileName event, Emitter<ProfileStates> emit) {
    emit(state.copyWith(userProfile: event.userProfile));
  }
}
