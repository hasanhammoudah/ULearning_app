abstract class RegisterEvent {
  const RegisterEvent();
}

class UserNameEvent extends RegisterEvent {
  final String username;
  const UserNameEvent(this.username);
}

class EmailEvent extends RegisterEvent {
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends RegisterEvent {
  final String password;
  const PasswordEvent(this.password);
}

class RePasswordEvent extends RegisterEvent {
  final String rePassword;
  const RePasswordEvent(this.rePassword);
}
