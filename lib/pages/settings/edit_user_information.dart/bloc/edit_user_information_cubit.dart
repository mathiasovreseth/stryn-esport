import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';
import 'package:stryn_esport/pages/settings/edit_user_information.dart/bloc/edit_user_information_state.dart';

import 'package:stryn_esport/repositories/auth_repository.dart';

class EditUserInformationCubit extends Cubit<EditUserInformationState> {
  EditUserInformationCubit(
      {required this.authenticationRepository, required this.user})
      : super(EditUserInformationState(
            firstName: Name.dirty(user.firstName!),
            lastName: Name.dirty(user.lastName!),
            phoneNumber: PhoneNumber.dirty(user.phoneNumber!),
            age: DateTime.fromMillisecondsSinceEpoch(
                user.age!.millisecondsSinceEpoch),
            address: Address.dirty(user.address!),
            postNumber: PostNumber.dirty(user.postNumber!)));

  final AuthenticationRepository authenticationRepository;
  final MyUser user;

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
