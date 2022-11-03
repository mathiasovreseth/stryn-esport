import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/bloc/change_password_state.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._authenticationRepository)
      : super(const ChangePasswordState());

  final AuthenticationRepository _authenticationRepository;

  void oldPasswordChanged(String value) {
    emit(
      state.copyWith(
        oldPassword: value,
        status: Formz.validate([
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.confirmedPassword]),
      ),
    );
  }

   void confirmPasswordChanged(String value) {
    final password = ConfirmedPassword.dirty( password: value);
    emit(
      state.copyWith(
        confirmedPassword: password,
        status: Formz.validate([
          state.password,
          password
        ]),
      ),
    );
  }

  Future<void> changePassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
     
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
  
// Future<void> changePassword() async {
const snackOK = SnackBar(
  content: Text(
    "Your password was successfully updated!",
    style: TextStyle(color: Colors.green),
  ),
  duration: Duration(seconds: 15),
);
try {
  final AuthCredential  credential = EmailAuthProvider.credential(
    email: FirebaseAuth.instance.currentUser!.email!,
    password: _oldPassword,
  );
  await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
  try {
    await FirebaseAuth.instance.currentUser!.updatePassword(_password);
    ScaffoldMessenger.of(context).showSnackBar(snackOK);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      _showSecurityDialog(context);
    }
  }

} on FirebaseException catch (e)  {
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