import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendResetLinkEvent>(_onSendResetLink);
  }

  Future<void> _onSendResetLink(
    SendResetLinkEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    if (event.email.contains('@')) {
      emit(ForgotPasswordSuccess());
    } else {
      emit(ForgotPasswordError('حدث خطأ أثناء إرسال الرابط'));
    }
  }
}
