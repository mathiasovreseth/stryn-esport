import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../loginPage/utils/validation_config.dart';

enum ConfirmPasswordValidationError {invalid}
class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final FormzStatus status;

  @override
  List<Object> get props => [email, status];

  ForgotPasswordState copyWith({
    Email? email,
    FormzStatus? status,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

}