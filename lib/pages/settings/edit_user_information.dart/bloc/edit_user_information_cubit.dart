import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';
import 'package:stryn_esport/pages/settings/edit_user_information.dart/bloc/edit_user_information_state.dart';

import 'package:stryn_esport/repositories/auth_repository.dart';
import 'package:stryn_esport/repositories/user_repository.dart';

class EditUserInformationCubit extends Cubit<EditUserInformationState> {
  EditUserInformationCubit(
      {required this.userRepository, required this.user})
      : super(EditUserInformationState(
            firstName: Name.dirty(user.firstName!),
            lastName: Name.dirty(user.lastName!),
            phoneNumber: PhoneNumber.dirty(user.phoneNumber!),
            age: DateTime.fromMillisecondsSinceEpoch(
                user.age!.millisecondsSinceEpoch),
            address: Address.dirty(user.address!),
            postNumber: PostNumber.dirty(user.postNumber!)));

  final UserRepository userRepository;
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
      UpdatedUser updatedUser = UpdatedUser(
          id: user.id,
          address: state.address.value,
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          phoneNumber: state.phoneNumber.value,
          age: state.age!,
          postNumber: state.postNumber.value
      );
      await userRepository.editUser(updatedUser: updatedUser);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: "Failed to update information",
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
