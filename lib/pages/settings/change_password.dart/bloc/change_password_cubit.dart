import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/bloc/change_password_state.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

/// Contains events and state for the change password page
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._authenticationRepository, this._user)
      : super(const ChangePasswordState());

  final AuthenticationRepository _authenticationRepository;
  final MyUser _user;

  void oldPasswordChanged(String value) {
    emit(
      state.copyWith(
        oldPassword: value,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([password, state.confirmedPassword]),
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([state.password, confirmedPassword]),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    await _reAuthenticate();
    await _changePassword();
  }

  Future<void> _reAuthenticate() async {
    final AuthCredential credential = EmailAuthProvider.credential(
      email: _user.email!,
      password: state.oldPassword,
    );
    try {
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          errorMessage: _authErrorCodeToText(e),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> _changePassword() async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(state.password.value);

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          errorMessage: _authErrorCodeToText(e),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  String _authErrorCodeToText(e) {
    switch (e.code) {
      case 'user-mismatch':
        return 'Feil passord';
      case 'wrong-password':
        return 'Feil passord';
      default:
        return "Ukjent feil ved autentisering";
    }
  }

  String _changePasswordErrorCodeToText(e) {
    switch (e.code) {
      case 'weak-password':
        return 'For svakt passord';

      case 'requires-recent-login':
        return 'OOPSS. Logg ut og inn av applikasjonen og prøv igjen';
      default:
        return "Ukjent feil ved endring av pass";
    }
  }
}
// To be able to change password the user must reAutenticate. This is a Firebase rule.

/*
Future<void> changePassword() async {
  const snackOK = SnackBar(
    content: Text(
      "Your password was successfully updated!",
      style: TextStyle(color: Colors.green),
    ),
    duration: Duration(seconds: 15),
  );
  try {
    final AuthCredential credential = EmailAuthProvider.credential(
      email: FirebaseAuth.instance.currentUser!.email!,
      password: _oldPassword,
    );
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential);
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(_password);
      ScaffoldMessenger.of(context).showSnackBar(snackOK);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        _showSecurityDialog(context);
      }
    }
  } on FirebaseException catch (e) {
    String errorMessage = "";
    switch (e.code) {
      case 'user-mismatch':
        errorMessage = "Old password is incorrect";
        break;
      case 'invalid-credential':
        errorMessage = "Unknown error";
        break;
      case 'wrong-password':
        errorMessage = "Old password is incorrect";
        break;
      default:
        errorMessage = "Unknown error, please try again later";
    }
    SnackBar snackError = SnackBar(
      content: Text(
        errorMessage,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 15),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackError);
  }
}
*/
