import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

import '../../../loginPage/utils/validation_config.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authenticationRepository) : super(const ForgotPasswordState());

  final AuthenticationRepository _authenticationRepository;

  void emailChange(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email,]),
      ),
    );
  }
  //TODO: add on Submit
}