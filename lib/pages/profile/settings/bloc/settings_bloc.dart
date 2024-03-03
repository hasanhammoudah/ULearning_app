import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_event.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingStates> {
  SettingsBloc() : super(const SettingStates()) {
    on<TriggerSettings>(_triggerSettings);
  }

  _triggerSettings(SettingsEvent event, Emitter<SettingStates> emit) {
    emit(const SettingStates());
  }
}
