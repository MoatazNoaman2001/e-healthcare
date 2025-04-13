abstract class ForgotPasswordEvent {}

class SendResetLinkEvent extends ForgotPasswordEvent {
  final String email;
  SendResetLinkEvent(this.email);
}
