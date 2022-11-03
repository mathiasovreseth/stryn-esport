import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.oldPassword = "",
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = "",
  });

  final String oldPassword;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String errorMessage;

  @override
  List<Object> get props =>
      [oldPassword, password, confirmedPassword, status, errorMessage];

  ChangePasswordState copyWith({
    String? oldPassword,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
