
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';



enum ConfirmPasswordValidationError { invalid }

class RegistrationStageOneState extends Equatable {
  const RegistrationStageOneState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  RegistrationStageOneState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegistrationStageOneState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}