import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';
import 'package:stryn_esport/pages/registration/stageTwo/bloc/registration_stage_two_state.dart';

import 'package:stryn_esport/repositories/auth_repository.dart';


class RegistrationStageTwoCubit extends Cubit<RegistrationStageTwoState> {
  RegistrationStageTwoCubit({required this.authenticationRepository, required this.email, required this.password}) : super(const RegistrationStageTwoState());
  final String email;
  final String password;
  final AuthenticationRepository authenticationRepository;

  void firstNameChange(String value) {
    final firstName = Name.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        status: Formz.validate([
          firstName,
          state.lastName,
          state.phoneNumber,
          state.address,
          state.postNumber
        ]),
      ),
    );
  }
  void lastNameChange(String value) {
    final lastName = Name.dirty(value);
    emit(
      state.copyWith(
        lastName: lastName,
        status: Formz.validate([
          state.firstName,
          lastName,
          state.phoneNumber,
          state.address,
          state.postNumber
        ]),
      ),
    );
  }
  void phoneNumberChange(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([
          state.firstName,
          state.lastName,
          phoneNumber,
          state.address,
          state.postNumber
        ]),
      ),
    );
  }
  void ageChange(DateTime value) {
    emit(
      state.copyWith(
        age: value,
        status: Formz.validate([
          state.firstName,
          state.lastName,
          state.phoneNumber,
          state.address,
          state.postNumber
        ]),
      ),
    );
  }
  void addressChange(String value) {
    final address = Address.dirty(value);
    emit(
      state.copyWith(
        address: address,
        status: Formz.validate([
          state.firstName,
          state.lastName,
          state.phoneNumber,
          address,
          state.postNumber
        ]),
      ),
    );
  }
  void postNumberChange(String value) {
    final postNumber = PostNumber.dirty(value);
    emit(
      state.copyWith(
        postNumber: postNumber,
        status: Formz.validate([
          state.firstName,
          state.lastName,
          state.phoneNumber,
          state.address,
          postNumber
        ]),
      ),
    );
  }


  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.signUp(
        email: email,
        password: password,
        postNmbr: state.postNumber.value,
        age: state.age!,
        phoneNbr: state.phoneNumber.value,
        lastName: state.lastName.value,
        firstName: state.firstName.value,
        address: state.address.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
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