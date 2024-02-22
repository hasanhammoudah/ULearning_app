import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_event.dart';
import 'package:ulearning_app/pages/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterStates> {
  RegisterBloc() : super(const RegisterStates()) {
    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
  }

  void _userNameEvent(UserNameEvent event, Emitter<RegisterStates> emit) {
    print("${event.username}");
    emit(state.copyWith(username: event.username));
  }

  void _emailEvent(EmailEvent event, Emitter<RegisterStates> emit) {
    print("${event.email}");
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterStates> emit) {
    print("${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(RePasswordEvent event, Emitter<RegisterStates> emit) {
    print("${event.rePassword}");
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
